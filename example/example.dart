// Copyright (c) 2017, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library main;

import 'dart:io';
import 'package:dart_analysis_client/dart_analysis_client.dart';

const folders = const <String>[
  r'C:\Users\seragud\dart\icu\dart_analysis_client\example\data\project1\lib\src\'
];
const file =
    r'C:\Users\seragud\dart\icu\dart_analysis_client\example\data\project1\lib\src\project1_base.dart';

main() async {
  Directory dir = new Directory(r'C:\Program Files\Dart\dart-sdk');
  if (!dir.existsSync()) {
    throw new Exception("Dart SDK dir does not exist!");
  }
  final config = new AnalyzerConfig(dir);

  final server = new AnalysisServer(config);
  await server.start();

  // print version
  print((await server.getVersion()).toJson());

  // add dart files
  await server.setProjectRoots(folders);

  // add dart files
  GetNavigationResult nav = await server.getNavigation(file, 16, 30);

  GetSuggestionResult suggestions = await server.getSuggestions(file, 284);

  // print version
  print((await server.getVersion()).toJson());

  exit(0);
}
