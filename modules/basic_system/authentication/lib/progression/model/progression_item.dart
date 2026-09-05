/// 每日任务或长期成就的服务端进度。
class ProgressionItem {
  const ProgressionItem({
    required this.code,
    required this.name,
    required this.description,
    required this.progress,
    required this.target,
    required this.status,
    required this.rewardPoints,
    required this.rewards,
  });

  /// 稳定业务编码。
  final String code;

  /// 展示名称。
  final String name;

  /// 达成条件说明。
  final String description;

  /// 当前有效进度。
  final int progress;

  /// 完成或解锁所需目标值。
  final int target;

  /// 服务端计算出的当前状态。
  final String status;

  /// 领取后增加的匠尘。
  final int rewardPoints;

  /// 成就解锁后发放的多个荣誉奖励。
  final List<ProgressionReward> rewards;

  bool get completed =>
      status == 'claimable' || status == 'claimed' || status == 'unlocked';

  bool get claimable => status == 'claimable';

  factory ProgressionItem.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return ProgressionItem(
      code: map['code'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      progress: map['progress'] as int? ?? 0,
      target: map['target'] as int? ?? 1,
      status: map['status'] as String? ?? 'in_progress',
      rewardPoints: map['reward_points'] as int? ?? 0,
      rewards: List<dynamic>.from(map['rewards'] as List? ?? <dynamic>[])
          .map<ProgressionReward>(ProgressionReward.fromApi)
          .toList(),
    );
  }
}

class ProgressionReward {
  const ProgressionReward({
    required this.code,
    required this.name,
    required this.assetUrl,
  });

  final String code;
  final String name;
  final String assetUrl;

  factory ProgressionReward.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return ProgressionReward(
      code: map['code'] as String? ?? '',
      name: map['name'] as String? ?? '',
      assetUrl: map['asset_url'] as String? ?? '',
    );
  }
}

/// 服务端下发的任务货币展示信息。
class ProgressionCurrency {
  const ProgressionCurrency({
    required this.code,
    required this.name,
    required this.assetUrl,
  });

  /// 稳定货币编码。
  final String code;

  /// 用户可见名称。
  final String name;

  /// 货币 Logo 的公开资源地址。
  final String assetUrl;

  factory ProgressionCurrency.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return ProgressionCurrency(
      code: map['code'] as String? ?? 'craft_dust',
      name: map['name'] as String? ?? '匠尘',
      assetUrl: map['asset_url'] as String? ?? '',
    );
  }
}

/// 当前用户的任务与成就总览。
class ProgressionOverview {
  const ProgressionOverview({
    required this.taskDate,
    required this.timezone,
    required this.dailyTasks,
    required this.achievements,
    required this.pointsBalance,
    required this.currency,
  });

  /// 服务端业务日期。
  final String taskDate;

  /// 服务端计算日期使用的时区。
  final String timezone;

  /// 当日任务列表。
  final List<ProgressionItem> dailyTasks;

  /// 长期成就列表。
  final List<ProgressionItem> achievements;

  /// 当前可用匠尘。
  final int pointsBalance;

  /// 服务端定义的匠尘展示信息。
  final ProgressionCurrency currency;

  factory ProgressionOverview.fromApi(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    final List<dynamic> daily =
        List<dynamic>.from(map['daily_tasks'] as List? ?? []);
    final List<dynamic> achievements =
        List<dynamic>.from(map['achievements'] as List? ?? []);
    return ProgressionOverview(
      taskDate: map['task_date'] as String? ?? '',
      timezone: map['timezone'] as String? ?? 'Asia/Shanghai',
      dailyTasks: daily.map<ProgressionItem>(ProgressionItem.fromApi).toList(),
      achievements:
          achievements.map<ProgressionItem>(ProgressionItem.fromApi).toList(),
      pointsBalance: map['points_balance'] as int? ?? 0,
      currency: ProgressionCurrency.fromApi(
        map['currency'] as Map? ?? <String, dynamic>{},
      ),
    );
  }
}
