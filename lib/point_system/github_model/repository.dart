import 'github_user.dart';
import 'license.dart';
import 'repository_permissions.dart';

class Repository {
  int? id;

  int? size;

  String? name;

  String? fullName;

  String? htmlUrl;

  String? description;

  String? language;

  String? defaultBranch;

  DateTime? createdAt;

  DateTime? updatedAt;

  DateTime? pushedAt;

  String? gitUrl;

  String? sshUrl;

  String? cloneUrl;

  String? svnUrl;

  int? stargazersCount;

  int? watchersCount;

  int? forksCount;

  int? openIssuesCount;

  int? subscribersCount;

  bool? private;

  bool? fork;

  bool? hasIssues;

  bool? hasProjects;

  bool? hasDownloads;

  bool? hasWiki;

  bool? hasPages;

  GithubUser? owner;

  License? license;

  Repository? parent;

  RepositoryPermissions? permissions;

  List<String>? topics;

  int? allIssueCount;

  Repository(
    this.id,
    this.size,
    this.name,
    this.fullName,
    this.htmlUrl,
    this.description,
    this.language,
    this.license,
    this.defaultBranch,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
    this.stargazersCount,
    this.watchersCount,
    this.forksCount,
    this.openIssuesCount,
    this.subscribersCount,
    this.private,
    this.fork,
    this.hasIssues,
    this.hasProjects,
    this.hasDownloads,
    this.hasWiki,
    this.hasPages,
    this.owner,
    this.parent,
    this.permissions,
    this.topics,
  );

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        json['id'] as int?,
        json['size'] as int?,
        json['name'] as String?,
        json['full_name'] as String?,
        json['html_url'] as String?,
        json['description'] as String?,
        json['language'] as String?,
        json['license'] == null
            ? null
            : License.fromJson(json['license'] as Map<String, dynamic>),
        json['default_branch'] as String?,
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        json['pushed_at'] == null
            ? null
            : DateTime.parse(json['pushed_at'] as String),
        json['git_url'] as String?,
        json['ssh_url'] as String?,
        json['clone_url'] as String?,
        json['svn_url'] as String?,
        json['stargazers_count'] as int?,
        json['watchers_count'] as int?,
        json['forks_count'] as int?,
        json['open_issues_count'] as int?,
        json['subscribers_count'] as int?,
        json['private'] as bool?,
        json['fork'] as bool?,
        json['has_issues'] as bool?,
        json['has_projects'] as bool?,
        json['has_downloads'] as bool?,
        json['has_wiki'] as bool?,
        json['has_pages'] as bool?,
        json['owner'] == null
            ? null
            : GithubUser.fromJson(json['owner'] as Map<String, dynamic>),
        json['parent'] == null
            ? null
            : Repository.fromJson(json['parent'] as Map<String, dynamic>),
        json['permissions'] == null
            ? null
            : RepositoryPermissions.fromJson(
                json['permissions'] as Map<String, dynamic>),
        (json['topics'] as List?)?.map((e) => e as String).toList(),
      )..allIssueCount = json['allIssueCount'] as int?;

  @override
  String toString() {
    return 'Repository{id: $id, size: $size, name: $name, fullName: $fullName, htmlUrl: $htmlUrl, description: $description, language: $language, defaultBranch: $defaultBranch, createdAt: $createdAt, updatedAt: $updatedAt, pushedAt: $pushedAt, gitUrl: $gitUrl, sshUrl: $sshUrl, cloneUrl: $cloneUrl, svnUrl: $svnUrl, stargazersCount: $stargazersCount, watchersCount: $watchersCount, forksCount: $forksCount, openIssuesCount: $openIssuesCount, subscribersCount: $subscribersCount, private: $private, fork: $fork, hasIssues: $hasIssues, hasProjects: $hasProjects, hasDownloads: $hasDownloads, hasWiki: $hasWiki, hasPages: $hasPages, owner: $owner, license: $license, parent: $parent, permissions: $permissions, topics: $topics, allIssueCount: $allIssueCount}';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'size': size,
        'name': name,
        'full_name': fullName,
        'html_url': htmlUrl,
        'description': description,
        'language': language,
        'default_branch': defaultBranch,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'pushed_at': pushedAt?.toIso8601String(),
        'git_url': gitUrl,
        'ssh_url': sshUrl,
        'clone_url': cloneUrl,
        'svn_url': svnUrl,
        'stargazers_count': stargazersCount,
        'watchers_count': watchersCount,
        'forks_count': forksCount,
        'open_issues_count': openIssuesCount,
        'subscribers_count': subscribersCount,
        'private': private,
        'fork': fork,
        'has_issues': hasIssues,
        'has_projects': hasProjects,
        'has_downloads': hasDownloads,
        'has_wiki': hasWiki,
        'has_pages': hasPages,
        'owner': owner,
        'license': license,
        'parent': parent,
        'permissions': permissions,
        'topics': topics,
        'allIssueCount': allIssueCount,
      };

  Repository.empty();
}
