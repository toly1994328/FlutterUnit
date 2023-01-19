import 'dart:async';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2022-04-18
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 356,
//      "name": 'Autocomplete的泛型',
//      "priority": 2,
//      "subtitle": "【optionsViewBuilder】 : 面板构造器   【AutocompleteOptionsViewBuilder<T>】\n"
//          "【fieldViewBuilder】 : 输入构造器   【AutocompleteFieldViewBuilder】\n"
//          "【displayStringForOption】 : 文字展示   【AutocompleteOptionToString】\n",
//    }
class AutocompleteType extends StatefulWidget {
  const AutocompleteType({Key? key}) : super(key: key);

  @override
  State<AutocompleteType> createState() => _AutocompleteTypeState();
}

class _AutocompleteTypeState extends State<AutocompleteType> {
  late TextEditingController _controller;
  User? user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: buildAutocomplete(),
        ),
        body: Center(
            child: Text(
          user != null ? user!.name : '未选择',
          style: const TextStyle(fontSize: 40),
        )),
      ),
    );
  }

  Widget buildAutocomplete() {
    return Autocomplete<User>(
      optionsBuilder: buildOptions,
      onSelected: onSelected,
      optionsViewBuilder: _buildOptionsView,
      fieldViewBuilder: _buildFieldView,
      displayStringForOption: (user) => user.name,
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  void onSelected(User selection) {
    debugPrint('当前选择了 $selection');
    setState(() {
      user = selection;
    });
  }

  Future<Iterable<User>> buildOptions(
    TextEditingValue textEditingValue,
  ) async {
    if (textEditingValue.text == '') {
      return const Iterable<User>.empty();
    }
    return searchByArgs(textEditingValue.text);
  }

  Future<Iterable<User>> searchByArgs(String args) async {
    // 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 200));
    const List<User> data = [
      User('toly', true, 'icon_5.webp'),
      User('toly49', false, 'icon_6.webp'),
      User('toly42', true, 'icon_7.webp'),
      User('toly56', false, 'icon_8.webp'),
      User('card', true, 'icon_5.webp'),
      User('ls', true, 'icon_6.webp'),
      User('alex', true, 'icon_7.webp'),
      User('fan sha', false, 'icon_8.webp'),
    ];
    return data.where((User user) => user.name.contains(args));
  }

  Widget _buildFieldView(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    _controller = textEditingController;
    return SizedBox(
      height: 34,
      child: TextFormField(
        controller: textEditingController,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffF7F8FA),
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.only(top: 1),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(19)),
            ),
            hintText: "输入用户名 (toly)",
            hintStyle: TextStyle(fontSize: 13)),
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      ),
    );
  }

  Widget _buildOptionsView(BuildContext context,
      AutocompleteOnSelected<User> onSelected, Iterable<User> options) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Material(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 150),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                final User option = options.elementAt(index);
                return _UserItem(
                  onSelected: onSelected,
                  user: option,
                  args: _controller.text,
                );
              },
              itemCount: options.length,
            ),
          ),
        ),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  final AutocompleteOnSelected<User>? onSelected;
  final String args;
  final User user;

  const _UserItem({
    Key? key,
    this.onSelected,
    required this.user,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected?.call(user),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              foregroundColor: Colors.transparent,
              backgroundImage:
                  AssetImage('assets/images/head_icon/${user.image}'),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(formSpan(user.name, args)),
                Text(
                  '性别: ${user.man ? '男' : '女'}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        span.add(TextSpan(text: parts[i]));
        if (i != parts.length - 1) {
          span.add(TextSpan(text: pattern, style: lightTextStyle));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }
}

class User {
  final String name;
  final bool man;
  final String image;

  const User(this.name, this.man, this.image);

  @override
  String toString() {
    return 'User{name: $name, man: $man, image: $image}';
  }
}
