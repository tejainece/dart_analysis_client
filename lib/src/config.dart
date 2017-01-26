library dart_analysis_client.config;

import 'dart:io';
import 'package:path/path.dart' as path;

/// Data class that contains analyzer configuration
class AnalyzerConfig {
  /// Should checked mode be used?
  final bool useChecked;

  /// Should diagnostics be enabled?
  final bool startWithDiagnostics;

  /// [Directory] od Dart SDK base
  final Directory directory;

  /// Path of Dart SDK base
  String get sdkPath => directory.path;

  AnalyzerConfig(this.directory,
      {this.useChecked: false, this.startWithDiagnostics: false});

  /// Binary
  String get dartVMPath {
    String exeName = 'dart';
    if (Platform.isWindows) {
      exeName += '.exe';
    }
    return path.join(sdkPath, 'bin', exeName);
  }

  String getSnapshotPath(String snapshotName) =>
      path.join(sdkPath, 'bin', 'snapshots', snapshotName);

  String getAnalysisServerSnapshotPath() =>
      getSnapshotPath(analysisServerSnapshotName);

  static const String analysisServerSnapshotName =
      'analysis_server.dart.snapshot';

  static const int diagnosticsPort = 23072;
}
