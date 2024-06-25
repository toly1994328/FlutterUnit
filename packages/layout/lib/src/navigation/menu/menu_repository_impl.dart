import 'base_layout.dart';
import 'scroll.dart';
import 'layout.dart';
import 'multi.dart';

Map<String, dynamic> get layoutMenus => {
      'path': '',
      'label': '',
      'children': [
        home,
        baseMenus,
        drawMenus,
        calcMenus,
// popableMenus,
      ]
    };
