import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com

class CupertinoSliverNavigationBarDemo extends StatelessWidget {
  CupertinoSliverNavigationBarDemo({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            trailing: const Icon(
              CupertinoIcons.share,
              size: 25,
            ),
            leading: _buildLeading(),
            backgroundColor: Colors.white,
            // middle: Text('张风捷特烈'),
            largeTitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.ac_unit,
                  size: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('张风捷特烈'),
                ),
                Icon(Icons.ac_unit, size: 20),
              ],
            ),
          ),
          _buildSliverList()
        ],
      ),
    );
  }

  Widget _buildSliverList() => SliverPrototypeExtentList(
        prototypeItem: Container(
          height: 40,
        ),
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: const TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  Widget _buildLeading() => Container(
      margin: const EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.webp'));


  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
