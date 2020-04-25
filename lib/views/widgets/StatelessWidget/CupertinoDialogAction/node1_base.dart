

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildDialog(),
      ],
    );
  }

  Widget _buildDialog() => CupertinoDialogAction(
    onPressed: (){

    },
    child: Container(
      width: 50,
      child: DeleteDialog(),
    ),
  );

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.blue,
    onPressed: () {
      showDialog(context: context, builder: (ctx) => _buildDialog());
    },
    child: Text(
      'Just Show It !',
      style: TextStyle(color: Colors.white),
    ),

  );
}

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBar(context),
          _buildTitle(),
          _buildContent(),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Delete Doucument',
      style: TextStyle(color: Color(0xff5CC5E9), fontSize: 24),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        '    Hi toly! If you push the conform buttom ,'
            ' You will lose this file. Are you sure wand to do that?',
        style: TextStyle(color: Color(0xffCFCFCF), fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildFooter(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xff73D1EE)),
            child: Text('Yes, Delete',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.orangeAccent),
              child: Text('Cancle',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  _buildBar(context) => Container(
    height: 30,
    alignment: Alignment.centerRight,
    margin: EdgeInsets.only(right: 10, top: 5),
    child: InkWell(
      onTap: ()=>Navigator.of(context).pop(),
      child: Icon(
        Icons.close,
        color: Color(0xff82CAE3),
      ),
    ),
  );
}
