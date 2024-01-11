import 'dart:io';
import 'package:flutter/material.dart';

import 'class_generator.dart';
import 'desk_widget_top_bar.dart';
import 'icon_font_gen/icon_font_gen_page.dart';
import 'model/class.dart';
import 'model/field.dart';
import 'popable/class_gen_field.dart';
import 'popable/toly_select.dart';

class A {}

class CodeGenPage extends StatefulWidget {
  const CodeGenPage({Key? key}) : super(key: key);

  @override
  State<CodeGenPage> createState() => _CodeGenPageState();
}

class _CodeGenPageState extends State<CodeGenPage> {

  TextEditingController _dirPath = TextEditingController();
  final PageController _ctrl = PageController();
  int selectIndex = 0;

  final List<String> selectData = [
    "final",
    "static",
    'static const',
  ];

  Class clazz1 = Class(
    name: '',
    fields: [
    ],
  );

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeskCodeGenTopBar(
            onTapGen: _doGen,
            onTabPressed: (int value) {
              _ctrl.jumpToPage(value);
            },
          ),
          Expanded(child: PageView(
            controller:_ctrl,
            children: [
              IconFontGenPage(),
              Center(
                child: Text(
                    '敬请期待'
                ),
              ),
              Center(
                child: Text(
                    '敬请期待'
                ),
              ),
              Center(
                child: Text(
                    '敬请期待'
                ),
              )
            ],
          )),
          if(false)
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Row(
              children:  [
                GestureDetector(
                    onTap: () async{
                      // final String? directoryPath = await getDirectoryPath();
                      // if (directoryPath != null) {
                      //   print("====$directoryPath=========");
                      //   _dirPath.text = directoryPath;
                      // }
                    },
                    child: Icon(Icons.file_copy_outlined)),
                SizedBox(width: 20,),
                Expanded(child: TextField(
                  controller: _dirPath,
                )),
                SizedBox(width: 20,),
              ],
            ),
          ),
          if(false)
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClassGenField(
              clazz: clazz1,
            ),
          ))
        ],
      ),
    );
  }

  void _onChange(int index) {
    selectIndex = index;
    setState(() {});
  }

  void _doGen() {
    // String className = _classNameCtrl.text;
    // String fieldType = _fieldTypeCtrl.text;
    // String fieldName = _fieldNameCtrl.text;
    // String modifier = selectData[selectIndex];
    //
    // print(
    //     "===$className===$fieldType====$fieldName=======$modifier===================");
    // Class clazz = Class(
    //   name: className,
    //   fields: [
    //     // Field(name: 'cost', type: int),
    //     // Field(name: 'taskName', type: String),
    //     // Field(name: 'count', type: int),
    //     // Field(name: 'taskCode', type: String),
    //     Field(
    //         name: fieldName,
    //         type: fieldType,
    //         nullable: true,
    //         isRequired: false),
    //   ],
    // );
    print(clazz1.buildClass());
    if(_dirPath.text.isNotEmpty){
      clazz1.write2File(Directory(_dirPath.text));
    }
  }


}

class GenInput extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;

  const GenInput(
      {Key? key, required this.hintText, this.controller, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
        ),
        SizedBox(
          width: 150,
          height: 30,
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
                filled: true,
                hoverColor: Colors.transparent,
                contentPadding: EdgeInsets.only(top: 0, left: 15),
                fillColor: Color(0xffF1F2F3),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}

class GenCheckBox extends StatelessWidget {
  final String label;
  final bool checked;
  final ValueChanged<bool?>? onChanged;

  const GenCheckBox({
    Key? key,
    required this.label,
    required this.checked,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: [
        Checkbox(value: checked, onChanged: onChanged),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
