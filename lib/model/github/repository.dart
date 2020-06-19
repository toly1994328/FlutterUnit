

import 'package:flutter_unit/model/github/github_user.dart';

import 'license.dart';
import 'repository_permissions.dart';

part 'g/repository.g.dart';

class Repository {
  int id;

  int size;

  String name;

  String fullName;


  String htmlUrl;

  String description;

  String language;


  String defaultBranch;


  DateTime createdAt;


  DateTime updatedAt;

  DateTime pushedAt;


  String gitUrl;


  String sshUrl;


  String cloneUrl;


  String svnUrl;


  int stargazersCount;


  int watchersCount;


  int forksCount;


  int openIssuesCount;


  int subscribersCount;


  bool private;

  bool fork;

  bool hasIssues;

  bool hasProjects;

  bool hasDownloads;

  bool hasWiki;

  bool hasPages;

  GithubUser owner;

  License license;

  Repository parent;

  RepositoryPermissions permissions;

  List<String> topics;

  int allIssueCount;

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

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);


  @override
  String toString() {
    return 'Repository{id: $id, size: $size, name: $name, fullName: $fullName, htmlUrl: $htmlUrl, description: $description, language: $language, defaultBranch: $defaultBranch, createdAt: $createdAt, updatedAt: $updatedAt, pushedAt: $pushedAt, gitUrl: $gitUrl, sshUrl: $sshUrl, cloneUrl: $cloneUrl, svnUrl: $svnUrl, stargazersCount: $stargazersCount, watchersCount: $watchersCount, forksCount: $forksCount, openIssuesCount: $openIssuesCount, subscribersCount: $subscribersCount, private: $private, fork: $fork, hasIssues: $hasIssues, hasProjects: $hasProjects, hasDownloads: $hasDownloads, hasWiki: $hasWiki, hasPages: $hasPages, owner: $owner, license: $license, parent: $parent, permissions: $permissions, topics: $topics, allIssueCount: $allIssueCount}';
  }

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);

  Repository.empty();
}
