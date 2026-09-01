import 'package:app/app.dart';
import 'package:artifact/artifact.dart';
import 'package:authentication/authentication.dart';
import 'package:draw_system/draw_system.dart';
import 'package:treasure_tools/treasure_tools.dart';

List<GoRoute> get systemRoutes => [
      GoRoute(
        path: AppRoute.dataManage.path,
        builder: (_, __) => const DataManagePage(),
      ),
      GoRoute(
        path: AppRoute.blacklist.path,
        builder: (_, __) => const BlacklistPage(),
      ),
      GoRoute(
        path: AppRoute.account.path,
        builder: (_, __) => const DeskAccountPage(),
      ),
      GoRoute(
        path: AppRoute.aboutApp.path,
        builder: (_, __) => const AboutAppPage(),
      ),
      GoRoute(
        path: AppRoute.aboutMe.path,
        builder: (_, __) => const AboutMePage(),
      ),
      if (!kAppEnv.isIos)
        GoRoute(
          path: AppRoute.supportMe.path,
          builder: (_, __) => const SupportMe(),
        ),
      if (kAppEnv.isDesktopUI) ...deskTopRoutes
    ];

List<GoRoute> get deskTopRoutes => [
      GoRoute(
        path: AppRoute.knowledge.path,
        builder: (_, __) => const DeskKnowledgePage(
          drawingPage: GalleryUnit(embedded: true),
        ),
      ),
      GoRoute(
        path: AppRoute.painter.path,
        redirect: (_, __) => AppRoute.knowledge.url,
      ),
      GoRoute(
        path: AppRoute.tools.path,
        builder: (_, __) => const CodeGenPage(),
      ),
    ];
