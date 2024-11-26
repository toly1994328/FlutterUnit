import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com

class InheritedThemeDemo extends StatelessWidget {
  const InheritedThemeDemo({super.key});


  @override
  Widget build(BuildContext context) {
    return const DefaultTextStyle(
      style: TextStyle(fontSize: 24, color: Colors.blue),
      child: TestBody(),
    );
  }
}

class TestBody extends StatelessWidget {
  const TestBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () => _toNextPage(context),
        child: Container(
            height: 60,
            margin: const EdgeInsets.only(left: 40,right: 40),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: const Text('InheritedTheme')));
  }

  void _toNextPage(BuildContext context) {
    // final NavigatorState navigator = Navigator.of(context);
    // final CapturedThemes themes =
    // InheritedTheme.capture(from: context, to: navigator.context);
    //
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext _) {
    //       return themes.wrap(Container(
    //         alignment: Alignment.center,
    //         color: Colors.white,
    //         child: Text('Flutter Unit'),
    //       ));
    //     },
    //   ),
    // );
  }
}