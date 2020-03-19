import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var pagers=<Widget>[
      Icon(Icons.perm_contact_calendar,size: 200,),
      Icon(Icons.ac_unit,size: 200,),
      Icon(Icons.android,size: 200,),
      Icon(Icons.print,size: 200,),
    ];


    var items=<ItemBean>[
    ItemBean(icon: Icons.perm_contact_calendar, info: "销售"),
    ItemBean(icon: Icons.ac_unit, info: "库存"),
    ItemBean(icon: Icons.android, info: "生产"),
    ItemBean(icon: Icons.print, info: "办公"),
    ];

    return Scaffold(
        body: HomeContent(pagers: pagers,items: items),
        appBar: AppBar(
          title: Text("导航"),
          centerTitle: true,
        ));
  }
}

class HomeContent extends StatefulWidget {
  final List<Widget> pagers;
  final List<ItemBean> items;


  HomeContent({this.pagers,this.items});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {



  var _position = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            width: 100,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemBuilder: (_, index) {
                  if (_position == index) {
                    widget.items[index].selected = true;
                  }

                  return InkWell(
                    onTap: () {
                      widget.items[_position].selected = false;
                      setState(() {
                        _position = index;
                      });
                    },
                    child: SelectItemWidget(
                      itemBean: widget.items[index],
                    ),
                  );
                },
//                separatorBuilder: (_, __) => Divider(),
                itemCount: 4)),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height,
          color: Colors.orangeAccent.withAlpha(22),
          child: widget.pagers[_position],
        ),
      ],
    );
  }
}

class ItemBean {
  Color color;
  Color activeColor;
  String info;
  IconData icon;
  bool selected;

  ItemBean(
      {this.color = Colors.black,
      this.activeColor = Colors.blue,
      this.info,
      this.icon,
      this.selected = false});
}

class SelectItemWidget extends StatelessWidget {
  const SelectItemWidget({Key key, this.itemBean}) : super(key: key);

  final ItemBean itemBean;

  @override
  Widget build(BuildContext context) {
    return
        Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                color: !itemBean.selected ? Colors.white : itemBean.activeColor,
                height: 60,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: <Widget>[
                    Icon(itemBean.icon),
                    Text(itemBean.info),
                  ],
                )

    ),
            Container(height: 1/MediaQuery.of(context).devicePixelRatio,color: Colors.grey,)
          ],
        );
  }
}
