/// 用户已经获得的徽章或头像框。
class UserHonor {
  const UserHonor({
    required this.code,
    required this.kind,
    required this.name,
    required this.description,
    required this.assetUrl,
    required this.grantedAt,
    required this.reason,
    required this.equipped,
  });

  /// 奖励的稳定业务编码。
  final String code;

  /// 奖励类型，当前为 badge 或 avatar_frame。
  final String kind;

  /// 奖励展示名称。
  final String name;

  /// 奖励说明。
  final String description;

  /// 奖励图片地址。
  final String assetUrl;

  /// 奖励发放时间。
  final DateTime grantedAt;

  /// 奖励发放原因。
  final String reason;

  /// 奖励是否处于装配状态。
  final bool equipped;

  factory UserHonor.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return UserHonor(
      code: map['code']?.toString() ?? '',
      kind: map['kind']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      assetUrl: map['asset_url']?.toString() ?? '',
      grantedAt: DateTime.tryParse(map['granted_at']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      reason: map['reason']?.toString() ?? '',
      equipped: map['equipped'] == true,
    );
  }

  /// 创建装备状态变化后的奖励副本。
  UserHonor copyWith({bool? equipped}) {
    return UserHonor(
      code: code,
      kind: kind,
      name: name,
      description: description,
      assetUrl: assetUrl,
      grantedAt: grantedAt,
      reason: reason,
      equipped: equipped ?? this.equipped,
    );
  }
}
