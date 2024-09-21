import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/14
/// contact me by email 1981462002@qq.com


class PageStorageDemo extends StatefulWidget {
  const PageStorageDemo({Key? key}) : super(key: key);

  @override
  _PageStorageDemoState createState() => _PageStorageDemoState();
}

class _PageStorageDemoState extends State<PageStorageDemo> {
  int _pageIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Scaffold(
        body: PageStorage(
          child: _buildContentByIndex(),
          bucket: _bucket,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent.withAlpha(55),
          currentIndex: _pageIndex,
          onTap: (int index) {
            setState(() {
              _pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentByIndex() {
    if (_pageIndex == 0) {
      return const CountWidget(key: PageStorageKey('CountWidget1'));
    }

    if (_pageIndex == 1) {
      return const CountWidget(key: PageStorageKey('CountWidget2'));
    }

    return ListView();
  }
}

class CountWidget extends StatefulWidget {
  const CountWidget({Key? key}) : super(key: key);

  @override
  _CountWidgetState createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _count = PageStorage.of(context)?.readState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('点击了$_count次'),
          MaterialButton(
              onPressed: _addCount,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              color: Colors.green,
              shape: const CircleBorder(
                side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
              ))
        ],
      ),
    );
  }

  void _addCount() {
    setState(() {
      _count++;
      PageStorage.of(context)?.writeState(context, _count);
    });
  }
}
