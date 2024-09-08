import 'package:flutter/cupertino.dart';

import '../../views/base/size/size_tight_constraint.dart';
import '../../views/base/size/size_loss_by_align.dart';
import '../../views/base/size/size_unconstraint.dart';
import '../../views/popable/autocomplete_demo.dart';
import '../../views/popable/dropdown_button_demo.dart';
import '../../views/popable/dropdown_menu_demo.dart';

class DisplayFrame {
  final String title;
  final String desc;
  final String src;
  final WidgetBuilder display;

  DisplayFrame({
    required this.title,
    required this.desc,
    required this.src,
    required this.display,
  });
}


