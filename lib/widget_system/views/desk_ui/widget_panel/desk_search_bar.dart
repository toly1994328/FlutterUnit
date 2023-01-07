import 'package:flutter/material.dart';

class DeskSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;


  const DeskSearchBar({Key? key,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
    // controller: _ctrl,
    onChanged: onChanged,
    style: const TextStyle(fontSize: 12),
    maxLines: 1,
    decoration: const InputDecoration(
    filled: true,
    hoverColor: Colors.transparent,
    contentPadding: EdgeInsets.only(top: 0),
    fillColor: Color(0xffF1F2F3),
    prefixIcon: Icon(Icons.search, size: 18,color: Colors.grey,),
    border: UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    hintText: "输入组件名称",
    hintStyle:  TextStyle(fontSize: 12,color: Colors.grey)),
    );
  }
}
