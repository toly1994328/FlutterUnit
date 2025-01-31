
import 'package:flutter/material.dart';
import 'package:tolyui/tolyui.dart';

import '../repository/model/model.dart';


class EditArticleDialog extends StatefulWidget {
  final ArticlePo? article;
  final Function(ArticlePo po)? onSave;
  final Function(ArticleCreatePayload payload)? onCreate;

  const EditArticleDialog({
    this.article,
    this.onSave,
    this.onCreate,
  });

  @override
  _EditArticleDialogState createState() => _EditArticleDialogState();
}

class _EditArticleDialogState extends State<EditArticleDialog> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _urlController;
  late TextEditingController _coverController;
  late TextEditingController _columnController;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      _titleController = TextEditingController(text: widget.article!.title);
      _subtitleController =
          TextEditingController(text: widget.article!.subtitle);
      _urlController = TextEditingController(text: widget.article!.url);
      _coverController = TextEditingController(text: widget.article!.cover);
      _columnController = TextEditingController();
    } else {
      _titleController = TextEditingController();
      _subtitleController = TextEditingController();
      _urlController = TextEditingController();
      _coverController = TextEditingController();
      _columnController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _urlController.dispose();
    _coverController.dispose();
    super.dispose();
  }

  bool get editModel => widget.article != null;

  @override
  Widget build(BuildContext context) {
    Palette foreground = const Palette(
        normal: Color(0xff606266),
        hover: Color(0xff096dd9),
        pressed: Color(0xff096dd9));
    Palette border = const Palette(
        normal: Color(0xffd9d9d9),
        hover: Color(0x44409eff),
        pressed: Color(0xff096dd9));
    Palette bg = const Palette(
        normal: Color(0xff1890ff),
        hover: Color(0xffecf5ff),
        pressed: Color(0xffecf5ff));
    return AlertDialog(
      title: Text(
        editModel ? '编辑文章' : '新增文章',
        style: TextStyle(fontSize: 16),
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Row(
                children: [
                  Text('文章标题: '),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TolyInput(
                      controller: _titleController,
                    ),
                  ),
                ],
              ),
              // TextField(
              //   controller: _titleController,
              //   decoration: InputDecoration(labelText: 'Title'),
              // ),
              Row(
                children: [
                  Text('文章摘要: '),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TolyInput(
                      controller: _subtitleController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('文章链接: '),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TolyInput(
                      controller: _urlController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('专栏收录: '),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TolyInput(
                      controller: _columnController,
                    ),
                  ),
                ],
              ),
              if (_coverController.text.isNotEmpty)
                Image.network(_coverController.text),
              if (_coverController.text.isEmpty)
                Row(
                  children: [
                    Text('文章封面: '),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TolyInput(
                        controller: _coverController,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("取消"),
          style: OutlineButtonPalette(
            foregroundPalette: foreground,
            borderPalette: border,
            backgroundPalette: bg,
          ).style,
        ),
        ElevatedButton(
          onPressed: () {
            ArticleCreatePayload payload = ArticleCreatePayload(
              subtitle: _subtitleController.text,
              title:  _titleController.text,
              url: _urlController.text,
              cover: _coverController.text,
              type: 1,
              createAt: DateTime.now().toIso8601String(),
            );
            widget.onCreate?.call(payload);
          },
          child: Wrap(
            spacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "保存",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          style: FillButtonPalette(
            padding: EdgeInsets.symmetric(vertical: 0),
            foregroundPalette: Palette.all(Colors.white),
            borderRadius: BorderRadius.circular(6),
            backgroundPalette: const Palette(
              normal: Color(0xff1890ff),
              hover: Color(0xff40a9ff),
              pressed: Color(0xff096dd9),
            ),
          ).style,
        )
      ],
    );
  }
}
