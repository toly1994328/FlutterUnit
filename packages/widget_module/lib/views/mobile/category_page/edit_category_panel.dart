import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';
import 'package:widget_module/blocs/blocs.dart';

import '../../../data/exp.dart';


/// create by 张风捷特烈 on 2020-04-23
/// contact me by email 1981462002@qq.com
/// 说明:

enum EditType { add, update }

class EditCategoryPanel extends StatefulWidget {
  final CategoryModel? model;
  final EditType type;

  const EditCategoryPanel({Key? key, this.model, this.type = EditType.add}) : super(key: key);

  @override
  _EditCategoryPanelState createState() => _EditCategoryPanelState();
}

class _EditCategoryPanelState extends State<EditCategoryPanel> {
  String name='';
  String color='';
  String info='';

  int get colorIndex => widget.model == null
      ? 0
      : UnitColor.collectColorSupport
          .map((e) => e.value)
          .toList()
          .indexOf(widget.model!.color.value);

  @override
  void initState() {
    super.initState();
    info = widget.model?.info??'';
    color = (widget.model == null ? null : ColorUtils.colorString(widget.model!.color))??'';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: InputButton(
            defaultText: '${widget.model?.name??''}',
            config: const InputButtonConfig(hint: '收藏集名称', iconData: Icons.check),
            onSubmit: _doEdit,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: EditPanel(
            defaultText: '${widget.model?.info??''}',
            submitClear: false,
            hint: '收藏集简介...',
            onChange: (v) => info = v,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ColorChooser(
            defaultIndex: colorIndex,
            colors: UnitColor.collectColorSupport,
            onChecked: (v) => color = ColorUtils.colorString(v),
          ),
        ),
      ],
    );
  }

  void _doEdit(String str){
    name = str;
    if (name.isNotEmpty) {
      if (widget.type == EditType.add) {
        BlocProvider.of<CategoryBloc>(context).add(
            EventAddCategory(name: name, info: info, color: color));
      }
      if (widget.type == EditType.update) {
        BlocProvider.of<CategoryBloc>(context).add(
            EventUpdateCategory(
                id: widget.model!.id!,
                name: name,
                info: info,
                color: color));
      }
    }
    Navigator.of(context).pop();
  }

}
