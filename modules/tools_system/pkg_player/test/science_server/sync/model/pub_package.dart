class PubPackage {
  final String name;
  final String? description;
  final String? homepage;
  final String? repository;
  final List<String> tags;
  final String latestVersion;
  final DateTime updatedAt;

  PubPackage({
    required this.name,
    this.description,
    this.homepage,
    this.repository,
    required this.tags,
    required this.latestVersion,
    required this.updatedAt,
  });

  factory PubPackage.fromJson(Map<String, dynamic> json) {
    return PubPackage(
      name: json['name'],
      description: json['description'],
      homepage: json['homepage'],
      repository: json['repository'],
      tags: List<String>.from(json['tags'] ?? []),
      latestVersion: json['latest']['version'],
      updatedAt: DateTime.parse(json['updated']),
    );
  }
}

class PackageVersion {
  final String version;
  final DateTime published;
  final Map<String, String> dependencies;

  PackageVersion({
    required this.version,
    required this.published,
    required this.dependencies,
  });

  factory PackageVersion.fromJson(Map<String, dynamic> json) {
    return PackageVersion(
      version: json['version'],
      published: DateTime.parse(json['published']),
      dependencies: Map<String, String>.from(json['pubspec']['dependencies'] ?? {}),
    );
  }
}

class PackageScore {
  final int? grantedPoints;
  final int? maxPoints;
  final double? likeCount;
  final double? popularityScore;

  PackageScore({
    this.grantedPoints,
    this.maxPoints,
    this.likeCount,
    this.popularityScore,
  });

  factory PackageScore.fromJson(Map<String, dynamic> json) {
    return PackageScore(
      grantedPoints: json['grantedPoints'],
      maxPoints: json['maxPoints'],
      likeCount: json['likeCount']?.toDouble(),
      popularityScore: json['popularityScore']?.toDouble(),
    );
  }
}

class SearchResult {
  final List<PubPackage> packages;
  final String? next;

  SearchResult({
    required this.packages,
    this.next,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      packages: (json['packages'] as List)
          .map((p) => PubPackage.fromJson(p))
          .toList(),
      next: json['next'],
    );
  }
}