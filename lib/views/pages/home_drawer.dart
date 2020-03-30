import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明: 

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
          elevation: 3,
          child: _buildChild(),
    );
  }

  Widget _buildChild() => BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, state) => Container(
    color:state.color.withAlpha(55),
    child: ListView(
      padding: EdgeInsets.zero,
      children: const <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 10,left: 15),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                bottomRight:Radius.circular(60),
//                bottomLeft:Radius.circular(40)
            ),
            image: DecorationImage(
                image: AssetImage('assets/images/caver.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Text(
            'Flutter Unit',
            style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
              Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 3)
            ]),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.star,
            color: Colors.blue,
          ),
          title: Text('我的收藏'),
        ),
        ListTile(
          leading: Icon(
            Icons.palette,
            color: Colors.orangeAccent,
          ),
          title: Text('我的绘画'),
        ),
        ListTile(
          leading: Icon(
            Icons.insert_drive_file,
            color: Colors.green,
          ),
          title: Text('我的文件'),
        ),
      ],
    ),
  ));
}