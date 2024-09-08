

class RepositoryPermissions {
  bool? admin;
  bool? push;
  bool? pull;

  RepositoryPermissions(
    this.admin,
    this.push,
    this.pull,
  );

  factory RepositoryPermissions.fromJson(Map<String, dynamic> json) =>
      RepositoryPermissions(
        json['admin'] as bool?,
        json['push'] as bool?,
        json['pull'] as bool?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'admin': admin,
        'push': push,
        'pull': pull,
      };
}
