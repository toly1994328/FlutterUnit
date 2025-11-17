class PluginModel {
  final String name;
  final String lastVersion;
  final String lastPublish;
  final Statistics statistics;
  final List<String> tags;
  final Map<String, dynamic>? dependencies;

  List<String> get platforms =>
      tags.where((e) => e.startsWith('platform:')).toList();
  List<String> get sdks =>
      tags.where((e) => e.startsWith('sdk:')).toList();

  List<String> get license =>
      tags.where((e) => e.startsWith('license:')).toList();
  final String? desc;
  final String? publisher;
  final String? repository;
  final String? homepage;
  final List<String> topics;

  PluginModel({
    required this.name,
    required this.lastVersion,
    required this.lastPublish,
    required this.statistics,
    required this.tags,
    required this.desc,
    required this.publisher,
    required this.repository,
    required this.homepage,
    required this.topics,
    required this.dependencies,
  });

  factory PluginModel.fromJson(Map<String, dynamic> json) {
    return PluginModel(
      name: json['name'] ?? '',
      lastVersion: json['last_version'] ?? '',
      lastPublish: json['last_publish'] ?? '',
      statistics: Statistics.fromJson(json['statistics'] ?? {}),
      tags: List<String>.from(json['tags'] ?? []),
      desc: json['desc'] ?? '',
      publisher: json['publisher'] ?? '',
      repository: json['repository'],
      homepage: json['homepage'],
      dependencies: json['dependencies'],
      topics: List<String>.from(json['topics'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_version': lastVersion,
      'last_publish': lastPublish,
      'statistics': statistics.toJson(),
      'tags': tags,
      'desc': desc,
      'dependencies': dependencies,
      'publisher': publisher,
      'homepage': homepage,
      'repository': repository,
      'topics': topics,
    };
  }
}

class Statistics {
  final int likes;
  final int points;
  final int downloads;

  Statistics({
    required this.likes,
    required this.points,
    required this.downloads,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      likes: json['likes'] ?? '',
      points: json['points'] ?? '',
      downloads: json['downloads'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'points': points,
      'downloads': downloads,
    };
  }
}
