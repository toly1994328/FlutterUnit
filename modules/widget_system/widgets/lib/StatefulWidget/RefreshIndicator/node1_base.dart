import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com

class CustomRefreshIndicator extends StatefulWidget {
  const CustomRefreshIndicator({Key? key}) : super(key: key);

  @override
  _CustomRefreshIndicatorState createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: RefreshIndicator(
        onRefresh: _increment,
        displacement: 20,
        color: Colors.orange,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 300,
            color: Colors.blue,
            child: Text('$_count',style: const TextStyle(color: Colors.white,fontSize: 40)),
          ),
        ),
      ),
    );
  }

  Future<void> _increment() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _count++;
    });
  }
}
