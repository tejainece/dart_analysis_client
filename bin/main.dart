library main;

import 'dart:io';
import 'package:dart_analysis_client/dart_analysis_client.dart';

String dir = '/home/teja/projects/icompleteu/boilerplate/lib/';
String filename = '/home/teja/projects/icompleteu/boilerplate/lib/api.dart';

main() async {
  //TODO Directory dir = new Directory('C:\\Program Files\\Dart\\dart-sdk');
  Directory sdkDir = new Directory('/usr/lib/dart');
  if (!sdkDir.existsSync()) {
    throw new Exception("Dart SDK dir does not exist!");
  }
  final config = new AnalyzerConfig(sdkDir);

  final server = new AnalysisServer(config);
  await server.start();

  print((await server.getVersion()).toJson());

  await server.setProjectRoots([dir]);

  GetErrorsResult results = await server.getErrors(filename);

  //TODO exit(0);
}
