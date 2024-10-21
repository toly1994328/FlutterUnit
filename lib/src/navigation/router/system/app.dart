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
      GoRoute(
        path: AppRoute.supportMe.path,
        builder: (_, __) => const SupportMe(),
      ),
      if (kAppEnv.isDesktopUI) ...deskTopRoutes
    ];

List<GoRoute> get deskTopRoutes => [
      GoRoute(
        path: AppRoute.knowledge.path,
        builder: (_, __) => const DeskKnowledgePage(),
      ),
      GoRoute(
        path: AppRoute.painter.path,
        builder: (_, __) => const GalleryUnit(),
      ),
      GoRoute(
        path: AppRoute.tools.path,
        builder: (_, __) => const CodeGenPage(),
      ),
    ];
