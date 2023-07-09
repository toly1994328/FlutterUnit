import 'dart:convert';
import 'package:app/app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils/utils.dart';
import 'gen_message_action.dart';
import 'icon_font_class_parser.dart';
import 'icon_font_gen_config.dart';

class IconFontGenPage extends StatefulWidget {
  const IconFontGenPage({Key? key}) : super(key: key);

  @override
  State<IconFontGenPage> createState() => _IconFontGenPageState();
}

class _IconFontGenPageState extends State<IconFontGenPage>
    with AutomaticKeepAliveClientMixin {

  final TextEditingController _projectCtrl = TextEditingController();
  final TextEditingController _iconFontCtrl = TextEditingController();
  final TextEditingController _iconFontAssetsCtrl = TextEditingController();
  final TextEditingController _resultFileCtrl = TextEditingController();

//

  String get spa => path.separator;
  late SharedPreferences _sp;
  SharedPreferences get sp => _sp;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  IconFontGenConfig config = IconFontGenConfig();

  void _initData() async{
    _sp = await SharedPreferences.getInstance();
    String? configStr = sp.getString(SpKey.iconFontGenConfig);
    if(configStr!=null){
      config = IconFontGenConfig.fromJson(json.decode(configStr));
    }
    _iconFontAssetsCtrl.text = config.assetsDist;
    _resultFileCtrl.text = config.fileDist;
    _projectCtrl.text = config.projectPath;
    _iconFontCtrl.text = config.srcZip;
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            FileSelectorInput(
              controller: _iconFontCtrl,
              label: 'Iconfont 压缩包路径',
              // controller: clazz.nameCtrl,
              hintText: '请选择或输入 iconfont 下载的压缩包路径',
            ),
            const SizedBox(height: 10),

            FileSelectorInput(
              pickerDir: true,
              controller: _projectCtrl,
              label: '项目路径',
              // controller: clazz.nameCtrl,
              hintText: '请选择或输入项目地址',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: LabelInputInput(
                    controller: _iconFontAssetsCtrl,
                    label: '资源目录',
                    hintText: 'iconfont 资源存放位置',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: LabelInputInput(
                    controller: _resultFileCtrl,
                    label: '产物位置',
                    hintText: '代码类存放位置',
                  ),
                ),
              ],
            ),

            Expanded(
                child: Align(
              alignment: Alignment(1, -0.8),
              child: GenMessageAction(
                onGen: doGen,
              ),
            ))
          ],
        ),
      ),
    );
  }

  final IconFontClassParser parser = IconFontClassParser();

  void doGen() {
    if (_iconFontCtrl.text.isEmpty) return;
    if (_projectCtrl.text.isEmpty) return;

    IconFontGenConfig config = IconFontGenConfig(
      assetsDist:  _iconFontAssetsCtrl.text,
      fileDist:  _resultFileCtrl.text,
      projectPath:  _projectCtrl.text,
      srcZip:  _iconFontCtrl.text,
    );
    parser.gen(config);
    Toast.success(context, '生成代码成功！');

    sp.setString(SpKey.iconFontGenConfig,json.encode(config));
  }


  
  @override
  bool get wantKeepAlive => true;
}

class LabelInputInput extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;

  const LabelInputInput({
    Key? key,
    required this.hintText,
    this.controller,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      // direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 35,
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  filled: true,
                  hoverColor: Colors.transparent,
                  contentPadding: EdgeInsets.only(top: 0, left: 15),
                  fillColor: isDark?null:Color(0xffF1F2F3),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: isDark?Color(0xff2C3036):Color(0xffE2E7EE)),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          ),
        ),
      ],
    );
  }
}

class FileSelectorInput extends StatelessWidget {
  final String hintText;
  final String label;
  final bool pickerDir;
  final TextEditingController? controller;

  const FileSelectorInput(
      {Key? key,
      required this.hintText,
      this.controller,
      required this.label,
      this.pickerDir = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      // direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 35,
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
                suffixIconConstraints: BoxConstraints(maxWidth: 80),
                suffixIcon: Row(
                  children: [
                    VerticalDivider(
                      width: 1,
                    ),
                    Expanded(
                        child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _showSelectFile,
                        child: Center(
                            child: Text(
                          "选择",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )),
                      ),
                    )),
                  ],
                ),
                filled: true,
                hoverColor: Colors.transparent,
                contentPadding: EdgeInsets.only(top: 0, left: 15),
                fillColor: isDark?null:Color(0xffF1F2F3),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: isDark?Color(0xff2C3036):Color(0xffE2E7EE)),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ),
      ],
    );
  }

  void _showSelectFile() async {
    String? path;
    if (pickerDir) {
      path = await FilePicker.platform.getDirectoryPath();
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        path = result.files.single.path;
      } else {
        // User canceled the picker
      }
    }
    if (path != null) {
      controller?.text = path;
    } else {
      // User canceled the picker
    }
  }
}
