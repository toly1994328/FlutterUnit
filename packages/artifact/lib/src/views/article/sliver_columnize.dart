import 'package:flutter/material.dart';

import 'columnize_page_view.dart';

class ColumnizeViewPage extends StatefulWidget {
  const ColumnizeViewPage({Key? key}) : super(key: key);

  @override
  State<ColumnizeViewPage> createState() => _ColumnizeViewPageState();
}

class _ColumnizeViewPageState extends State<ColumnizeViewPage> {

  late PageController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController(viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: const SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0,right: 16,top: 12,bottom: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/icon_head.webp',),
                    backgroundColor: Colors.transparent,
                    radius: 10,
                  ),
                  const SizedBox(width: 6,),
                  Text("捷特文章专栏",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  Spacer(),
                  Text("前往掘金",style: TextStyle(fontSize: 12,color: Colors.blue),),
                  Icon(Icons.navigate_next,size: 12,color: Colors.blue,)
                ],
              ),
            ),
            Expanded(
              child: ColumnizePageView(),
            ),
            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

}
