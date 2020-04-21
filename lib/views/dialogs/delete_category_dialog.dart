import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

class DeleteCategoryDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onSubmit;


  DeleteCategoryDialog({
    this.title='', this.content ='',this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBar(context),
          _buildTitle(context),
          _buildContent(),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(content,
        style: TextStyle(color: Colors.grey, fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildFooter(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 10,left: 10,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FeedbackWidget(
            onPressed: onSubmit,
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).primaryColor),
              child: Text('确 定',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          FeedbackWidget(
            onPressed: ()=>Navigator.of(context).pop(),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.orangeAccent),
              child: Text('取 消',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  _buildBar(context) => Row(
    children: <Widget>[
      Spacer(),
      GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          height: 30,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10, top: 5),
          child:  Icon(
            Icons.close,
            color:Theme.of(context).primaryColor,
          ),
        ),
      ),
    ],
  );
}