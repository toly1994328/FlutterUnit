// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../github_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubUser _$UserFromJson(Map<String, dynamic> json) {
  return GithubUser(
    json['login'] as String,
    json['id'] as int,
    json['node_id'] as String,
    json['avatar_url'] as String,
    json['gravatar_id'] as String,
    json['url'] as String,
    json['html_url'] as String,
    json['followers_url'] as String,
    json['following_url'] as String,
    json['gists_url'] as String,
    json['starred_url'] as String,
    json['subscriptions_url'] as String,
    json['organizations_url'] as String,
    json['repos_url'] as String,
    json['events_url'] as String,
    json['received_events_url'] as String,
    json['type'] as String,
    json['site_admin'] as bool,
    json['name'] as String,
    json['company'] as String,
    json['blog'] as String,
    json['location'] as String,
    json['email'] as String,
    json['starred'] as String,
    json['bio'] as String,
    json['public_repos'] as int,
    json['public_gists'] as int,
    json['followers'] as int,
    json['following'] as int,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    json['private_gists'] as int,
    json['total_private_repos'] as int,
    json['owned_private_repos'] as int,
    json['disk_usage'] as int,
    json['collaborators'] as int,
    json['two_factor_authentication'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(GithubUser instance) => <String, dynamic>{
  'login': instance.login,
  'id': instance.id,
  'node_id': instance.nodeId,
  'avatar_url': instance.avatarUrl,
  'gravatar_id': instance.gravatarId,
  'url': instance.url,
  'html_url': instance.htmlUrl,
  'followers_url': instance.followersUrl,
  'following_url': instance.followingUrl,
  'gists_url': instance.gistsUrl,
  'starred_url': instance.starredUrl,
  'subscriptions_url': instance.subscriptionsUrl,
  'organizations_url': instance.organizationsUrl,
  'repos_url': instance.reposUrl,
  'events_url': instance.eventsUrl,
  'received_events_url': instance.receivedEventsUrl,
  'type': instance.type,
  'site_admin': instance.siteAdmin,
  'name': instance.name,
  'company': instance.company,
  'blog': instance.blog,
  'location': instance.location,
  'email': instance.email,
  'starred': instance.starred,
  'bio': instance.bio,
  'public_repos': instance.publicRepos,
  'public_gists': instance.publicGists,
  'followers': instance.followers,
  'following': instance.following,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'private_gists': instance.privateGists,
  'total_private_repos': instance.totalPrivateRepos,
  'owned_private_repos': instance.ownedPrivateRepos,
  'disk_usage': instance.diskUsage,
  'collaborators': instance.collaborators,
  'two_factor_authentication': instance.twoFactorAuthentication,
};
