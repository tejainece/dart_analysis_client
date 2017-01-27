library main;

import 'dart:io';
import 'package:dart_analysis_client/dart_analysis_client.dart';

main() async {
  Directory dir = new Directory('C:\\Program Files\\Dart\\dart-sdk');
  if (!dir.existsSync()) {
    throw new Exception("Dart SDK dir does not exist!");
  }
  final config = new AnalyzerConfig(dir);

  final server = new AnalysisServer(config);
  await server.start();
  print((await server.getVersion()).toJson());
  exit(0);
}
