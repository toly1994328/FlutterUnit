import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:tolyui/tolyui.dart';
import 'package:app/app.dart';

class LocaleChangeMenu extends StatefulWidget {
  const LocaleChangeMenu({super.key});

  @override
  State<LocaleChangeMenu> createState() => _LocaleChangeMenuState();
}

const List<String> kWeekZH =  ['星期一','星期二','星期三','星期四','星期五','星期六','星期日'];
const List<String> kWeekEN =  ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

const Map<int,List<String> > kWeekMap = {
  0:kWeekZH,
  1:kWeekEN,
};

class _LocaleChangeMenuState extends State<LocaleChangeMenu> {
  int _activeLocal = 0;
  List<String> local = ['中文简体','English'];
  int _activeDay = 0;

  @override
  Widget build(BuildContext context) {
    List<String> labels = Language.values.map((e)=>e.label).toList();

    DropMenuCellStyle lightStyle = const DropMenuCellStyle(
      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 0),
      borderRadius: BorderRadius.all(Radius.circular(6)),
      foregroundColor: Color(0xff1f1f1f),
      backgroundColor: Colors.transparent,
      disableColor: Color(0xffbfbfbf),
      hoverBackgroundColor: Color(0xfff5f5f5),
      hoverForegroundColor: Color(0xff1f1f1f),
      textStyle: TextStyle(fontFamily: '微软雅黑')
    );

    return
        IconTheme(
          data: IconThemeData(color: Colors.white),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: TolySelect(
              fontSize: 14,
              cellStyle: lightStyle,
              data: labels,
              selectIndex: _activeDay,
              iconSize: 16,
              height: 30,
              width: 110,
              minWidth: 100,
              maxHeight: 200,
              padding: EdgeInsets.symmetric(horizontal: 8),
              onSelected: (int index) async {
                Language type = Language.values[index];
                context.read<AppConfigBloc>().switchLanguage(type);
                setState(() {
                  _activeDay = index;
                });
              },

                ),
          ),
        );
  }
}

