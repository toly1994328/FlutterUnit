/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明: 

class GithubUser {
  GithubUser(
      this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin,
      this.name,
      this.company,
      this.blog,
      this.location,
      this.email,
      this.starred,
      this.bio,
      this.publicRepos,
      this.publicGists,
      this.followers,
      this.following,
      this.createdAt,
      this.updatedAt,
      this.privateGists,
      this.totalPrivateRepos,
      this.ownedPrivateRepos,
      this.diskUsage,
      this.collaborators,
      this.twoFactorAuthentication);

  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? email;
  String? starred;
  String? bio;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? privateGists;
  int? totalPrivateRepos;
  int? ownedPrivateRepos;
  int? diskUsage;
  int? collaborators;
  bool? twoFactorAuthentication;


  factory GithubUser.fromJson(Map<String, dynamic> json) => GithubUser(
    json['login'] as String?,
    json['id'] as int?,
    json['node_id'] as String?,
    json['avatar_url'] as String?,
    json['gravatar_id'] as String?,
    json['url'] as String?,
    json['html_url'] as String?,
    json['followers_url'] as String?,
    json['following_url'] as String?,
    json['gists_url'] as String?,
    json['starred_url'] as String?,
    json['subscriptions_url'] as String?,
    json['organizations_url'] as String?,
    json['repos_url'] as String?,
    json['events_url'] as String?,
    json['received_events_url'] as String?,
    json['type'] as String?,
    json['site_admin'] as bool?,
    json['name'] as String?,
    json['company'] as String?,
    json['blog'] as String?,
    json['location'] as String?,
    json['email'] as String?,
    json['starred'] as String?,
    json['bio'] as String?,
    json['public_repos'] as int?,
    json['public_gists'] as int?,
    json['followers'] as int?,
    json['following'] as int?,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    json['private_gists'] as int?,
    json['total_private_repos'] as int?,
    json['owned_private_repos'] as int?,
    json['disk_usage'] as int?,
    json['collaborators'] as int?,
    json['two_factor_authentication'] as bool?,
  );


  Map<String, dynamic> toJson() => <String, dynamic>{
    'login': login,
    'id': id,
    'node_id': nodeId,
    'avatar_url': avatarUrl,
    'gravatar_id': gravatarId,
    'url': url,
    'html_url': htmlUrl,
    'followers_url': followersUrl,
    'following_url': followingUrl,
    'gists_url': gistsUrl,
    'starred_url': starredUrl,
    'subscriptions_url': subscriptionsUrl,
    'organizations_url': organizationsUrl,
    'repos_url': reposUrl,
    'events_url': eventsUrl,
    'received_events_url': receivedEventsUrl,
    'type': type,
    'site_admin': siteAdmin,
    'name': name,
    'company': company,
    'blog': blog,
    'location': location,
    'email': email,
    'starred': starred,
    'bio': bio,
    'public_repos': publicRepos,
    'public_gists': publicGists,
    'followers': followers,
    'following': following,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'private_gists': privateGists,
    'total_private_repos': totalPrivateRepos,
    'owned_private_repos': ownedPrivateRepos,
    'disk_usage': diskUsage,
    'collaborators': collaborators,
    'two_factor_authentication': twoFactorAuthentication,
  };

  // 命名构造函数
  GithubUser.empty();

}
