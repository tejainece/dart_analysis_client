// Copyright (c) 2017, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dart_analyser_client.snapshot;

import 'dart:io';
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:logging/logging.dart';

import 'config.dart';
import 'models/models.dart';

export 'config.dart';
export 'models/models.dart';

part 'params.dart';
part 'results.dart';

final Logger _logger = new Logger('analysis_server');

class AnalysisServer {
  final AnalyzerConfig config;

  Process _process;

  StreamSubscription<String> _inStreamSub;

  /// Commands that have been sent to the server but not yet acknowledged, and
  /// the [Completer] objects which should be completed when acknowledgement is
  /// received.
  final HashMap<String, Completer> _pendingCommands = <String, Completer>{};

  /// Number which should be used to compute the 'id' to send in the next
  /// command sent to the server.
  int _nextId = 0;

  AnalysisServer(this.config);

  bool get isRunning => _process != null;

  Future<Null> start() async {
    if (isRunning) {
      throw new Exception("Analyzer already running!");
    }
    _process = await _createProcess(config);
    _inStreamSub = _process.stdout
        .transform((new Utf8Codec()).decoder)
        .transform(new LineSplitter())
        .transform(new StreamTransformer.fromHandlers(
            handleData: (String data, EventSink<String> sink) {
      sink.add(data.trim());
    })).listen(_processInMsg);
  }

  Future<Map> _send(String method, ToJsonable params) {
    _logger.fine("Server.send $method");

    String id = '${_nextId++}';
    Map<String, dynamic> command = <String, dynamic>{
      'id': id,
      'method': method
    };
    if (params != null) {
      command['params'] = params.toJson();
    }
    Completer completer = new Completer();
    _pendingCommands[id] = completer;
    String line = JSON.encode(command);
    _process.stdin.add(UTF8.encoder.convert("$line\n"));
    return completer.future;
  }

  /// Restarts, or starts, the analysis server process.
  Future<Null> restart() async {
    if (isRunning) {
      await kill();
    }

    await start();
  }

  Future<Null> kill() async {
    if (isRunning) {
      _process.kill();
      _process = null;
      if (_inStreamSub is StreamSubscription) _inStreamSub.cancel();
    }
  }

  void _processInMsg(String line) {
    Map message;
    try {
      dynamic decoded = JSON.decoder.convert(line);
      if (decoded is Map) {
        message = decoded;
      } else if (decoded != null) {
        throw new Exception("Result should be a Map");
      }
    } catch (exception) {
      _logger.severe("Bad data from server");
      return;
    }

    if (message.containsKey('id')) {
      final String id = message['id'];
      Completer completer = _pendingCommands[id];
      if (completer == null) {
        print('Unexpected response from server: id=$id');
      } else {
        _pendingCommands.remove(id);
      }
      if (message.containsKey('error')) {
        // TODO(paulberry): propagate the error info to the completer.
        kill();
        completer.completeError(new UnimplementedError(
            'Server responded with an error: ${JSON.encode(message)}'));
      } else {
        completer.complete(message['result']);
      }
    } else {
      // Message is a notification.  It should have an event and possibly
      // params.
      // TODO implement event notification
      // TODO notificationProcessor(messageAsMap['event'], messageAsMap['params']);
    }
  }

  static Future<Process> _createProcess(AnalyzerConfig config) {
    List<String> arguments = <String>[];

    if (config.useChecked) {
      arguments.add('--checked');
    }

    if (config.startWithDiagnostics) {
      arguments.add('--enable-vm-service=0');
    }

    arguments.add(config.getAnalysisServerSnapshotPath());

    arguments.add('--sdk=${config.sdkPath}');

    // Check to see if we should start with diagnostics enabled.
    if (config.startWithDiagnostics) {
      arguments.add('--port=${AnalyzerConfig.diagnosticsPort}');
    }

    arguments.add('--client-id=icu');

    return Process.start(config.dartVMPath, arguments);
  }

  Future<VersionResponse> getVersion() async {
    final String method = "server.getVersion";
    Map result = await _send(method, null);
    final ver = new ServerGetVersionResult.fromJson(result);
    final ret = new VersionResponse();
    ret.analysisServer = ver._version;
    return ret;
  }

  Future<Null> setProjectRoots(final List<String> included,
      {final List<String> excluded,
      final Map<String, String> packageRoots}) async {
    final String method = 'analysis.setAnalysisRoots';
    final param = new SetAnalysisRootsParams(included,
        excluded: excluded, packageRoots: packageRoots);
    await _send(method, param);
  }

  Future setPriorityFiles(List<String> files) async {
    final String method = 'analysis.setPriorityFiles';
    final param = new SetPriorityFilesParams(files);
    await _send(method, param);
  }

  Future updateFileContent(Map<String, ContentOverlay> files) async {
    final String method = 'analysis.updateContent';
    final param = new UpdateContentParams(files);
    await _send(method, param);
  }

  Future updateFileContentAdd(String filename, String content) async {
    await updateFileContent(
        <String, ContentOverlay>{filename: new AddContentOverlay(content)});
  }

  Future<GetErrorsResult> getErrors(String filename) async {
    final String method = 'analysis.getErrors';
    final param = new GetErrorsParams(filename);
    Map result = await _send(method, param);
    return new GetErrorsResult.fromJson(result);
  }

  //TODO get all errors?

  Future<GetNavigationResult> getNavigation(String filename, int offset, int length) async {
    final String method = 'analysis.getNavigation';
    final param = new GetNavigationParams(filename, offset, length);
    Map result = await _send(method, param);
    return new GetNavigationResult.fromJson(result);
  }

  Future<GetHoverResult> getHover(String filename, int offset) async {
    final String method = 'analysis.getHover';
    final param = new GetHoverParams(filename, offset);
    Map result = await _send(method, param);
    return new GetHoverResult.fromJson(result);
  }

  Future getSuggestions(String filename, int offset) async {
    final String method = 'completion.getSuggestions';
    //TODO
  }
}
