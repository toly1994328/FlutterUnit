import 'base_layout.dart';
import 'scroll.dart';
import 'layout.dart';
import 'multi.dart';
import 'popable.dart';

Map<String, dynamic> get layoutMenus => {
      'children': [
        home,
        baseMenus,
        multiMenus,
        calcMenus,
        popableMenus,
      ]
    };
