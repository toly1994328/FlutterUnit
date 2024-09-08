import 'dart:async';

import 'package:flutter/material.dart';

class AutocompleteDemo extends StatelessWidget {
  const AutocompleteDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Autocomplete<String>(
          optionsBuilder: buildOptions,
          onSelected: onSelected,
        ),
      ),
    );
  }

  void onSelected(String selection) {
      debugPrint('当前选择了 $selection');
    }

  Future<Iterable<String>> buildOptions(
    TextEditingValue textEditingValue,
  ) async {
    if (textEditingValue.text == '') {
      return const Iterable<String>.empty();
    }
    return searchByArgs(textEditingValue.text);
  }

  Future<Iterable<String>> searchByArgs(String args) async{
    // 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 200));
    const List<String> data =  [
      'toly', 'toly49', 'toly42', 'toly56',
      'card', 'ls', 'alex', 'fan sha',
    ];
   return data.where((String name) => name.contains(args));
  }
}
