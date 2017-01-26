part of dart_analyser_client.snapshot;

abstract class ToJsonable {
  Map toJson();
}

/// Request parameters for 'analysis.setAnalysisRoots' request
class SetAnalysisRootsParams implements ToJsonable {
  /// A list of the files and directories that should be analyzed.
  final List<String> included;

  /// A list of the files and directories within the included directories that
  /// should not be analyzed.
  final List<String> excluded;

  /// A mapping from source directories to package roots that should override
  /// the normal package: URI resolution mechanism.
  final Map<String, String> packageRoots;

  SetAnalysisRootsParams(this.included, {this.excluded, this.packageRoots});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (included != null) {
      json["included"] = included;
    }

    if (excluded != null) {
      json["excluded"] = excluded;
    }

    if (packageRoots != null) {
      json["packageRoots"] = packageRoots;
    }

    return json;
  }
}

/// Request parameters for 'analysis.setPriorityFiles' request
class SetPriorityFilesParams implements ToJsonable {
  /// A list of the files and directories that should be analyzed.
  final List<String> files;

  SetPriorityFilesParams(this.files);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (files != null) {
      json["files"] = files;
    }

    return json;
  }
}

/// Request parameters for 'analysis.updateContent' request
class UpdateContentParams implements ToJsonable {
  /// A list of the files and directories that should be analyzed.
  final Map<String, ContentOverlay> files;

  UpdateContentParams(this.files);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (files != null) {
      json["files"] =
          files.keys.fold(<String, Map>{}, (Map<String, Map> map, String key) {
        map[key] = files[key].toJson();
        return map;
      });
    }

    return json;
  }
}

abstract class ContentOverlay implements ToJsonable {}

class AddContentOverlay implements ContentOverlay {
  final String type = "add";

  /// The new content of the file.
  final String content;

  AddContentOverlay(this.content);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{"type": type};

    if (content != null) {
      map["content"] = content;
    }

    return map;
  }
}

/// Request parameters for 'analysis.getErrors' request
class GetErrorsParams implements ToJsonable {
  /// The file to get errors for.
  final String file;

  GetErrorsParams(this.file);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (file != null) {
      json["file"] = file;
    }

    return json;
  }
}

/// Request parameters for 'analysis.getNavigation' request
class GetNavigationParams implements ToJsonable {
  /// The file in which navigation information is being requested.
  final String file;

  /// The offset of the region for which navigation information is being
  /// requested.
  final int offset;

  /// The length of the region for which navigation information is being
  /// requested.
  final int length;

  GetNavigationParams(this.file, this.offset, this.length);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (file != null) {
      json["file"] = file;
    }

    if (offset != null) {
      json["offset"] = offset;
    }

    if (length != null) {
      json["length"] = length;
    }

    return json;
  }
}

/// Request parameters for 'analysis.getHover' request
class GetHoverParams implements ToJsonable {
  /// The file in which hover information is being requested.
  final String file;

  /// The offset for which hover information is being requested.
  final int offset;

  GetHoverParams(this.file, this.offset);

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    if (file != null) {
      json["file"] = file;
    }

    if (offset != null) {
      json["offset"] = offset;
    }

    return json;
  }
}