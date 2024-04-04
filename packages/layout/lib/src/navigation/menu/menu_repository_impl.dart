import 'dart:async';

import 'package:layout/src/navigation/menu/popable.dart';
import 'package:toly_menu/toly_menu.dart';
import 'package:toly_menu_manager/toly_menu_manager.dart';

import 'base_layout.dart';
import 'scroll.dart';
import 'layout.dart';
import 'flex.dart';

class MenuRepositoryImpl implements MenuRepository {

  @override
  FutureOr<MenuNode> loadRootMenu() {
    print("========loadRootMenu==========");
    return MenuNode.fromMap({
      'children': [
        home,
        baseMenus,
        drawMenus,
        calcMenus,
        // popableMenus,
      ]
    });
  }

  @override
  FutureOr<(List<String>, String)> loadMenuActiveState() {
    return (['/base'],'/base/size');
  }

  @override
  FutureOr<List<MenuHistory>> loadMenuHistory() {

    return [];
  }

  @override
  FutureOr<void> saveMenuHistory(MenuHistory history) {

  }

  @override
  FutureOr<void> deleteMenuHistory(MenuHistory history) {

  }
}
