class PackageDetail {
  final String name;
  final String? description;
  final String? homepage;
  final String? repository;
  final String? documentation;
  final List<String> tags;
  final String latestVersion;
  final DateTime updatedAt;
  final List<String> authors;
  final String? license;
  final Map<String, String> dependencies;
  final Map<String, String> devDependencies;
  final Environment environment;
  final Publisher? publisher;

  PackageDetail({
    required this.name,
    this.description,
    this.homepage,
    this.repository,
    this.documentation,
    required this.tags,
    required this.latestVersion,
    required this.updatedAt,
    required this.authors,
    this.license,
    required this.dependencies,
    required this.devDependencies,
    required this.environment,
    this.publisher,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) {
    final latest = json['latest'];
    final pubspec = latest['pubspec'];
    
    return PackageDetail(
      name: json['name'],
      description: json['description'],
      homepage: json['homepage'],
      repository: json['repository'],
      documentation: json['documentation'],
      tags: List<String>.from(json['tags'] ?? []),
      latestVersion: latest['version'],
      updatedAt: DateTime.parse(json['advisoriesUpdated']),
      authors: List<String>.from(pubspec['authors'] ?? []),
      license: pubspec['license'],
      dependencies: Map<String, String>.from(pubspec['dependencies'] ?? {}),
      devDependencies: Map<String, String>.from(pubspec['dev_dependencies'] ?? {}),
      environment: Environment.fromJson(pubspec['environment'] ?? {}),
      publisher: json['publisher'] != null ? Publisher.fromJson(json['publisher']) : null,
    );
  }
}

class Environment {
  final String? sdk;
  final String? flutter;

  Environment({this.sdk, this.flutter});

  factory Environment.fromJson(Map<String, dynamic> json) {
    return Environment(
      sdk: json['sdk'],
      flutter: json['flutter'],
    );
  }
}

class Publisher {
  final String publisherId;
  final String description;

  Publisher({
    required this.publisherId,
    required this.description,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      publisherId: json['publisherId'],
      description: json['description'],
    );
  }
}

class PackageMetrics {
  final int downloadCount;
  final int downloadCount30Days;
  final int likeCount;
  final double popularityScore;
  final int pubPoints;

  PackageMetrics({
    required this.downloadCount,
    required this.downloadCount30Days,
    required this.likeCount,
    required this.popularityScore,
    required this.pubPoints,
  });

  factory PackageMetrics.fromJson(Map<String, dynamic> json) {
    return PackageMetrics(
      downloadCount: json['downloadCount'] ?? 0,
      downloadCount30Days: json['downloadCount30Days'] ?? 0,
      likeCount: json['likeCount'] ?? 0,
      popularityScore: (json['popularityScore'] ?? 0.0).toDouble(),
      pubPoints: json['pubPoints'] ?? 0,
    );
  }
}