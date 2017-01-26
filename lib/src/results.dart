part of dart_analyser_client.snapshot;

/// server.getVersion result
class ServerGetVersionResult {
  String _version;

  /// The version number of the analysis server.
  String get version => _version;
  void set version(String value) {
    assert(value != null);
    this._version = value;
  }

  ServerGetVersionResult(String version) {
    this.version = version;
  }

  factory ServerGetVersionResult.fromJson(Map json) {
    String version = json['version'];
    return new ServerGetVersionResult(version);
  }
}

class Location {
  String file;

  int offset;

  int length;

  int startLine;

  int startColumn;

  Location(
      this.file, this.offset, this.length, this.startLine, this.startColumn);

  factory Location.fromJson(Map map) {
    String file;
    {
      dynamic value = map['file'];
      if (value is String) file = value;
    }
    int offset;
    {
      dynamic value = map['offset'];
      if (value is int) offset = value;
    }
    int length;
    {
      dynamic value = map['length'];
      if (value is int) length = value;
    }
    int startLine;
    {
      dynamic value = map['startLine'];
      if (value is int) startLine = value;
    }
    int startColumn;
    {
      dynamic value = map['startColumn'];
      if (value is int) startColumn = value;
    }

    return new Location(file, offset, length, startLine, startColumn);
  }
}

class AnalysisError {
  String severity;

  String type;

  Location location;

  String message;

  String correction;

  String code;

  bool hasFix;

  AnalysisError(this.severity, this.type, this.location, this.message,
      this.correction, this.code, this.hasFix);

  factory AnalysisError.fromJson(Map map) {
    String severity;
    {
      dynamic value = map['severity'];
      if (value is String) severity = value;
    }
    String type;
    {
      dynamic value = map['type'];
      if (value is String) type = value;
    }
    Location location;
    {
      dynamic value = map['location'];
      if (value is Map) location = new Location.fromJson(value);
    }
    String message;
    {
      dynamic value = map['message'];
      if (value is String) message = value;
    }
    String correction;
    {
      dynamic value = map['correction'];
      if (value is String) message = value;
    }
    String code;
    {
      dynamic value = map['code'];
      if (value is String) code = value;
    }
    bool hasFix;
    {
      dynamic value = map['hasFix'];
      if (value is bool) hasFix = value;
    }

    return new AnalysisError(
        severity, type, location, message, correction, code, hasFix);
  }
}

/// analysis.getErrors result
class GetErrorsResult {
  final List<AnalysisError> _errors = [];

  List<AnalysisError> get errors => _errors;
  void set errors(List<AnalysisError> value) {
    _errors.clear();
    if (value == null) return;
    _errors.addAll(value);
  }

  GetErrorsResult(List<AnalysisError> errors) {
    this.errors = errors;
  }

  factory GetErrorsResult.fromJson(Map json) {
    List<AnalysisError> version = json['version'];
    return new GetErrorsResult(version);
  }
}

class NavigationTarget {}

class NavigationRegion {}

class GetNavigationResult {
  final List<String> _files = [];

  List<String> get files => _files;
  set files(List<String> value) {
    _files.clear();
    if (value is! List) return;
    _files.addAll(value);
  }

  final List<NavigationTarget> _targets = [];

  List<NavigationTarget> get targets => _targets;
  set targets(List<NavigationTarget> value) {
    _targets.clear();
    if (value is! List) return;
    _targets.addAll(value);
  }

  final List<NavigationRegion> _regions = [];

  List<NavigationRegion> get regions => _regions;
  set regions(List<NavigationRegion> value) {
    _regions.clear();
    if (value is! List) return;
    _regions.addAll(value);
  }

  GetNavigationResult(List<String> files, List<NavigationTarget> targets,
      List<NavigationRegion> regions) {
    this.files = files;
    this.targets = targets;
    this.regions = regions;
  }

  factory GetNavigationResult.fromJson(Map map) {
    List<String> files;
    {
      dynamic value = map['files'];
      if (value is List) files = value;
    }
    List<NavigationTarget> targets;
    {
      dynamic value = map['targets'];
      if (value is List) targets = value;
    }
    List<NavigationRegion> regions;
    {
      dynamic value = map['regions'];
      if (value is List) regions = value;
    }
    return new GetNavigationResult(files, targets, regions);
  }
}

class HoverInformation {
  /// The offset of the range of characters that encompasses the cursor position
  /// and has the same hover information as the cursor position.
  int offset;

  /// The length of the range of characters that encompasses the cursor position
  /// and has the same hover information as the cursor position.
  int length;

  /// The path to the defining compilation unit of the library in which the
  /// referenced element is declared. This data is omitted if there is no
  /// referenced element, or if the element is declared inside an HTML file.
  String containingLibraryPath;

  /// The name of the library in which the referenced element is declared. This
  /// data is omitted if there is no referenced element, or if the element is
  /// declared inside an HTML file.
  String containingLibraryName;

  /// A human-readable description of the class declaring the element being
  /// referenced. This data is omitted if there is no referenced element, or if
  /// the element is not a class member.
  String containingClassDescription;

  /// The dartdoc associated with the referenced element. Other than the removal
  /// of the comment delimiters, including leading asterisks in the case of a
  /// block comment, the dartdoc is unprocessed markdown. This data is omitted
  /// if there is no referenced element, or if the element has no dartdoc.
  String dartdoc;

  /// A human-readable description of the element being referenced. This data is
  /// omitted if there is no referenced element.
  String elementDescription;

  /// A human-readable description of the kind of element being referenced
  /// (such as “class” or “function type alias”). This data is omitted if there
  /// is no referenced element.
  String elementKind;

  /// True if the referenced element is deprecated.
  bool isDeprecated;

  /// A human-readable description of the parameter corresponding to the
  /// expression being hovered over. This data is omitted if the location is not
  /// in an argument to a function.
  String parameter;

  /// The name of the propagated type of the expression. This data is omitted
  /// if the location does not correspond to an expression or if there is no
  /// propagated type information.
  String propagatedType;

  /// The name of the static type of the expression. This data is omitted if the
  /// location does not correspond to an expression.
  String staticType;

  HoverInformation();

  factory HoverInformation.fromJson(Map map) {
    final ret = new HoverInformation();

    {
      dynamic value = map['offset'];
      if (value is int) ret.offset = value;
    }
    {
      dynamic value = map['length'];
      if (value is int) ret.length = value;
    }
    {
      dynamic value = map['containingLibraryPath'];
      if (value is String) ret.containingLibraryPath = value;
    }
    {
      dynamic value = map['containingLibraryName'];
      if (value is String) ret.containingLibraryName = value;
    }
    {
      dynamic value = map['containingClassDescription'];
      if (value is String) ret.containingClassDescription = value;
    }
    {
      dynamic value = map['dartdoc'];
      if (value is String) ret.dartdoc = value;
    }
    {
      dynamic value = map['elementDescription'];
      if (value is String) ret.elementDescription = value;
    }
    {
      dynamic value = map['elementKind'];
      if (value is String) ret.elementKind = value;
    }
    {
      dynamic value = map['isDeprecated'];
      if (value is bool) ret.isDeprecated = value;
    }
    {
      dynamic value = map['parameter'];
      if (value is String) ret.parameter = value;
    }
    {
      dynamic value = map['propagatedType'];
      if (value is String) ret.propagatedType = value;
    }
    {
      dynamic value = map['staticType'];
      if (value is String) ret.staticType = value;
    }

    return ret;
  }
}

class GetHoverResult {
  final List<HoverInformation> _hovers = [];

  List<HoverInformation> get hovers => _hovers;
  set hovers(List<HoverInformation> value) {
    _hovers.clear();
    if (value is! List) return;
    _hovers.addAll(value);
  }

  GetHoverResult(List<HoverInformation> hovers) {
    this.hovers = hovers;
  }

  factory GetHoverResult.fromJson(Map map) {
    List<HoverInformation> hovers;
    {
      dynamic value = map['hovers'];
      if (value is List)
        hovers =
            value.map((Map map) => new HoverInformation.fromJson(map)).toList();
    }
    return new GetHoverResult(hovers);
  }
}

class CompletionSuggestion {

}

class GetSuggestionResult {
  int replacementOffset = 0;

  int replacementLength = 0;

  final List<CompletionSuggestion> results = [];

  GetSuggestionResult();

  factory GetSuggestionResult.fromJson(Map map) {
    final ret = new GetSuggestionResult();
    {
      dynamic value = map['replacementOffset'];
      if(value is int) ret.replacementOffset = value;
    }
    {
      dynamic value = map['replacementLength'];
      if(value is int) ret.replacementLength = value;
    }
    {
      dynamic value = map['results'];
      if(value is int) ret.results = value;
    }

    return ret;
  }
}
