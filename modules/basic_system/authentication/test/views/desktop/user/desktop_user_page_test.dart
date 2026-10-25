import 'package:authentication/authentication.dart';
import 'package:authentication/progression/model/progression_item.dart';
import 'package:authentication/views/desktop/user/account_tasks_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(_preparePreferences);
  testWidgets('未登录只展示个人入口与本地收藏', _guestVisibility);
  testWidgets('登录与退出会即时更新私有区块', _sessionVisibility);
  testWidgets('宽窗口三栏、窄窗口两栏和单栏均不溢出', _responsiveLayouts);
  testWidgets('任务操作复用签到和领取，并刷新荣誉', _taskActions);
  testWidgets('深色主题和较大文字仍可阅读', _darkAndLargeText);
}

void _preparePreferences() =>
    SharedPreferences.setMockInitialValues(<String, Object>{});

Future<void> _guestVisibility(WidgetTester tester) async {
  final _Fixture fixture = _Fixture(const FxGuest());
  addTearDown(fixture.close);
  await _pump(tester, fixture);
  expect(find.text('登录/注册'), findsNWidgets(2));
  expect(find.text('应用设置'), findsOneWidget);
  expect(find.text('收藏预览'), findsOneWidget);
  expect(find.text('今日任务'), findsNothing);
  expect(find.text('我的荣誉'), findsNothing);
  expect(find.text('头像徽章'), findsNothing);
  expect(find.text('匠心工坊'), findsNothing);
  expect(tester.takeException(), isNull);
}

Future<void> _sessionVisibility(WidgetTester tester) async {
  final _Fixture fixture = _Fixture(const FxGuest());
  addTearDown(fixture.close);
  await _pump(tester, fixture);
  fixture.session.change(const FxAuthed(_Identity()));
  await tester.pumpAndSettle();
  expect(find.text('今日任务'), findsOneWidget);
  expect(find.text('我的荣誉'), findsOneWidget);
  expect(find.text('头像徽章'), findsOneWidget);
  expect(find.text('张风捷特烈'), findsOneWidget);
  fixture.session.change(const FxGuest());
  await tester.pumpAndSettle();
  expect(find.text('今日任务'), findsNothing);
  expect(find.text('我的荣誉'), findsNothing);
  expect(find.text('匠心工坊'), findsNothing);
  expect(tester.takeException(), isNull);
}

Future<void> _responsiveLayouts(WidgetTester tester) async {
  final _Fixture fixture = _Fixture(const FxAuthed(_Identity()));
  addTearDown(fixture.close);
  const Map<int, String> widths = <int, String>{
    1200: 'account-three-columns',
    780: 'account-two-columns',
    520: 'account-single-column'
  };
  for (final MapEntry<int, String> entry in widths.entries) {
    await _pump(tester, fixture, width: entry.key.toDouble());
    expect(find.byKey(ValueKey<String>(entry.value)), findsOneWidget);
    expect(tester.takeException(), isNull);
  }
}

Future<void> _taskActions(WidgetTester tester) async {
  final _Fixture fixture = _Fixture(const FxAuthed(_Identity()));
  addTearDown(fixture.close);
  await _pump(tester, fixture);
  final Finder panel = find.byType(AccountTasksPanel);
  await tester.tap(find.descendant(of: panel, matching: find.text('签到')));
  await tester.pumpAndSettle();
  expect(fixture.progression.checkInCount, 1);
  expect(fixture.honors.loadCount, 1);
  await tester.tap(find.descendant(of: panel, matching: find.text('领取')));
  await tester.pumpAndSettle();
  expect(fixture.progression.claimedCode, 'daily_view_widgets');
  expect(fixture.honors.loadCount, 2);
  expect(tester.takeException(), isNull);
}

Future<void> _darkAndLargeText(WidgetTester tester) async {
  final _Fixture fixture = _Fixture(const FxAuthed(_Identity()));
  addTearDown(fixture.close);
  await _pump(tester, fixture, width: 1000, dark: true, scale: 1.4);
  expect(find.text('今日任务'), findsOneWidget);
  expect(tester.takeException(), isNull);
}

Future<void> _pump(WidgetTester tester, _Fixture fixture,
    {double width = 1200, bool dark = false, double scale = 1}) async {
  tester.view.physicalSize = Size(width, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<FxUserSessionCubit>.value(value: fixture.session),
        BlocProvider<AvatarFrameCubit>.value(value: fixture.honors),
        BlocProvider<ProgressionCubit>.value(value: fixture.progression),
      ],
      child: MaterialApp(
        locale: const Locale('zh'),
        localizationsDelegates: l10nDelegates,
        supportedLocales: l10nLocales,
        theme: ThemeData(brightness: dark ? Brightness.dark : Brightness.light),
        home: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scale)),
            child: const Scaffold(
                body: DesktopUserPage(
                    collectionCount: 6, collectionContent: Text('收藏预览')))),
      )));
  await tester.pumpAndSettle();
}

/// 只提供公开资料，测试不创建真实登录态或请求线上接口。
class _Identity implements FxIdentity {
  const _Identity();
  @override
  String get id => 'test-user';
  @override
  String? get displayName => '张风捷特烈';
  @override
  Uri? get avatar => null;
  @override
  T? read<T>(FxIdentityField<T> field) => null;
}

class _Fixture {
  _Fixture(FxUserSession initial) : session = _Session(initial);

  /// 可切换的本地会话。
  final _Session session;

  /// 不进行网络请求的荣誉状态。
  final _Honors honors = _Honors();

  /// 不进行网络请求的任务状态。
  final _Progression progression = _Progression();
  Future<void> close() async {
    await session.close();
    await honors.close();
    await progression.close();
  }
}

class _Session extends Cubit<FxUserSession> implements FxUserSessionCubit {
  _Session(super.initialState);
  void change(FxUserSession session) => emit(session);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Honors extends Cubit<AvatarFrameState> implements AvatarFrameCubit {
  _Honors() : super(const AvatarFrameState());

  /// 荣誉刷新次数。
  int loadCount = 0;
  @override
  Future<void> load() async {
    loadCount++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Progression extends Cubit<ProgressionState> implements ProgressionCubit {
  _Progression()
      : super(const ProgressionState(
            overview: ProgressionOverview(
          taskDate: '2026-10-25',
          timezone: 'Asia/Shanghai',
          pointsBalance: 80,
          currency:
              ProgressionCurrency(code: 'craft_dust', name: '匠尘', assetUrl: ''),
          achievements: <ProgressionItem>[],
          dailyTasks: <ProgressionItem>[
            ProgressionItem(
                code: 'daily_check_in',
                name: '每日签到',
                description: '',
                progress: 0,
                target: 1,
                status: 'in_progress',
                rewardPoints: 10,
                rewards: <ProgressionReward>[]),
            ProgressionItem(
                code: 'daily_view_widgets',
                name: '探索组件',
                description: '',
                progress: 3,
                target: 3,
                status: 'claimable',
                rewardPoints: 20,
                rewards: <ProgressionReward>[]),
          ],
        )));

  /// 签到调用次数。
  int checkInCount = 0;

  /// 被领取的任务编码。
  String? claimedCode;
  @override
  Future<bool> checkIn() async {
    checkInCount++;
    return true;
  }

  @override
  Future<void> claimDailyTask(String code) async {
    claimedCode = code;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
