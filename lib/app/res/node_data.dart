const nodeData = {
  "Container": [
    {
      "widgetId": 1,
      "name": '可用于显示一个指定宽高的区域',
      "priority": 1,
      "subtitle": "【width】 : 宽   【int】\n"
          "【高】: 外边距   【int】\n"
          "【color】: 子组件    【Color】",
      "code": """class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 200,
      height: 200 * 0.618,
      color: Colors.red.withAlpha(88),
    );
  }
}"""
    },
    {
      "widgetId": 1,
      "name": '可以在区域中放入一个子组件',
      "priority": 2,
      "subtitle": "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
          "【margin】: 外边距   【EdgeInsetsGeometry】\n"
          "【child】: 子组件    【Widget】",
      "code": """class ContainerWithChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: Icon(Icons.android),
    );
  }
}}"""
    },
    {
      "widgetId": 1,
      "name": '可对子组件进行对齐定位',
      "priority": 3,
      "subtitle": "【alignment】 : 对齐定位   【AlignmentGeometry】",
      "code": """class ContainerAlignment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: Icon(
        Icons.android,
        color: Colors.green,
      ),
    );
  }
}"""
    },
    {
      "widgetId": 1,
      "name": '可对子组件进行装饰',
      "priority": 4,
      "subtitle":
          "【decoration】 : 装饰   【Decoration】\n 可装饰: 边线、圆弧、颜色、渐变色、阴影、图片等内容",
      "code": """class ContainerDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stops = [0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0];
    return Container(
      //容器
      alignment: Alignment.center,
      width: 200,
      height: 200 * 0.618,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        //添加渐变色
          gradient: LinearGradient(
              stops: stops,
              colors: Cons.rainbow.map((e) => Color(e)).toList()),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: Text(
        "Container",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 1,
      "name": 'Container还具有变换性',
      "priority": 5,
      "subtitle": "【transform】 : 变换矩阵   【Matrix4】\n 基于Matrix4的矩阵变换，变换详情见线性代数",
      "code": """class ContainerTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //容器
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 150,
      height: 150 * 0.618,
      transform: Matrix4.skew(-pi / 10, 0),
      child: Text(
        "Container",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 1,
      "name": 'Container的约束性',
      "priority": 6,
      "subtitle":
          "【constraints】 : 约束   【BoxConstraints】\n 会约束该区域的尺寸，不会小于指定的最小宽高，也不会大于指定的最大宽高。",
      "code": """class ContainerConstraints extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Container(
          //容器
          color: Colors.blue,
          width: 200,
          height: 200 * 0.618,
          constraints: BoxConstraints(
    minWidth: 100, maxWidth: 150,
    minHeight: 20, maxHeight: 100),
        );
      }
    }"""
    }
  ],
  "Text": [
    {
      "widgetId": 2,
      "priority": 1,
      "name": "文字的基本样式",
      "subtitle": "【入参】 : 文字  【String】\n"
          "【style】: 文字样式   【TextStyle】\n"
          "【color】: 文字样式   【Color】\n"
          "【fontSize】: 文字大小   【double】\n"
          "【fontWeight】: 字重   【FontWeight】\n"
          "【fontStyle】: 字体样式   【fontStyle】\n"
          "【letterSpacing】: 字距   【double】",
      "code": """class CustomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 10,
    );
    return Container(
      width: 200,
      color: Colors.cyanAccent.withAlpha(33),
      height: 200 * 0.618* 0.618,
      child: Text("toly-张风捷特烈-1994`", style: style),
    );
  }
}""",
    },
    {
      "widgetId": 2,
      "priority": 2,
      "name": "文字阴影",
      "subtitle": "【shadows】 : 文字  【List<Shadow>】\n"
          "【backgroundColor】: 背景颜色   【Color】",
      "code": """class ShadowText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "张风捷特烈",
      style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          backgroundColor: Colors.black,
          shadows: [
            Shadow(
                color: Colors.cyanAccent, 
                offset: Offset(1, 1), 
                blurRadius: 10),
            Shadow(
                color: Colors.blue, 
                offset: Offset(-0.1, 0.1), 
                blurRadius: 10),
          ]),
    );
  }
}""",
    },
    {
      "widgetId": 2,
      "priority": 3,
      "name": "文字装饰线",
      "subtitle": "【fontFamily】 : 文字字体  【String】\n"
          "【decoration】: 装饰线   【TextDecoration】\n"
          "【decorationColor】: 装饰线颜色   【Color】\n"
          "【decorationThickness】: 装饰线粗   【double】\n"
          "【decorationStyle】: 装饰线样式   【TextDecorationStyle】",
      "code": """class DecorationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "19940328",
      style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationThickness: 3,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: Colors.blue,
          fontStyle: FontStyle.italic,
          fontFamily: "DancingScript",
          letterSpacing: 10),
    );
  }
}"""
    },
    {
      "widgetId": 2,
      "priority": 4,
      "name": "文字对齐方式",
      "subtitle": "【textAlign】: 对齐方式   【TextAlign】\n"
          "下面依次是:left、right、center、justify、start、end ",
      "code": """class TextAlignText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: TextAlign.values
          .map((e) => Container(
                width: 120,
                color: Colors.cyanAccent.withAlpha(33),
                height: 120 * 0.618,
                child: Text(
                  " 张风捷特烈 toly " * 3,
                  textAlign: e,
                ),
              ))
          .toList(),
    );
  }
}"""
    },
    {
      "widgetId": 2,
      "priority": 5,
      "name": "文字方向与最大行数",
      "subtitle": "【maxLines】 : 最大行数  【int】\n"
          "【【textDirection】 : 文字方向  【TextDirection】\n"
          "下面依次是:rtl、ltr ",
      "code": """class TextDirectionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 10,
      children: TextDirection.values
          .map((e) => Container(
                width: 120,
                color: Colors.cyanAccent.withAlpha(33),
                height: 120 * 0.618,
                child: Text(
                  " 张风捷特烈 toly " * 10,
                  textDirection: e,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
    );
  }
}""",
    },
    {
      "widgetId": 2,
      "priority": 6,
      "name": "是否包裹与越界效果",
      "subtitle": "【softWrap】 : 是否换行  【bool】\n"
          "【overflow】 : 越界效果  【TextOverflow】\n"
          "下面softWrap=false;  overflow依次是:clip、fade、ellipsis、visible ",
      "code": """class SoftWrapText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: TextOverflow.values
          .map((e) => Container(
                width: 150,
                color: Colors.cyanAccent.withAlpha(33),
                height: 150 * 0.618 * 0.618,
                child: Text(" 张风捷特烈 toly " * 5, 
                    overflow: e, 
                    softWrap: false),
              ))
          .toList(),
    );
  } 
}""",
    },
  ],
  "Card": [
    {
      "widgetId": 3,
      "priority": 1,
      "name": "Card可以让一个组件卡片化",
      "subtitle": "【elevation】 : 影深  【double】\n"
          "【margin】: 外边距   【double】\n"
          "【color】: 颜色   【Color】\n"
          "【child】: 孩子   【Widget】",
      "code": """class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffB3FE65),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.topLeft,
        width: 200,
        height: 0.618*200,
        margin: EdgeInsets.all(10),
        child: Text("Card", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 3,
      "priority": 2,
      "name": "可以通过shape属性实现裁切效果",
      "subtitle": "【shape】 : 形状  【ShapeBorder】\n"
          "【margin】: 外边距   【double】\n"
          "【color】: 颜色   【Color】\n"
          "【child】: 孩子   【Widget】",
      "code": """class ShapeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffB3FE65),
      elevation: 6,
      shape: StarShapeBorder(),
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        child: Text("Card", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class StarShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) =>
      Pather.create.nStarPath(9, 50, 40, dx: 50, dy: 50);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
"""
    },
  ],
  "FlutterLogo": [
    {
      "widgetId": 4,
      "priority": 1,
      "name": "用于显示一个FlutterLogo",
      "subtitle": "【size】 : 大小  【double】\n"
          "【colors】: 颜色   【MaterialColor】",
      "code": """class CustomFlutterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var data = {
      Colors.blue:50.0,
      Colors.red:60.0,
      Colors.green:70.0,
      Colors.yellow:80.0,
    };
    return Wrap(
      children: data.keys
          .map((e) => FlutterLogo(
                size: data[e],
                colors: e,
              ))
          .toList(),
    );
  }
}""",
    },
    {
      "widgetId": 4,
      "priority": 2,
      "name": "样式用于显示文字",
      "subtitle": "【style】 : 样式-3种枚举  【FlutterLogoStyle】\n"
          "【textColor】: 文字颜色   【Color】",
      "code": """class FlutterLogoWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      FlutterLogoStyle.horizontal:Colors.blue,
      FlutterLogoStyle.markOnly:Colors.red,
      FlutterLogoStyle.stacked:Colors.green,
    };

    return Wrap(
      spacing: 20,
      children: data.keys.map((e) => FlutterLogo(
        size: 80,
        style: e,
        textColor: data[e],
      ))
          .toList(),
    );
  }
}"""
    },
  ],
  "Banner": [
    {
      "widgetId": 5,
      "priority": 1,
      "name": "用于显示一个角标",
      "subtitle": "【message】 : 显示的文字信息  【String】\n"
          "【location】 : 位置*4  【BannerLocation】\n"
          "【color】: 角标颜色   【Color】\n"
          "【child】: 孩子   【Widget】\n"
          "【textStyle】: 文字样式   【TextStyle】",
      "code": """class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      BannerLocation.topStart: Colors.red,
      BannerLocation.topEnd: Colors.blue,
      BannerLocation.bottomStart: Colors.green,
      BannerLocation.bottomEnd: Colors.yellow,
    };
    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: data.keys.map((e) =>
            Container(
              color: Color(0xffD8F5FF),
              width: 150,
              height: 150 * 0.618,
              child: Banner(
                message: "Flutter 1.12发布",
                location: e,
                color: data[e],
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: FlutterLogo(colors: Colors.blue,
                      style: FlutterLogoStyle.horizontal,)),
              ),
            )).toList());
  }
}""",
    },
  ],
  "Icon": [
    {
      "widgetId": 6,
      "priority": 1,
      "name": "用于显示一个图标",
      "subtitle": "【入参】 :图标数据 【IconData】\n"
          "【size】 : 大小  【double】\n"
          "【color】: 颜色   【Color】",
      "code": """class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Icon(
          Icons.send,
          color: Colors.orange,
          size: 60,
        ),

        Icon(
          Icons.android,
          color: Colors.green,
          size: 100,
        ),
      ],
    );
  }
}""",
    },
    {
      "widgetId": 6,
      "priority": 2,
      "name": "使用自定义图标",
      "subtitle": "可在iconfont网站中下载图标字体进行使用",
      "code": """class MyIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TolyIcon.icon_weichat,
        TolyIcon.icon_go,
        TolyIcon.icon_pc,
        TolyIcon.icon_file
      ]
          .map((e) => Icon(
                e,
                color: Colors.green,
                size: 60,
              ))
          .toList(),
    );
  }
}""",
    },
  ],
  "ImageIcon": [
    {
      "widgetId": 7,
      "priority": 1,
      "name": "用于显示一个纯色图片",
      "subtitle": "【入参】 : 图片资源  【ImageProvider】\n"
          "【size】 : 大小  【double】\n"
          "【color】: 角标颜色   【Color】",
      "code": """class CustomImageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      Colors.blue: 50.0,
      Colors.red: 60.0,
      Colors.green: 70.0,
      Colors.yellow: 80.0,
    };
    return Wrap(
      spacing: 10,
      children: data.keys
          .map((e) => ImageIcon(
                AssetImage("assets/images/leaf.png"),
                color: e,
                size: data[e],
              ))
          .toList(),
    );
  }
}"""
    }
  ],
  "FadeInImage": [
    {
      "widgetId": 8,
      "priority": 1,
      "name": "FadeInImage.assetNetwork加载网络图片",
      "subtitle": "【placeholder】 : 展位图地址  【String】\n"
          "【image】 : 显示图地址  【String】\n"
          "【width】: 宽   【double】\n"
          "【height】: 高   【double】\n"
          "【fadeInDuration】: 淡入时长   【Duration】\n"
          "【fadeOutDuration】: 淡出时长   【Duration】\n"
          "【fadeInCurve】: 淡入曲线   【Cubic】\n"
          "【fadeOutCurve】: 淡出曲线   【Cubic】\n"
          "【fit】: 适应模式   【BoxFit】\n"
          "【alignment】: 对齐模式   【Alignment】\n"
          "【repeat】: 重复模式   【ImageRepeat】\n",
      "code": """class CustomFadeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var placeholder = "assets/images/icon_head.png";
    var img =
        "https://user-gold-cdn.xitu.io/2017/8/24/"
        "d324efef8cbee6468a018aad7ab2ba6b?imageView2/"
        "1/w/180/h/180/q/85/format/webp/interlace/1";
    return FadeInImage.assetNetwork(
        placeholder: placeholder,
        image: img,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      repeat:ImageRepeat.noRepeat,
      alignment: Alignment.center,
      fadeInDuration: Duration(seconds: 5),
      fadeInCurve: Curves.easeInCubic,
    );
  }
}"""
    }
  ],
  "CircleAvatar": [
    {
      "widgetId": 9,
      "priority": 1,
      "name": "CircleAvatar的表现",
      "subtitle": "【radius】 : 半径  【double】\n"
          "【backgroundImage】 : 图片资源  【ImageProvider】\n"
          "【foregroundColor】: 前景色   【Color】\n"
          "【backgroundColor】: 背景色   【Color】\n"
          "【minRadius】: 最小半径   【double】\n"
          "【maxRadius】: 最大半径   【double】\n"
          "【child】: 孩子组件   【Child】",
      "code": """class CustomCircleAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage("assets/images/wy_200x300.jpg"),
      foregroundColor: Colors.white,
      child: Icon(
        Icons.check,
        size: 50,
      ),
    );
  }
}"""
    }
  ],
  "Visibility": [
    {
      "widgetId": 10,
      "priority": 1,
      "name": "根据visible控制内部子组件的显隐情况",
      "subtitle": "【visible】 : 是否显示  【bool】\n"
          "【child】: 孩子   【Widget】\n"
          "默认孩子隐藏时会失去原来所在区域。",
      "code": """class CustomVisibility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: <Widget>[
        _buildVisibility(true),
        _buildVisibility(false),
      ],
    );
  }

  _buildVisibility(bool visible) {
    var box = Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
    return Container(
      width: 150,
      height: 150 * 0.618,
      color: Colors.cyanAccent.withAlpha(33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          box,
          Visibility(
              visible: visible,
              child: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
                color: Colors.red,
                child: Text(
                  "visible\ntrue",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          box,
        ],
      ),
    );
  }
}"""
    },
    {
      "widgetId": 10,
      "priority": 2,
      "name": "replacement可在隐藏时进行占位",
      "subtitle": "【replacement】 : 隐藏时的占位组件  【Widget】",
      "code": """class ReplacementVisibility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: <Widget>[
        _buildVisibility(true),
        _buildVisibility(false),
      ],
    );
  }

  _buildVisibility(bool visible) {
    var box = Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
    return Container(
      width: 150,
      height: 150 * 0.618,
      color: Colors.cyanAccent.withAlpha(33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          box,
          Visibility(
              visible: visible,
              replacement: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
              ),
              child: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
                color: Colors.red,
                child: Text(
                  "visible\\ntrue",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          box,
        ],
      ),
    );
  }
}"""
    },
  ],
  "Chip": [
    {
      "widgetId": 11,
      "priority": 1,
      "name": "Chip的普通表现如下",
      "subtitle": "【avatar】: 左侧组件   【Widget】\n"
          "【label】: 中间组件   【Widget】\n"
          "【padding】 : 内边距  【EdgeInsetsGeometry】\n"
          "【labelPadding】: label边距   【EdgeInsetsGeometry】",
      "code": """class CustomChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundImage: 
              AssetImage("assets/images/wy_200x300.jpg")),
          label: Text("百里巫缨"),
          padding: EdgeInsets.all(8),
          labelPadding: EdgeInsets.all(6),
        ),
      ],
    );
  }
}"""
    },
    {
      "widgetId": 11,
      "priority": 2,
      "name": "可以设置颜色和阴影",
      "subtitle": "【backgroundColor】: 背景色   【Color】\n"
          "【shadowColor】: 阴影色   【Color】\n"
          "【elevation】: 影深   【double】",
      "code": """class ColorOfChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
          backgroundColor: Colors.grey.withAlpha(66),
          shadowColor: Colors.orangeAccent,
          elevation: 3,
        ),
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
          backgroundColor: Colors.cyanAccent.withAlpha(11),
          shadowColor: Colors.blue.withAlpha(88),
          elevation: 4,
        ),
      ],
    );
  }
}"""
    },
    {
      "widgetId": 11,
      "priority": 3,
      "name": "可以设置右侧点击按钮",
      "subtitle": "【deleteIcon】: 右侧组件(通常为Icon)   【Widget】\n"
          "【deleteIconColor】: 右侧组件颜色   【Color】\n"
          "【onDeleted】: 右侧组件点击事件   【Function】",
      "code": """class DeleteOfChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Image.asset("assets/images/icon_head.png"),
      label: Text("张风捷特烈"),
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      backgroundColor: Colors.grey.withAlpha(66),
      shadowColor: Colors.orangeAccent,
//      deleteIcon: Icon(Icons.close,size: 18),
      deleteIconColor: Colors.red,
      onDeleted: () => DialogAbout.show(context),
      elevation: 3,
    );
  }
}"""
    },
  ],
  "ChoiceChip": [
    {
      "widgetId": 12,
      "priority": 1,
      "name": "ChoiceChip的普通表现如下",
      "subtitle": "【selectedColor】: 选中时颜色   【Color】\n"
          "【selectedShadowColor】: 选中时阴影颜色   【Color】\n"
          "【onSelected】: 选中事件   【Fuction(bool)】\n"
          "    其他属性同Chip组件，无右侧组件。",
      "code": """class CustomChoiceChip extends StatefulWidget {
  @override
  _CustomChoiceChipState createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  bool _select = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: _select,
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(5),
      label: Text(
        _select ? 
        "You are selected it." :
        "This is a ChoiceChip.",
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.png"),
      selectedColor: Colors.orangeAccent.withAlpha(44),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      onSelected: (value) => setState(() => _select = value),
    );
  }
}"""
    },
  ],
  "ActionChip": [
    {
      "widgetId": 13,
      "priority": 1,
      "name": "ActionChip的普通表现如下",
      "subtitle": "【onPressed】: 点击事件   【Function】\n"
          "【pressElevation】: 按下时影深   【double】\n"
          "其他属性同Chip组件，无右侧组件。",
      "code": """class CustomActionChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      label: Text("This is a ActionChip."),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.png"),
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      pressElevation: 5,
      onPressed: ()=> DialogAbout.show(context),
    );
  }
}"""
    },
  ],
  "InputChip": [
    {
      "widgetId": 14,
      "priority": 1,
      "name": "可以接受点击、删除事件",
      "subtitle": "【onPressed】: 点击事件   【Function()】\n"
          "【onDeleted】: 删除事件   【Function()】",
      "code": """class PressInputChip extends StatefulWidget {
  @override
  _PressInputChipState createState() => _PressInputChipState();
}

class _PressInputChipState extends State<PressInputChip> {
  bool _delete = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
        padding: EdgeInsets.all(5),
        labelPadding: EdgeInsets.all(3),
        label: Text(
            !_delete ? 
            "This is a InputChip." : 
            "You are clicked delete icon."),
        backgroundColor: Colors.grey.withAlpha(66),
        avatar: Image.asset("assets/images/icon_head.png"),
        selectedColor: Colors.orangeAccent.withAlpha(88),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        elevation: 3,
        onPressed: () => DialogAbout.show(context),
        onDeleted: () => setState(() => _delete = !_delete));
  }
}"""
    },
    {
      "widgetId": 14,
      "priority": 2,
      "name": "可以接受选中事件",
      "subtitle": "【selected】: 是否选中   【bool】\n"
          "【onSelected】: 选中事件   【Function(bool)】",
      "code": """class SelectInputChip extends StatefulWidget {
  @override
  _SelectInputChipState createState() => _SelectInputChipState();
}

class _SelectInputChipState extends State<SelectInputChip> {
  bool _select = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      selected: _select,
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      label: Text("This is a InputChip."),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.png"),
      selectedColor: Colors.orangeAccent.withAlpha(88),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      onDeleted: () => DialogAbout.show(context),
      onSelected: (bool value) {
        setState(() {
          _select = value;
        });
        print("onSelected");
      },
    );
  }
}"""
    },
  ],
  "FilterChip": [
    {
      "widgetId": 15,
      "priority": 1,
      "name": "FilterChip可接受选择事件",
      "subtitle": "【selected】: 是否选择   【bool】\n"
          "【onSelected】: 选择事件   【Function(bool)】\n"
          "【selectedColor】: 选择后的颜色   【Color】\n"
          "【selectedShadowColor】: 选择后的阴影颜色   【Color】\n",
      "code": """class CustomFilterChip extends StatefulWidget {
  @override
  _CustomFilterChipState createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {
  final Map<String, String> map = {
    'A': 'Ant',
    'B': 'Bug',
    'C': 'Cat',
    'D': 'Dog',
  };
  List<String> _selected = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: map.keys.map((key) => 
              _buildChild(key)).toList(),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Text("您已选择: \${_selected.join(', ')}')),
      ],
    );
  }

  Padding _buildChild(String key) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        selectedColor: Colors.orange.withAlpha(55),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        pressElevation: 5,
        elevation: 3,
        avatar: CircleAvatar(child: Text(key)),
        label: Text(map[key]),
        selected: _selected.contains(map[key]),
        onSelected: (bool value) {
          setState(() {
            if (value) {
              _selected.add(map[key]);
            } else {
              _selected.removeWhere((name) => name == map[key]);
            }
          });
        },
      ),
    );
  }
}"""
    },
  ],
  "ListTile": [
    {
      "widgetId": 16,
      "priority": 1,
      "name": "ListTile的基本表现如下",
      "subtitle": "【leading】: 左侧组件   【Widget】\n"
          "【title】: 中间上组件   【Widget】\n"
          "【subtitle】: 中间下组件   【Widget】\n"
          "【trailing】: 尾组件   【Widget】\n"
          "【contentPadding】: 内边距   【EdgeInsetsGeometry】\n"
          "【onLongPress】: 点击事件   【Function()】",
      "code": """
class CustomListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        onLongPress: () => DialogAbout.show(context),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 16,
      "priority": 2,
      "name": "ListTile选中效果和长按事件",
      "subtitle": "【selected】: 是否选中   【bool】\n"
          "【onTap】: 点击事件   【Function()】",
      "code": """
class SelectListTile extends StatefulWidget {
  @override
  _SelectListTileState createState() => _SelectListTileState();
}

class _SelectListTileState extends State<SelectListTile> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        selected: _selected,
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        onTap: () => setState(() => _selected = !_selected),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 16,
      "priority": 3,
      "name": "ListTile的密排属性",
      "subtitle": "【dense】: 是否密排   【bool】",
      "code": """class DenseListTile extends StatefulWidget {
  @override
  _DenseListTileState createState() => _DenseListTileState();
}

class _DenseListTileState extends State<DenseListTile> {
  bool _dense = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        selected: false,
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
        dense: _dense,
        onTap: () => setState(() => _dense = !_dense),
      ),
    );
  }
}"""
    },
  ],
  "CheckboxListTile": [
    {
      "widgetId": 17,
      "priority": 1,
      "name": "CheckBoxListTile的基本表现如下",
      "subtitle": "【secondary】: 左侧组件   【Widget】\n"
          "【checkColor】: ✔️颜色   【Color】\n"
          "【activeColor】: 选中时外框颜色   【Color】\n"
          "【title】: 中间上组件   【Widget】\n"
          "【subtitle】: 中间下组件   【Widget】\n"
          "【onChanged】: 选中事件   【Function(bool)】",
      "code": """class CustomCheckBoxListTile extends StatefulWidget {
  @override
  _CustomCheckBoxListTileState createState() => _CustomCheckBoxListTileState();
}

class _CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  var _selected = false;

  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: CheckboxListTile(
        value: _selected,
        checkColor: Colors.yellow,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.png"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() =>
        _selected = !_selected),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 17,
      "priority": 2,
      "name": "CheckBoxListTile的选中效果",
      "subtitle": "【selected】: 是否选中   【bool】",
      "code": """
class SelectCheckBoxListTile extends StatefulWidget {
  @override
  _SelectCheckBoxListTileState createState() => _SelectCheckBoxListTileState();
}

class _SelectCheckBoxListTileState extends State<SelectCheckBoxListTile> {
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: CheckboxListTile(
        value: _selected,
        selected: _selected,
        checkColor: Colors.yellow,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.png"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() =>
        _selected = !_selected),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 17,
      "priority": 3,
      "name": "CheckBoxListTile的密排属性",
      "subtitle": "【dense】: 是否密排   【bool】",
      "code": """class DenseCheckBoxListTile extends StatefulWidget {
  @override
  _DenseCheckBoxListTileState createState() => _DenseCheckBoxListTileState();
}

class _DenseCheckBoxListTileState extends State<DenseCheckBoxListTile> {
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: CheckboxListTile(
        value: _selected,
        dense: true,
        checkColor: Colors.yellow,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.png"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _selected = !_selected),
      ),
    );
  }
}"""
    },
  ],
  "SwitchListTile": [
    {
      "widgetId": 18,
      "priority": 1,
      "name": "SwitchListTile的基本表现如下",
      "subtitle": "【secondary】: 左侧组件   【Widget】\n"
          "【title】: 中间上组件   【Widget】\n"
          "【subtitle】: 中间下组件   【Widget】\n"
          "【inactiveThumbColor】: 未选中时圆圈颜色   【Color】\n"
          "【inactiveTrackColor】: 未选中滑槽颜色   【Color】\n"
          "【activeColor】: 选中时圆圈颜色   【Color】\n"
          "【activeTrackColor】: 选中滑槽颜色   【Color】\n"
          "【onChanged】: 选中事件   【Function(bool)】",
      "code": """class CustomSwitchListTile extends StatefulWidget {
  @override
  _CustomSwitchListTileState createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  var _value=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: SwitchListTile(
        value: _value,
        inactiveThumbColor:Colors.cyanAccent ,
        inactiveTrackColor: Colors.blue.withAlpha(88),
        activeColor: Colors.orangeAccent,
        activeTrackColor: Colors.orange,
        secondary: Image.asset("assets/images/icon_head.png"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _value = !_value),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 18,
      "priority": 2,
      "name": "SwitchListTile的选中效果",
      "subtitle": "【selected】: 是否选中   【bool】\n"
          "【inactiveThumbImage】: 未选中时圆圈图片   【ImageProvider】\n"
          "【activeThumbImage】: 选中时圆圈图片   【ImageProvider】",
      "code": """class SelectSwitchListTile extends StatefulWidget {
  @override
  _SelectSwitchListTileState createState() => _SelectSwitchListTileState();
}

class _SelectSwitchListTileState extends State<SelectSwitchListTile> {
  var _value=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: SwitchListTile(
        value: _value,
        selected: _value,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.png"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _value = !_value),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 18,
      "priority": 3,
      "name": "SwitchListTile的密排属性",
      "subtitle": "【dense】: 是否密排   【bool】",
      "code": """class DenseSwitchListTile extends StatefulWidget {
  @override
  _DenseSwitchListTileState createState() => _DenseSwitchListTileState();
}

class _DenseSwitchListTileState extends State<DenseSwitchListTile> {
  var _value=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: SwitchListTile(
        value: _value,
        dense: true,
        selected: _value,
        activeColor: Colors.orangeAccent,
        secondary: Image.asset("assets/images/icon_head.png"),
        title: Text("张风捷特烈"),
        subtitle: Text("@万花过尽知无物"),
        onChanged: (v) => setState(() => _value = !_value),
      ),
    );
  }
}"""
    },
  ],
  "RadioListTile": [
    {
      "widgetId": 19,
      "priority": 1,
      "name": "RadioListTile需要一个泛型T",
      "subtitle": "【value】 : 条目对象  【T】\n"
          "【groupValue】 : 选中对象  【T】\n"
          "【selected】: 是否选中   【bool】\n"
          "【secondary】: 右侧组件   【Widget】\n"
          "【title】: 中间上组件   【Widget】\n"
          "【subtitle】: 中间下组件   【Widget】\n"
          "【onChanged】: 切换事件   【Function(T)】",
      "code": """enum ItemType { java, kotlin, dart }

class ItemBean {
  final String title;
  final String subTitle;
  final String imgUrl;

  ItemBean(this.title, this.subTitle, this.imgUrl);
}

class CustomRadioListTile extends StatefulWidget {
  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  final Map<ItemType, ItemBean> languages = {
    ItemType.java: 
    ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.jpeg"),
    ItemType.kotlin:
    ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.jpg"),
    ItemType.dart: 
    ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.jpg"),
  };
  var _type = ItemType.java;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(11),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.keys
              .map((type) => RadioListTile<ItemType>(
                    value: type,
                    groupValue: _type,
                    title: Text(languages[type].title),
                    subtitle: Text(languages[type].subTitle),
                    selected: _type == type,
                    secondary: CircleAvatar(
                      backgroundImage: AssetImage(languages[type].imgUrl),
                    ),
                    onChanged: (type) => setState(() => _type = type),
                  ))
              .toList()),
    );
  }
}"""
    },
    {
      "widgetId": 19,
      "priority": 2,
      "name": "RadioListTile选中色和密排",
      "subtitle": "【activeColor】 : 选中时颜色  【Color】\n"
          "【dense】: 是否密排   【bool】",
      "code": """enum ItemType { java, kotlin, dart }

class ItemBean {
  final String title;
  final String subTitle;
  final String imgUrl;

  ItemBean(this.title, this.subTitle, this.imgUrl);
}

class DenseRadioListTile extends StatefulWidget {
  @override
  _DenseRadioListTileState createState() => _DenseRadioListTileState();
}

class _DenseRadioListTileState extends State<DenseRadioListTile> {
  final Map<ItemType, ItemBean> languages = {
    ItemType.java:
    ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.jpeg"),
    ItemType.kotlin:
    ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.jpg"),
    ItemType.dart:
    ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.jpg"),
  };
  var _type = ItemType.java;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(11),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.keys
              .map((type) => RadioListTile<ItemType>(
            value: type,
            groupValue: _type,
            title: Text(languages[type].title),
            activeColor: Colors.orangeAccent,
            dense: true,
            subtitle: Text(languages[type].subTitle),
            selected: _type == type,
            secondary: CircleAvatar(
              backgroundImage: AssetImage(languages[type].imgUrl),
            ),
            onChanged: (type) => setState(() => _type = type),
          ))
              .toList()),
    );
  }
}"""
    },
  ],
  "GridTileBar": [
    {
      "widgetId": 20,
      "priority": 1,
      "name": "GridTileBar的基本表现如下",
      "subtitle": "【value】 : 条目对象  【T】\n"
          "【leading】: 左侧组件   【Widget】\n"
          "【trailing】: 尾组件   【Widget】\n"
          "【title】: 中间上组件   【Widget】\n"
          "【subtitle】: 中间下组件   【Widget】\n"
          "【backgroundColor】: 背景色   【Color】",
      "code": """
class CustomGridTileBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      backgroundColor: Colors.blue.withAlpha(120),
      trailing: Icon(
        Icons.star,
        color: Colors.red,
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/images/wy_200x300.jpg"),
      ),
      title: Text("百里·巫缨"),
      subtitle: Text("倾国必倾城"),
    );
  }
}"""
    },
  ],
  "GridTile": [
    {
      "widgetId": 21,
      "priority": 1,
      "name": "GridTile的基本表现如下",
      "subtitle": "【header】: 头组件   【Widget】\n"
          "【child】: 子组件   【Widget】\n"
          "【footer】: 脚组件   【Widget】",
      "code": """
class CustomGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, height: 200,
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.blue.withAlpha(120),
          trailing: Icon(
            Icons.star,
            color: Colors.red,
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/wy_200x300.jpg"),
          ),
          title: Text("百里·巫缨"),
          subtitle: Text("倾国必倾城"),
        ),
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            "assets/images/sabar.jpg",
            fit: BoxFit.cover,
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "ID:z\$ySX32&29",
            style: TextStyle(shadows: [
              Shadow(
                  color: Colors.blue,
                  offset: Offset(.1, .1),
                  blurRadius: 2),
            ]),
          ),
        ),
      ),
    );
  }
}"""
    },
  ],
  "UserAccountsDrawerHeader": [
    {
      "widgetId": 22,
      "priority": 1,
      "name": "该组件的基本表现如下",
      "subtitle": "【currentAccountPicture】: 上组件   【Widget】\n"
          "【accountName】: 中组件   【Widget】\n"
          "【accountEmail】: 下组件   【Widget】\n"
          "【decoration】: 装饰   【Decoration】",
      "code": """
class CustomUAGHP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 * 2,
      child: UserAccountsDrawerHeader(
        accountName: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "张风捷特烈",
            style:
                TextStyle(color: Colors.orangeAccent, fontSize: 22, shadows: [
              Shadow(
                  color: Colors.black, offset: Offset(.5, .5), blurRadius: 2),
            ]),
          ),
        ),
        accountEmail: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("1981462002@qq.com",
              style: TextStyle(color: Colors.white, fontSize: 14, shadows: [
                Shadow(
                    color: Colors.orangeAccent,
                    offset: Offset(.5, .5),
                    blurRadius: 2),
              ])),
        ),
        currentAccountPicture: Container(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon_head.png"),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/caver.jpeg")),
        ),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 22,
      "priority": 2,
      "name": "右上角和底部",
      "subtitle": "【otherAccountsPictures】: 右上组件   【List<Widget>】\n"
          "【onDetailsPressed】: 右下角点击事件   【Function()】\n"
          "【arrowColor】: 右下角按钮颜色   【Color】\n"
          "【margin】: 外边距   【EdgeInsetsGeometry】",
      "code": """
class ProUAGHP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 * 2,
      child: UserAccountsDrawerHeader(
        margin: EdgeInsets.all(10),
        accountName: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "张风捷特烈",
            style:
                TextStyle(color: Colors.orangeAccent, fontSize: 22, 
                    shadows: [
              Shadow(
                  color: Colors.black, 
                  offset: Offset(.5, .5),
                  blurRadius: 2),
            ]),
          ),
        ),
        accountEmail: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("1981462002@qq.com",
              style: TextStyle(
                  color: Colors.white, fontSize: 14, 
                  shadows: [
                Shadow(
                    color: Colors.orangeAccent,
                    offset: Offset(.5, .5),
                    blurRadius: 2),
              ])),
        ),
        currentAccountPicture: Container(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon_head.png"),
          ),
        ),
        otherAccountsPictures: <Widget>[
          FlutterLogo(colors: Colors.orange),
          FlutterLogo(colors: Colors.green),
          FlutterLogo(colors: Colors.yellow),
        ],
        onDetailsPressed: () {

        },
        arrowColor: Colors.white,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/caver.jpeg")),
        ),
      ),
    );
  }
}"""
    },
  ],
  "MaterialButton": [
    {
      "widgetId": 23,
      "priority": 1,
      "name": "MaterialButton点击事件",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【splashColor】: 水波纹颜色   【Color】\n"
          "【height】: 高   【double】\n"
          "【elevation】: 影深   【double】\n"
          "【child】: 子组件   【Widget】\n"
          "【textColor】: 子组件文字颜色   【Color】\n"
          "【highlightColor】: 长按高亮色   【Color】\n"
          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """
class CustomMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
        elevation: 5,
        color: Colors.orangeAccent,
        textColor: Colors.white,
        padding: EdgeInsets.all(8),
        child: Text("MaterialButton"),
        onPressed: () => DialogAbout.show(context));
  }
}"""
    },
    {
      "widgetId": 23,
      "priority": 2,
      "name": "MaterialButton长按事件",
      "subtitle": "【highlightColor】: 长按高亮色   【Color】\n"
          "【onLongPress】: 长按事件   【Function】",
      "code": """
class LongPressMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
        height: 40,
        elevation: 5,
        color: Colors.blue,
        highlightColor: Colors.green,
        textColor: Colors.white,
        padding: EdgeInsets.all(8),
        child: Text("MaterialButton"),
        onLongPress: () => DialogAbout.show(context),
        onPressed: () => DialogAbout.show(context));
  }
}"""
    },
    {
      "widgetId": 23,
      "priority": 3,
      "name": "MaterialButton的自定义形状",
      "subtitle":
      "【shape】: 形状   【ShapeBorder】",
      "code": """class ShapeMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          child: MaterialButton(
              padding: EdgeInsets.all(0),
              textColor: Color(0xffFfffff),
              elevation: 3,
              color: Colors.blue,
              highlightColor: Color(0xffF88B0A),
              splashColor: Colors.red,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: CircleBorder(
                side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
              ),
              onLongPress: () => DialogAbout.show(context),
              onPressed: () => DialogAbout.show(context)),
        ),
        Container(
          width: 100,
          height: 40,
          child: MaterialButton(
              padding: EdgeInsets.all(0),
              textColor: Color(0xffFfffff),
              elevation: 3,
              color: Colors.blue,
              highlightColor: Color(0xffF88B0A),
              splashColor: Colors.red,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              onLongPress: () => DialogAbout.show(context),
              onPressed: () => DialogAbout.show(context)),
        ),
      ],
    );
  }
}"""
    },
  ],
  "CupertinoButton": [
    {
      "widgetId": 24,
      "priority": 1,
      "name": "CupertinoButton点击事件",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【pressedOpacity】: 按下时透明度   【double】\n"
          "【child】: 子组件   【Widget】\n"
          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
          "【borderRadius】: 圆角半径   【BorderRadius】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """class CustomCupertinoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      CupertinoColors.activeBlue:4.0,
      Colors.blue:6.0,
      CupertinoColors.activeOrange:8.0,
    };
    return Wrap(
      spacing: 20,
      children:data.keys.map((e)=> CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => DialogAbout.show(context),
        color: e,
        pressedOpacity: 0.4,
        borderRadius:  BorderRadius.all(Radius.circular(data[e])),
        child: Text("iOS"),
      )).toList()
    );
  }
}"""
    }
  ],
  "FlatButton": [
    {
      "widgetId": 25,
      "priority": 1,
      "name": "FlatButton点击事件",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【splashColor】: 水波纹颜色   【Color】\n"
          "【child】: 子组件   【Widget】\n"
          "【textColor】: 子组件文字颜色   【Color】\n"
          "【highlightColor】: 长按高亮色   【Color】\n"
          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """class CustomFlatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: ()=>{},
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      child: Text("FlatButton"),
      textColor: Color(0xffFfffff),
      color: Colors.blue,
      highlightColor: Color(0xffF88B0A),
    );
  }
}"""
    }
  ],
  "RaisedButton": [
    {
      "widgetId": 26,
      "priority": 1,
      "name": "RaisedButton点击事件",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【splashColor】: 水波纹颜色   【Color】\n"
          "【elevation】: 影深   【double】\n"
          "【child】: 子组件   【Widget】\n"
          "【textColor】: 子组件文字颜色   【Color】\n"
          "【highlightColor】: 长按高亮色   【Color】\n"
          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """class CustomRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      splashColor: Colors.green,
      onPressed: () {},
      child: Text("RaisedButton"),
      textColor: Color(0xffFfffff),
      padding: EdgeInsets.all(8),
      elevation: 5,
      highlightColor: Color(0xffF88B0A),
    );
  }
}"""
    }
  ],
  "OutlineButton": [
    {
      "widgetId": 27,
      "priority": 1,
      "name": "OutlineButton点击事件",
      "subtitle": "【textColor】: 子组件文字颜色   【Color】\n"
          "【splashColor】: 水波纹颜色   【Color】\n"
          "【highlightColor】: 长按高亮色   【Color】\n"
          "【highlightedBorderColor】: 高亮时框色   【Color】\n"
          "【child】: 子组件   【Widget】\n"
          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
          "【borderSide】: 边线   【BorderSide】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """class CustomOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(//边线按钮
      onPressed: () {},
      child: Text("OutlineButton"),
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      highlightColor: Colors.orangeAccent,
      highlightedBorderColor: Colors.grey,
      textColor: Color(0xff000000),
      borderSide: BorderSide(color: Color(0xff0A66F8), width: 2),
    );
  }
}"""
    }
  ],
  "FloatingActionButton": [
    {
      "widgetId": 28,
      "priority": 1,
      "name": "FloatingActionButton点击事件",
      "subtitle": "【child】: 子组件   【Widget】\n"
          "【tooltip】: 长按时提示文字   【String】\n"
          "【backgroundColor】: 背景色   【Color】\n"
          "【foregroundColor】: 前景色   【Color】\n"
          "【elevation】: 影深   【double】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """class CustomFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      Colors.red: Icons.add,
      Colors.blue: Icons.bluetooth,
      Colors.green: Icons.android,
    };
    return Wrap(
        spacing: 20,
        children: data.keys
            .map((e) => FloatingActionButton(
                  heroTag: e.toString()+"a",
                  onPressed: () {},
                  backgroundColor: e,
                  foregroundColor: Colors.white,
                  child: Icon(data[e]),
                  tooltip: "android",
                  elevation: 5, //z-阴影盖度
                ))
            .toList());
  }
}"""
    },
    {
      "widgetId": 28,
      "priority": 2,
      "name": "mini属性",
      "subtitle": "【mini】: 是否是迷你   【bool】",
      "code": """class MiniFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      Colors.red: Icons.add,
      Colors.blue: Icons.bluetooth,
      Colors.green: Icons.android,
    };
    return Wrap(
        spacing: 20,
        children: data.keys
            .map((e) => FloatingActionButton(
                  heroTag: e.toString()+"b",
                  onPressed: () {},
                  backgroundColor: e,
                  mini: true,
                  foregroundColor: Colors.white,
                  child: Icon(data[e]),
                  tooltip: "android",
                  elevation: 5, //z-阴影盖度
                ))
            .toList());
  }
}"""
    },
    {
      "widgetId": 28,
      "priority": 3,
      "name": "shape属性",
      "subtitle": "【shape】: 形状   【ShapeBorder】",
      "code": """class ShapeFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      Colors.red: Icons.add,
      Colors.blue: Icons.bluetooth,
      Colors.green: Icons.android,
    };
    return Wrap(
        spacing: 20,
        children: data.keys
            .map((e) => FloatingActionButton(
                  heroTag: e.toString()+"c",
                  onPressed: () {},
                  backgroundColor: e,
                  shape: StarBorder(),
                  foregroundColor: Colors.white,
                  child: Icon(data[e]),
                  tooltip: "android",
                  elevation: 5,
                ))
            .toList());
  }
}

/// 边线形状类
class StarBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    print(rect.right);
    return Pather.create.nStarPath(20, 25, 25 * cos((360 / 9 / 2) * pi / 180),
        dx: rect.height / 2, dy: rect.width / 2);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}"""
    },
  ],
  "ButtonBar": [
    {
      "widgetId": 29,
      "priority": 1,
      "name": "ButtonBar对齐方式",
      "subtitle": "【alignment】: 对齐方式   【MainAxisAlignment】\n"
          "【children】: 子组件集   【List<Widget>】",
      "code": """class CustomButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
            color: Colors.blue,
            child: Text("Raised"),
            onPressed: () => DialogAbout.show(context)),
        OutlineButton(
            child: Text("Outline"),
            onPressed: () => DialogAbout.show(context)),
        FlatButton(
          color: Colors.blue,
          onPressed: () => DialogAbout.show(context),
          child: Text("Flat"),
        )
      ],
    );
  }
}"""
    },
    {
      "widgetId": 29,
      "priority": 2,
      "name": "ButtonBar边距和高",
      "subtitle": "【buttonPadding】: 内边距   【EdgeInsetsGeometry】\n"
          "【buttonHeight】: 高   【double】",
      "code": """class PaddingButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonHeight: 40,
      buttonPadding: EdgeInsets.only(left: 15,right: 15),
      children: <Widget>[
        RaisedButton(
            color: Colors.blue,
            child: Text("Raised"),
            onPressed: () => DialogAbout.show(context)),
        OutlineButton(
            child: Text("Outline"),
            onPressed: () => DialogAbout.show(context)),
        FlatButton(
          color: Colors.blue,
          onPressed: () => DialogAbout.show(context),
          child: Text("Flat"),
        )
      ],
    );
  }
}"""
    },
  ],
  "IconButton": [
    {
      "widgetId": 30,
      "priority": 1,
      "name": "IconButton属性",
      "subtitle": "【child】: 子组件   【Widget】\n"
          "【icon】: 内边距   【Widget】\n"
          "【tooltip】: 长按提示文字   【String】\n"
          "【highlightColor】: 长按高亮色   【Color】\n"
          "【splashColor】: 水波纹色   【Color】\n"
          "【onPressed】: 点击事件   【Function】",
      "code": """class CustomIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        padding: EdgeInsets.only(),
        onPressed: () {},
        icon: Icon(Icons.android, size: 40, color: Colors.green),
        tooltip: "android",
        highlightColor: Colors.orangeAccent, 
        splashColor: Colors.blue, 
      ),
    );
  }
}"""
    },
  ],
  "BackButton": [
    {
      "widgetId": 31,
      "priority": 1,
      "name": "BackButton属性",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【onPressed】: 点击事件   【Function】\n"
          "   onPressed为空会退出当前栈",
      "code": """class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
    return Wrap(
      spacing: 10,
      children: data.map((e)=>BackButton(
        color: e,
      )).toList()
    );
  }
}"""
    },
  ],
  "CloseButton": [
    {
      "widgetId": 32,
      "priority": 1,
      "name": "CloseButton点击事件",
      "subtitle": "     点击时会退出当前栈",
      "code": """class CustomCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CloseButton();
  }"""
    },
  ],
  "ToggleButtons": [
    {
      "widgetId": 33,
      "priority": 1,
      "name": "ToggleButtons单选切换",
      "subtitle": "【children】: 子组件集   【List<Widget>】\n"
          "【borderWidth】: 边线宽   【double】\n"
          "【borderRadius】: 圆角   【BorderRadius】\n"
          "【isSelected】: 是否选中集   【List<bool>】\n"
          "【onPressed】: 点击事件   【Function(int)】",
      "code": """class CustomToggleButtons extends StatefulWidget {
  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  var _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderRadius: BorderRadius.circular(10),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );

  }
}"""
    },
    {
      "widgetId": 33,
      "priority": 2,
      "name": "ToggleButtons颜色属性",
      "subtitle": "【borderColor】: 边线色   【Color】\n"
          "【selectedBorderColor】: 选中边线色   【Color】\n"
          "【selectedColor】: 选中时组件色   【Color】\n"
          "【fillColor】: 选中时填充色   【Color】\n"
          "【splashColor】: 水波纹色   【Color】",
      "code": """class ColorToggleButtons extends StatefulWidget {
  @override
  _ColorToggleButtonsState createState() => _ColorToggleButtonsState();
}

class _ColorToggleButtonsState extends State<ColorToggleButtons> {
  var _isSelected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderColor: Colors.orangeAccent,
      selectedBorderColor: Colors.blue,
      splashColor: Colors.purple.withAlpha(66),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.red,
      fillColor: Colors.green.withAlpha(11),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );
  }
}"""
    },
    {
      "widgetId": 33,
      "priority": 3,
      "name": "ToggleButtons多选切换",
      "subtitle": "    可以控制状态转化的逻辑来形成不同的效果。",
      "code": """class ProToggleButtons extends StatefulWidget {
  @override
  _ProToggleButtonsState createState() => _ProToggleButtonsState();
}

class _ProToggleButtonsState extends State<ProToggleButtons> {
  var _isSelected = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderColor: Colors.blue,
      selectedBorderColor: Colors.orangeAccent,
      splashColor: Colors.purple.withAlpha(66),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.red,
      fillColor: Colors.green.withAlpha(11),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected[value] = !_isSelected[value];
      }),
    );
  }
}"""
    },
  ],
  "Divider": [
    {
      "widgetId": 34,
      "priority": 1,
      "name": "Divider颜色和粗细",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【thickness】: 线粗细   【double】",
      "code": """class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [1.0, 2.0, 4.0, 6.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Column(
      children: dataColor
          .map((e) => Divider(
                color: e,
                thickness: data[e],
              ))
          .toList(),
    );
  }
}"""
    },
    {
      "widgetId": 34,
      "priority": 2,
      "name": "Divider高度和空缺",
      "subtitle": "【indent】: 前面空缺长度   【double】\n"
          "【endIndent】: 后面空缺长度   【double】\n"
          "【height】: 占位高   【double】",
      "code": """class HeightDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [10.0, 20.0, 30.0, 40.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Column(
      children: dataColor
          .map((e) => Divider(
        color: e,
        indent:data[e],
        height: data[e],
        thickness: 2,
      ))
          .toList(),
    );
  }
}"""
    }
  ],
  "VerticalDivider": [
    {
      "widgetId": 35,
      "priority": 1,
      "name": "VerticalDivider颜色和粗细",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【thickness】: 线粗细   【double】",
      "code": """class CustomVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [1.0, 2.0, 4.0, 6.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Container(
      height: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dataColor
            .map((e) => VerticalDivider(
          color: e,
          thickness: data[e],
        ))
            .toList(),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 35,
      "priority": 2,
      "name": "VerticalDivider宽度和空缺",
      "subtitle": "【indent】: 前面空缺长度   【double】\n"
          "【endIndent】: 后面空缺长度   【double】\n"
          "【height】: 占位高   【double】",
      "code": """class HeightVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [10.0, 20.0, 30.0, 40.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Container(
      height: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dataColor
            .map((e) => VerticalDivider(
          color: e,
          indent:data[e],
          endIndent: data[e]*2,
          width: data[e],
          thickness: data[e]/10,
        ))
            .toList(),
      ),
    );
  }
}"""
    }
  ],
  "Placeholder": [
    {
      "widgetId": 36,
      "priority": 1,
      "name": "Placeholder基础属性",
      "subtitle": "【color】: 颜色   【Color】\n"
          "【strokeWidth】: 线粗   【double】",
      "code": """class CustomPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100*0.618,
      child:  Placeholder(
          color: Colors.blue,
          strokeWidth: 2,
        ),
    );
  }
}"""
    },
    {
      "widgetId": 36,
      "priority": 2,
      "name": "Placeholder的fallback属性",
      "subtitle": "    当所在区域无宽高约束时，占位组件的宽高。"
          "【fallbackHeight】: 高   【double】\n"
          "【fallbackWidth】: 宽   【double】",
      "code": """class FallbackPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child:  Placeholder(
        color: Colors.blue,
        strokeWidth: 2,
          fallbackHeight: 100,
          fallbackWidth: 150,
      ),
    );
  }
}"""
    }
  ],
  "GridPager": [
    {
      "widgetId": 37,
      "priority": 1,
      "name": "GridPage基础属性",
      "subtitle": "【child】: 子组件   【Widget】\n"
          "【color】: 颜色   【Color】\n"
          "【interval】: 小块边长   【double】",
      "code": """class CustomGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            child: Image.asset(
              "assets/images/wy_300x200.jpg",
              fit: BoxFit.cover,
            )));
  }
}"""
    },
    {
      "widgetId": 37,
      "priority": 2,
      "name": "GridPage再分割",
      "subtitle": "【child】: 子组件   【Widget】\n"
          "【color】: 颜色   【Color】\n"
          "【subdivisions】: 小块中子块个数   【int】\n"
          "【divisions】: 小块中子块的分割数   【int】",
      "code": """class DivisionsGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            divisions: 4,
            subdivisions: 4,
            child: Image.asset(
              "assets/images/wy_300x200.jpg",
              fit: BoxFit.cover,
            )));
  }
}"""
    },
  ],
  "Image": [
    {
      "widgetId": 38,
      "name": '可从资源文件和网络加载图片',
      "priority": 1,
      "subtitle": "Image.asset加载资源图片,指定路径;\n"
          "Image.network加载资源网络图片，指定链接。\n"
          "Image.file加载资源文件图片，指定路径。\n"
          "Image.memory加载内存图片，指定字节数组。\n"
          "【height】 : 宽   【double】\n"
          "【width】: 高 【double】",
      "code": """class LoadImage extends StatelessWidget {
  final assetsImagePath = "assets/images/icon_head.png";
  final assetsGif = "assets/images/pica.gif";
  final netImageUrl = "https://user-gold-cdn.xitu.io"
      "/2019/7/24/16c225e78234ec26?"
      "imageView2/1/w/1304/h/734/q/85/format/webp/interlace/1";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: <Widget>[
        _loadFromAssets(),
        _loadFromNet(),
      ],
    );
  }
  
  Widget _loadFromAssets() =>
      Wrap(
        spacing: 10,
        children: <Widget>[
          Image.asset(assetsImagePath, height: 80, width: 80),
          Image.asset(assetsGif, height: 80, width: 80),
        ],
      );

  Widget _loadFromNet() => 
      Image.network(netImageUrl, height: 80);
}"""
    },
    {
      "widgetId": 38,
      "name": '图片的适应模式',
      "priority": 2,
      "subtitle": "【fit】 : 适应模式*7   【BoxFit】",
      "code": """class FitImage extends StatefulWidget {
  @override
  _FitImageState createState() => _FitImageState();
}

class _FitImageState extends State<FitImage> {
  bool _smallImage = false;

  @override
  Widget build(BuildContext context) {
    var imageLi = BoxFit.values
        .toList()
        .map((mode) => Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 80,
                  color: Colors.grey.withAlpha(88),
                  child: Image(
                      image: AssetImage(!_smallImage
                          ? "assets/images/wy_300x200.jpg"
                          : "assets/images/wy_30x20.jpg"),
                      fit: mode)),
              Text(mode.toString().split(".")[1])
            ]))
        .toList();

    return Wrap(
      children: [
        ...imageLi,
        _buildSwitch()
      ],
    );
  }

  Widget _buildSwitch() {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text("使用小图"),
          Switch(
                value: _smallImage,
                onChanged: (b) => 
                    setState(() => _smallImage = b)),
        ],
      ),
    );
  }
}"""
    },
    {
      "widgetId": 38,
      "name": '图片对齐模式',
      "priority": 3,
      "subtitle": "【alignment】 : 颜色   【AlignmentGeometry】\n"
          "    常用Alignment类的九个静态常量，但也可定制位置",
      "code": """class FitImage extends StatefulWidget {
  @override
  _FitImageState createState() => _FitImageState();
}

class _FitImageState extends State<FitImage> {
  bool _smallImage = false;

  @override
  Widget build(BuildContext context) {
    var imageLi = BoxFit.values
        .toList()
        .map((mode) => Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 80,
                  color: Colors.grey.withAlpha(88),
                  child: Image(
                      image: AssetImage(!_smallImage
                          ? "assets/images/wy_300x200.jpg"
                          : "assets/images/wy_30x20.jpg"),
                      fit: mode)),
              Text(mode.toString().split(".")[1])
            ]))
        .toList();

    return Wrap(
      children: [...imageLi, _buildSwitch()],
    );
  }

  Widget _buildSwitch() {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text("使用小图"),
          Switch(
              value: _smallImage,
              onChanged: (b) => setState(() => _smallImage = b)),
        ],
      ),
    );
  }
}"""
    },
    {
      "widgetId": 38,
      "name": '图片颜色及混合模式',
      "priority": 4,
      "subtitle": "【color】 : 颜色   【Color】\n"
          "【colorBlendMode】: 混合模式*29 【BlendMode】",
      "code": """class BlendModeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: BlendMode.values
          .toList()
          .map((mode) => Column(children: <Widget>[
                Container(
                    margin: EdgeInsets.all(5),
                    width: 60,
                    height: 60,
                    color: Colors.red,
                    child: Image(
                        image: AssetImage("assets/images/icon_head.png"),
                        color: Colors.blue.withAlpha(88),
                        colorBlendMode: mode)),
                Text(mode.toString().split(".")[1])
              ]))
          .toList(),
    );
  }
}"""
    },
    {
      "widgetId": 38,
      "name": '图片重复模式',
      "priority": 5,
      "subtitle": "【repeat】 : 重复模式*4   【ImageRepeat】",
      "code": """class RepeatImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: ImageRepeat.values
          .toList()
          .map((mode) => Column(children: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            width: 100,
            height: 60,
            color: Colors.red,
            child: Image(
                image: AssetImage("assets/images/wy_30x20.jpg"),
                repeat: mode)),
        Text(mode.toString().split(".")[1])
      ]))
          .toList(),
    );
  }
}"""
    },
    {
      "widgetId": 38,
      "name": '图片实现局部放大',
      "priority": 6,
      "subtitle": "【centerSlice】 : 保留的区域   【Rect】", "code": """class CenterSliceImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 80,
      child: Image.asset(
        "assets/images/right_chat.png",
        centerSlice: Rect.fromLTRB(9, 27, 60, 27 + 1.0),
        fit: BoxFit.fill,
      ),
    );
  }
}
""",
    },
  ],
  "Checkbox": [
    {
      "widgetId": 39,
      "name": 'Checkbox基础用法',
      "priority": 1,
      "subtitle": "【value】 : 是否选中   【double】\n"
          "【checkColor】: 选中时✔️gou颜色 【Color】\n"
          "【activeColor】: 选中时框内颜色 【Color】\n"
          "【onChanged】: 状态改变事件 【Function(bool)】\n",
      "code": """class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _checked = false;
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) =>
          Checkbox(
              value: _checked,
              checkColor: Colors.white,
              activeColor: e,
              onChanged: (v) =>
                  setState(() => _checked = v)))
          .toList(),
    );
  }
}"""
    },
    {
      "widgetId": 39,
      "name": 'Checkbox的三态',
      "priority": 2,
      "subtitle": "【tristate】 : 是否是三态   【double】\n"
          "  onChanged时,回调true、null、false三种状态",
      "code": """class TristateCheckBok extends StatefulWidget {
  @override
  _TristateCheckBokState createState() => _TristateCheckBokState();
}

class _TristateCheckBokState extends State<TristateCheckBok> {
  bool _checked = false;
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) =>
          Checkbox(
              value: _checked,
              tristate: true,
              checkColor: Colors.white,
              activeColor: e,
              onChanged: (v) {
                print(v);
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}"""
    }
  ],
  "Switch": [
    {
      "widgetId": 40,
      "name": 'Switch基础用法',
      "priority": 1,
      "subtitle": "【inactiveThumbColor】 : 未选中小圈颜色   【Color】\n"
          "【inactiveTrackColor】 : 未选中滑槽颜色   【Color】\n"
          "【activeColor】 : 选中时小圈颜色   【Color】\n"
          "【activeTrackColor】 : 选中时滑槽颜色   【Color】\n"
          "【onChanged】 : 切换回调   【Function(double)】"
          "  onChanged时,回调true、null、false三种状态",
      "code": """class CustomSwitch extends StatefulWidget {
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) => Switch(
              value: _checked,
              inactiveThumbColor: e,
              inactiveTrackColor: Colors.grey.withAlpha(88),
              activeColor: Colors.green,
              activeTrackColor: Colors.orange,
              onChanged: (v) {
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}"""
    },
    {
      "widgetId": 40,
      "name": 'Switch图片',
      "priority": 2,
      "subtitle": "【inactiveThumbImage】 : 未选中小圈图片   【ImageProvider】\n"
          "【activeThumbImage】 : 选中时滑槽颜色   【ImageProvider】",
      "code": """class ImageSwitch extends StatefulWidget {
  @override
  _ImageSwitchState createState() => _ImageSwitchState();
}

class _ImageSwitchState extends State<ImageSwitch> {
  final imgs = [
    "assets/images/head_icon/icon_5.jpg",
    "assets/images/head_icon/icon_6.jpg",
    "assets/images/head_icon/icon_7.jpg",
    "assets/images/head_icon/icon_8.jpg"
  ];
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: imgs
          .map((e) => Switch(
              value: _checked,
              inactiveThumbImage: AssetImage(e),
              activeThumbImage: AssetImage('assets/images/pica.gif'),
              onChanged: (v) {
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}"""
    }
  ],
  "CupertinoSwitch": [
    {
      "widgetId": 41,
      "name": 'CupertinoSwitch基本使用',
      "priority": 1,
      "subtitle": "【value】 : 是否选中   【double】\n"
          "【activeColor】 : 激活态颜色   【Color】\n"
          "【onChanged】 : 切换回调   【Function(double)】",
      "code": """class CustomCupertinoSwitch extends StatefulWidget {
  @override
  _CustomCupertinoSwitchState createState() => _CustomCupertinoSwitchState();
}

class _CustomCupertinoSwitchState extends State<CustomCupertinoSwitch> {
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) => CupertinoSwitch(
          value: _checked,
          activeColor: e,
          onChanged: (v) {
            setState(() => _checked = v);
          }))
          .toList(),
    );
  }
}"""
    }
  ],
  "Slider": [
    {
      "widgetId": 42,
      "name": 'Slider基本使用',
      "priority": 1,
      "subtitle": "【value】 : 数值   【double】\n"
          "【min】 : 最小值   【double】\n"
          "【max】 : 最大值   【double】\n"
          "【activeColor】 : 激活颜色   【Color】\n"
          "【inactiveColor】 : 非激活颜色   【Color】\n"
          "【onChanged】 : 改变时回调   【Function(double)】",
      "code": """class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('当前值:\${_value.toStringAsFixed(1)}'),
        Slider(
            value: _value,
            min: 0.0,
            max: 360.0,
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.green.withAlpha(99),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ],
    );
  }
}"""
    },
    {
      "widgetId": 42,
      "name": 'Slider的分段与标签',
      "priority": 2,
      "subtitle": "【divisions】 : 分段数   【int】\n"
          "【label】 : 提示气泡文字   【String】\n"
          "【onChangeStart】 : 开始滑动时监听   【Function(double)】\n"
          "【onChangeEnd】 : 滑动结束时监听   【Function(double)】",
      "code": """class DivisionsSlider extends StatefulWidget {
  @override
  _DivisionsSliderState createState() => _DivisionsSliderState();
}

class _DivisionsSliderState extends State<DivisionsSlider> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: _value,
        min: 0.0,
        max: 360.0,
        divisions: 10,
        label: '\${_value.toStringAsFixed(1)}',
        activeColor: Colors.orangeAccent,
        inactiveColor: Colors.green.withAlpha(99),
        onChangeStart: (value) {
          print('开始滑动:\$value');
        },
        onChangeEnd: (value) {
          print('滑动结束:\$value');
        },
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        });
  }
}"""
    }
  ],
  "CupertinoSlider": [
    {
      "widgetId": 43,
      "name": 'CupertinoSlider基本使用',
      "priority": 1,
      "subtitle": "【value】 : 数值   【double】\n"
          "【min】 : 最小值   【double】\n"
          "【max】 : 最大值   【double】\n"
          "【activeColor】 : 激活颜色   【Color】\n"
          "【thumbColor】 : 圆形颜色   【Color】\n"
          "【divisions】 : 分段数   【int】\n"
          "【onChangeStart】 : 开始滑动回调   【Function(double)】\n"
          "【onChangeEnd】 : 滑动结束回调   【Function(double)】\n"
          "【onChanged】 : 改变时回调   【Function(double)】",
      "code": """class CustomCupertinoSlider extends StatefulWidget {
  @override
  _CustomCupertinoSliderState createState() => _CustomCupertinoSliderState();
}

class _CustomCupertinoSliderState extends State<CustomCupertinoSlider> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: <Widget>[
        Text('当前值:\${_value.toStringAsFixed(1)}'),
        CupertinoSlider(
            value: _value,
            divisions: 180,
            min: 0.0,
            max: 360.0,
            activeColor: Colors.green,
            thumbColor: Colors.white,
            onChangeStart: (value) {
              print('开始滑动:\$value');
            },
            onChangeEnd: (value) {
              print('滑动结束:\$value');
            },
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ],
    );
  }
}"""
    },
  ],
  "RangeSlider": [
    {
      "widgetId": 44,
      "name": 'Slider基本使用',
      "priority": 1,
      "subtitle": "【values】 : 数值   【RangeValues】\n"
          "【min】 : 最小值   【double】\n"
          "【max】 : 最大值   【double】\n"
          "【divisions】 : 分段数   【int】\n"
          "【label】 : 提示气泡文字   【String】\n"
          "【activeColor】 : 激活颜色   【Color】\n"
          "【inactiveColor】 : 非激活颜色   【Color】\n"
          "【onChangeStart】 : 开始滑动时监听   【Function(RangeValues)】\n"
          "【onChangeEnd】 : 滑动结束时监听   【Function(RangeValues)】\n"
          "【onChanged】 : 改变时回调   【Function(RangeValues)】",
      "code": """class CustomRangeSlider extends StatefulWidget {
  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues _rangeValues = RangeValues(90, 270);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
        values: _rangeValues,
        divisions: 180,
        min: 0.0,
        max: 360.0,
        labels: RangeLabels("\${_rangeValues.start.toStringAsFixed(1)}",
            "\${_rangeValues.end.toStringAsFixed(1)}"),
        activeColor: Colors.orangeAccent,
        inactiveColor: Colors.green.withAlpha(99),
        onChangeStart: (value) {
          print('开始滑动:\$value');
        },
        onChangeEnd: (value) {
          print('滑动结束:\$value');
        },
        onChanged: (value) {
          setState(() {
            _rangeValues = value;
          });
        });
  }
}"""
    },
  ],
  "Radio": [
    {
      "widgetId": 45,
      "name": 'Radio基本使用',
      "priority": 1,
      "subtitle": "【value】 : 选钮值   【T】\n"
          "【groupValue】 : 当前匹配值   【T】\n"
          "【activeColor】 : 激活颜色   【Color】\n"
          "【onChanged】 : 改变时回调   【Function(T)】",
      "code": """class CustomRadio extends StatefulWidget {
  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  var data = <double>[1, 2, 3, 4, 5];
  double _value = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: data
          .map((e) => Radio<double>(
          activeColor: Colors.orangeAccent,
          value: e,
          groupValue: _value,
          onChanged: (v) => setState(() => _value = v)))
          .toList(),
    );
  }
}"""
    },
  ],
  "CircularProgressIndicator": [
    {
      "widgetId": 46,
      "name": 'CircularProgressIndicator基本使用',
      "priority": 1,
      "subtitle": "【value】 : 进度   【double】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【valueColor】 : 进度颜色   【Animation<Color>】\n"
          "【strokeWidth】 : 线宽   【double】",
      "code": """class CustomCircularProgressIndicator extends StatefulWidget {
  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {

  var data = <double>[0.2,0.4,0.6,0.8,null];

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 10,
      children:data.map((e)=>Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          value: e,
          backgroundColor: Colors.grey.withAlpha(33),
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          strokeWidth: 5,
        ),
      )).toList(),
    );
  }
}"""
    },
  ],
  "LinearProgressIndicator": [
    {
      "widgetId": 47,
      "name": 'LinearProgressIndicator基本使用',
      "priority": 1,
      "subtitle": "【value】 : 进度   【double】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【valueColor】 : 进度颜色   【Animation<Color>】\n"
          "    value为null时会不停循环",
      "code": """class CustomLinearProgressIndicator extends StatefulWidget {
  @override
  _CustomLinearProgressIndicatorState createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator> {
  var data = <double>[0.2, 0.4, 0.6, 0.8, null];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: data
          .map((e) => Container(
        width: 50,
        height: 3,
        child:LinearProgressIndicator(
          value: e,
          backgroundColor: Colors.grey.withAlpha(33),
          valueColor: AlwaysStoppedAnimation(Colors.orange),
        ),
      ))
          .toList(),
    );
  }
}"""
    },
  ],
  "CupertinoActivityIndicator": [
    {
      "widgetId": 48,
      "name": 'CupertinoActivityIndicator基本使用',
      "priority": 1,
      "subtitle": "【animating】 : 是否loading动画   【bool】\n"
          "【radius】 : 半径   【double】",
      "code":
          """class CustomCupertinoActivityIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 20,
      children: <Widget>[
        CupertinoActivityIndicator(
          animating: true,
          radius: 25,
        ),
        CupertinoActivityIndicator(
          animating: false,
          radius: 25,
        )
      ],
    );
  }
}"""
    },
  ],
  "RefreshIndicator": [
    {
      "widgetId": 49,
      "name": 'RefreshIndicator基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子(可滑动)   【Widget】\n"
          "【displacement】 : 指示器悬浮高度   【double】\n"
          "【color】 : 指示器颜色   【Color】\n"
          "【backgroundColor】 : 指示器背景色   【Color】\n"
          "【onRefresh】: 异步函数   【Future<void> Function()】",
      "code": """class CustomRefreshIndicator extends StatefulWidget {
  @override
  _CustomRefreshIndicatorState createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {

    return Container(
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
            child: Text('\$_count',style: TextStyle(color: Colors.white,fontSize: 40)),
          ),
        ),
      ),
    );
  }

  Future<void> _increment() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _count++;
    });
  }
}"""
    },
  ],
  "Tooltip": [
    {
      "widgetId": 50,
      "name": 'Tooltip基本使用',
      "priority": 1,
      "subtitle": "【preferBelow】 : 是否首选下方   【bool】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
          "【margin】 : 外边距   【EdgeInsetsGeometry】\n"
          "【message】 : 消息内容   【String】\n"
          "【showDuration】 : 展示时间   【Duration】\n"
          "【waitDuration】 : 悬浮出现时间   【Duration】\n"
          "【child】 : 孩子   【Widget】",
      "code": """class CustomTooltip extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Tooltip(
      preferBelow: true,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      message: "天王盖地虎",
      showDuration: Duration(seconds: 3),
      waitDuration: Duration(milliseconds: 200),
      child: Icon(Icons.info_outline),
    );
  }
}"""
    },
    {
      "widgetId": 50,
      "name": 'Tooltip的装饰',
      "priority": 2,
      "subtitle": "【decoration】 : 装饰对象 【Decoration】\n"
          "【textStyle】 : 文字样式   【double】",
      "code": """class DecorationTooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
        preferBelow: false,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(2),
        message: "宝塔镇河妖",
        textStyle: TextStyle(
            color: Colors.red,
            shadows: [Shadow(color: Colors.white, 
                offset: Offset(1, 1))]),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.orangeAccent, 
              offset: Offset(1, 1), blurRadius: 8)
        ]),
        child: Icon(Icons.info_outline));
  }
}"""
    },
  ],
  "ExpandIcon": [
    {
      "widgetId": 51,
      "name": 'ExpandIcon基本使用',
      "priority": 1,
      "subtitle": "【isExpanded】 : 是否展开   【bool】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
          "【size】 : 图标大小   【double】\n"
          "【color】 : 不展开时颜色   【Color】\n"
          "【expandedColor】 : 展开时颜色   【Color】\n"
          "【onPressed】 : 点击事件   【Function(bool)】",
      "code": """class CustomExpandIcon extends StatefulWidget {
  @override
  _CustomExpandIconState createState() => _CustomExpandIconState();
}

class _CustomExpandIconState extends State<CustomExpandIcon> {
  var _closed = true;

  @override
  Widget build(BuildContext context) {
    return ExpandIcon(
      isExpanded: _closed,
      padding: EdgeInsets.all(5),
      size: 30,
      color: Colors.blue,
      expandedColor: Colors.orangeAccent,
      onPressed: (value) => setState(() => _closed = !_closed),
    );
  }
}"""
    }
  ],
  "ExpansionTile": [
    {
      "widgetId": 52,
      "name": 'ExpansionTile基本使用',
      "priority": 1,
      "subtitle": "【children】 : 展开内容   【List<Widget>】\n"
          "【leading】 : 头左组件   【Widget】\n"
          "【title】 : 头中组件   【Widget】\n"
          "【trailing】 : 头尾组件   【Widget】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【onExpansionChanged】 : 折叠事件   【Function(bool)】\n"
          "【initiallyExpanded】 : 是否初始时展开   【bool】",
      "code": """class CustomExpansionTile extends StatefulWidget {
  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {

  @override
  Widget build(BuildContext context) {

    return ExpansionTile(
      leading: Icon(Icons.star),
      title: Text("选择语言"),
      backgroundColor: Colors.grey.withAlpha(6),
      onExpansionChanged: (value){
        print('\$value');
      },
      initiallyExpanded: false,
      children: <Widget>[
        CustomRadioListTile()
      ],
    );
  }
}"""
    }
  ],
  "SelectableText": [
    {
      "widgetId": 53,
      "name": 'SelectableText基本使用',
      "priority": 1,
      "subtitle": "【入参】 : 显示文字   【String】\n"
          "【style】 : 文字样式   【TextStyle】\n"
          "【cursorRadius】 : 光标半径   【Radius】\n"
          "【cursorColor】 : 光标颜色   【Color】\n"
          "【cursorWidth】 : 光标宽度   【double】\n"
          "【showCursor】 : 是否显示光标   【bool】\n"
          "【autofocus】 : 自动聚焦   【bool】",
      "code": """class CustomSelectableText extends StatelessWidget {
  final text = "        始臣之解牛之时，所见无非牛者。三年之后，未尝见全牛也。方今之时，"
      "臣以神遇而不以目视，官知止而神欲行。依乎天理，批大郤，导大窾，因其固然，"
      "技经肯綮之未尝，而况大軱乎！良庖岁更刀，割也；族庖月更刀，折也。"
      "今臣之刀十九年矣，所解数千牛矣，而刀刃若新发于硎。彼节者有间，而刀刃者无厚；"
      "以无厚入有间，恢恢乎其于游刃必有余地矣，是以十九年而刀刃若新发于硎。"
      "虽然，每至于族，吾见其难为，怵然为戒，视为止，行为迟。动刀甚微，謋然已解，如土委地。"
      "提刀而立，为之四顾，为之踌躇满志，善刀而藏之.";

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: TextStyle(fontSize: 18, color: Colors.orange),
      cursorColor: Colors.green,
      cursorRadius: Radius.circular(3),
      cursorWidth: 5,
      showCursor: true,
      autofocus: false,
    );
  }
}"""
    },
    {
      "widgetId": 53,
      "name": 'SelectableText对齐属性',
      "priority": 2,
      "subtitle": "【textAlign】 : 对齐方式*6   【textAlign】\n"
          "【textDirection】 : 文字方向*2   【TextDirection】",
      "code": """class AlignSelectableText extends StatefulWidget {
  @override
  _AlignSelectableTextState createState() => _AlignSelectableTextState();
}

class _AlignSelectableTextState extends State<AlignSelectableText> {
  final text =
      "The [SelectableText] widget displays a string of text with a single style."
      "The string might break across multiple lines or might all be displayed on"
      "the same line depending on the layout constraints.";
  var _textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSelector(),
        SelectableText(
          text,
          style: TextStyle(fontSize: 18, color: Colors.red),
          cursorColor: Colors.green,
          cursorRadius: Radius.circular(3),
          textAlign: _textAlign,
          textDirection: TextDirection.ltr,
          cursorWidth: 5,
          showCursor: true,
          autofocus: false,
        ),
      ],
    );
  }

  Widget _buildSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "textAlign属性选择:",
          style: TextStyle(
              fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        DropdownButton<TextAlign>(
            underline: Container(),
            value: _textAlign,
            items: TextAlign.values
                .map((e) => DropdownMenuItem<TextAlign>(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (e) {
              setState(() {
                _textAlign = e;
              });
            }),
      ],
    );
  }
}"""
    },
  ],
  "TextField": [
    {
      "widgetId": 54,
      "name": 'TextField基本用法',
      "priority": 1,
      "subtitle": "【controller】 : 控制器   【TextEditingController】\n"
          "【style】 : 文字样式   【TextStyle】\n"
          "【decoration】 : 装饰线   【InputDecoration】\n"
          "【onEditingComplete】 : 输入完成事件   【Function()】\n"
          "【onSubmitted】 : 提交事件   【Function(String)】\n"
          "【onChanged】 : 输入事件   【Function(String)】",
      "code": """class CustomTextField extends StatefulWidget {
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          controller: _controller,
          style: TextStyle(color: Colors.blue),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'username',
          ),
          onEditingComplete: () {
            print('onEditingComplete');
          },
          onChanged: (v) {
            print('onChanged:' + v);
          },
          onSubmitted: (v) {
            FocusScope.of(context).requestFocus(_focusNode);
            print('onSubmitted:' + v);
            _controller.clear();
          },
        ));
  }
}"""
    },
    {
      "widgetId": 54,
      "name": 'TextField基本用法',
      "priority": 2,
      "subtitle": "【minLines】 : 最小行数   【int】\n"
          "【maxLines】 : 最大行数   【int】\n"
          "【cursorRadius】 : 光标半径   【Radius】\n"
          "【cursorColor】 : 光标颜色   【Color】\n"
          "【cursorWidth】 : 光标宽度   【double】\n"
          "【showCursor】 : 是否显示光标   【bool】\n"
          "【autofocus】 : 自动聚焦   【bool】",
      "code": """class CursorTextField extends StatefulWidget {
  @override
  _CursorTextFieldState createState() => _CursorTextFieldState();
}

class _CursorTextFieldState extends State<CursorTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildSubmitBtn(),
        _buildTextField(context),
      ],
    );
  }

  Container _buildTextField(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        style: TextStyle(color: Colors.blue),
        minLines: 3,
        maxLines: 5,
        cursorColor: Colors.green,
        cursorRadius: Radius.circular(3),
        cursorWidth: 5,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "请输入...",
          border: OutlineInputBorder(),
        ),
        onChanged: (v) {},
      ),
    );
  }

  _buildSubmitBtn() => FlatButton(
      color: Colors.blue,
      child: Text(
        "提交",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () => FocusScope.of(context).requestFocus(_focusNode));
}"""
    },
    {
      "widgetId": 54,
      "name": 'decoration的复杂装饰',
      "priority": 3,
      "subtitle": "InputDecoration有非常多的装饰点,对应点缀见代码:\n"
          "border: 边线相关\n"
          "helper: 左下角相关提示\n"
          "counter: 右下角相关提示\n"
          "prefix: 输入框内部最左侧\n"
          "suffix: 输入框内部最右侧\n"
          "label: 无焦点时文字\n"
          "label: 无焦点时文字\n"
          "hint: 提示文字相关\n"
          "border: 边线相关",
      "code": """class ComplexTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      labelText: 'username',
      labelStyle: TextStyle(color: Colors.purple),
      helperText: "help me",
      helperStyle: TextStyle(color: Colors.blue),

      suffixText: "suffix",
      suffixIcon: Icon(Icons.done),
      suffixStyle: TextStyle(color: Colors.green),

      counterText: "counter",
      counterStyle: TextStyle(color: Colors.orange),

      prefixText: "ID  ",
      prefixStyle: TextStyle(color: Colors.blue),
      prefixIcon: Icon(Icons.language),

      fillColor: Color(0x110099ee),
      filled: true,

      //  errorText: "error",
      //  errorMaxLines: 1,
      //  errorStyle: TextStyle(color: Colors.red),
      //  errorBorder: UnderlineInputBorder(),

      hintText: "请输入用户名",
      hintMaxLines: 1,
      hintStyle: TextStyle(color: Colors.black38),
      icon: Icon(Icons.assignment_ind),
    ));
  }
}"""
    },
  ],
  "DropdownButton": [
    {
      "widgetId": 55,
      "name": 'DropdownButton基本用法',
      "priority": 1,
      "subtitle": "【value】 : 当前值   【T】\n"
          "【items】 : 下拉选框   【List<DropdownMenuItem<T>>】\n"
          "【icon】 : 图标   【Widget】\n"
          "【elevation】 : 影深   【double】\n"
          "【onChanged】 : 选择条目事件   【Function(T)】\n"
          "【backgroundColor】 : 背景色   【Color】",
      "code": """class CustomDropDownButton extends StatefulWidget {
  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  Color _color = Colors.red;
  final _colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  final _info = ["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color,
        ),
        DropdownButton<Color>(
            value: _color,
            elevation: 1,
            icon: Icon(
              Icons.expand_more,
              size: 20,
              color: _color,
            ),
            items: _buildItems(),
            onChanged: (v) => setState(() => _color = v)),
      ],
    );
  }

  List<DropdownMenuItem<Color>> _buildItems() => _colors
      .map((e) => DropdownMenuItem<Color>(
          value: e,
          child: Text(
            _info[_colors.indexOf(e)],
            style: TextStyle(color: e),
          )))
      .toList();
}"""
    },
    {
      "widgetId": 55,
      "name": 'DropdownButton基本用法',
      "priority": 2,
      "subtitle": "【isDense】 : 是否紧排   【bool】\n"
          "【iconSize】 : 图标大小   【double】\n"
          "【hint】 : 提示组件   【Widget】\n"
          "【iconEnabledColor】 : 图标颜色   【Color】",
      "code": """class StyleDropDownButton extends StatefulWidget {
  @override
  _StyleDropDownButtonState createState() => _StyleDropDownButtonState();
}

class _StyleDropDownButtonState extends State<StyleDropDownButton> {
  Color _color = Colors.red;
  final _colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  final _info = ["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color??Colors.transparent,
        ),
        DropdownButton<Color>(
            hint: Text('请选择'),
            isDense: true,
            iconSize:20,
            iconEnabledColor:_color??Colors.orange,
            value: _color,
            items: _buildItems(),
            onChanged: (v) => setState(() => _color = v)),
      ],
    );
  }

  List<DropdownMenuItem<Color>> _buildItems() => _colors
      .map((e) => DropdownMenuItem<Color>(
          value: e,
          child: Text(
            _info[_colors.indexOf(e)],
            style: TextStyle(color: e),
          )))
      .toList();
}"""
    },
  ],
  "PopupMenuButton": [
    {
      "widgetId": 56,
      "name": 'PopupMenuButton基本使用',
      "priority": 1,
      "subtitle": "【itemBuilder】 : 构造器   【PopupMenuItemBuilder<T>】\n"
          "【offset】 : 偏移   【Offset】\n"
          "【color】 : 背景颜色   【Color】\n"
          "【shape】 : 形状   【ShapeBorder】\n"
          "【elevation】 : 影深   【double】\n"
          "【onCanceled】 : 取消事件   【Function()】\n"
          "【onSelected】 : 选择事件   【Function(T)】",
      "code":
          """class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  final map = {
    "关于": Icons.info_outline,
    "帮助": Icons.help_outline,
    "问题反馈": Icons.add_comment,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => buildItems(),
      offset: Offset(0, 50),
      color: Color(0xffF4FFFA),
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      )),
      onSelected: (e) {
        print(e);
        if (e == '关于') {
          DialogAbout.show(context);
        }
      },
      onCanceled: () => print('onCanceled'),
    );
  }

  List<PopupMenuItem<String>> buildItems() {
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
            value: e,
            child: Wrap(
              spacing: 10,
              children: <Widget>[
                Icon(
                  map[e],
                  color: Colors.blue,
                ),
                Text(e),
              ],
            )))
        .toList();
  }
}"""
    },
  ],
  "AppBar": [
    {
      "widgetId": 57,
      "name": 'AppBar基本使用',
      "priority": 1,
      "subtitle": "【leading】 : 左侧组件   【Widget】\n"
          "【title】 : 中间组件   【Widget】\n"
          "【actions】 : 右侧组件   【List<Widget>】\n"
          "【elevation】 : 影深   【double】\n"
          "【shape】 : 形状   【ShapeBorder】\n"
          "【backgroundColor】 : 影深   【背景色】\n"
          "【centerTitle】 : 中间是否居中   【bool】",
      "code": """class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('风雅六社'),
      leading: BackButton(),
      backgroundColor: Colors.amber[500],
      elevation: 2,
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      )),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.star),
            tooltip: 'like',
            onPressed: () {
              // do nothing
            }),
        CustomPopupMenuButton()
      ],
    );
  }
}"""
    },
    {
      "widgetId": 57,
      "name": 'AppBar与TabBar、TabBarView联用',
      "priority": 2,
      "subtitle": "【bottom】 : 底部组件   【PreferredSizeWidget】",
      "code": """class TabAppBar extends StatefulWidget {
  @override
  _TabAppBarState createState() => _TabAppBarState();
}

class _TabAppBarState extends State<TabAppBar>
    with SingleTickerProviderStateMixin {
  final tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/sabar.jpg",
                  ),
                  fit: BoxFit.cover)),
          child: _buildAppBar(),
        ),
        Container(
            height: 50, color: Color(0xff916BF0), child: _buildTableBarView())
      ],
    );
  }

  Widget _buildAppBar() => AppBar(
        title: Text('风雅六社'),
        elevation: 1,
        leading: BackButton(),
        backgroundColor: Colors.amber[500].withAlpha(33),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.star),
              tooltip: 'like',
              onPressed: () {
                // do nothing
              }),
          CustomPopupMenuButton()
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.orangeAccent,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => Center(
                  child: Text(
                e,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )))
          .toList());
}"""
    },
  ],
  "TabBar": [
    {
      "widgetId": 58,
      "name": 'TabBar基本使用',
      "priority": 1,
      "subtitle": "【controller】 : 控制器   【TabController】\n"
          "【indicatorColor】 : 指示器颜色   【指示器颜色】\n"
          "【indicatorWeight】 : 指示器高   【double】\n"
          "【indicatorPadding】 : 指示器边距   【EdgeInsetsGeometry】\n"
          "【labelStyle】 : 选中文字样式   【TextStyle】\n"
          "【unselectedLabelStyle】 : 未选中文字样式   【TextStyle】\n"
          "【isScrollable】 : 是否可滑动   【bool】\n"
          "【onTap】 : 页签点击回调   【Function(int)】\n"
          "【tabs】 : 标签组件   【List<Widget>】",
      "code": """class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  final tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: (tab) {
        print(tab);
      },
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 16),
      isScrollable: true,
      controller: _tabController,
      labelColor: Colors.blue,
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orangeAccent,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }
}"""
    },
    {
      "widgetId": 58,
      "name": '通过修改源码可实现无水波纹',
      "priority": 1,
      "subtitle": "详见:components/flutter/no_shadow_tab_bar.dart",
      "code": """class NoShadowTabBarDemo extends StatefulWidget {
  @override
  _NSTabBarState createState() => _NSTabBarState();
}

class _NSTabBarState extends State<NoShadowTabBarDemo>
    with SingleTickerProviderStateMixin {
  final tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NoShadowTabBar(
      onTap: (tab) {
        print(tab);
      },
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 16),
      isScrollable: true,
      controller: _tabController,
      labelColor: Colors.blue,
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orangeAccent,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }
}"""
    },
  ],
  "TabBarView": [
    {
      "widgetId": 59,
      "name": 'TabBarView需要与TabBar联用',
      "priority": 1,
      "subtitle": "【controller】 : 控制器   【TabController】\n"
          "【children】 : 孩子们   【指示器颜色】\n"
          "【physics】 : 表现   【ScrollPhysics】",
      "code": """class CustomTabBarView extends StatefulWidget {
  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> with SingleTickerProviderStateMixin {
  final tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTabBar(),
          Container(
              color: Colors.purple,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: _buildTableBarView())
        ],
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
      onTap: (tab) => print(tab),
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 16),
      isScrollable: true,
      controller: _tabController,
      labelColor: Colors.blue,
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orangeAccent,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) => Center(
                  child: Text(e, style: TextStyle(color: Colors.white, fontSize: 20),
              ))).toList());
}"""
    },
  ],
  "BottomNavigationBar": [
    {
      "widgetId": 60,
      "name": 'BottomNavigationBar基本使用',
      "priority": 1,
      "subtitle": "【currentIndex】 : 当前索引   【int】\n"
          "【elevation】 : 影深   【double】\n"
          "【type】 : 类型*2   【BottomNavigationBarType】\n"
          "【fixedColor】 : type为fix的颜色   【Color】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【iconSize】 : 图标大小   【double】\n"
          "【selectedLabelStyle】 : 选中文字样式   【TextStyle】\n"
          "【unselectedLabelStyle】 : 未选中文字样式   【TextStyle】\n"
          "【showUnselectedLabels】 : 显示未选中标签   【bool】\n"
          "【showSelectedLabels】 : 显示选中标签   【bool】\n"
          "【items】 : 条目   【List<BottomNavigationBarItem>】\n"
          "【onTap】 : 点击事件   【Function(int)】",
      "code": """class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var _position = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  final iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildOp(),
        _buildBottomNavigationBar(),
      ],
    );
  }

  bool get isShifting => _type == BottomNavigationBarType.shifting;

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (position) => setState(() => _position = position),
      currentIndex: _position,
      elevation: 1,
      type: _type,
      fixedColor: isShifting ? Colors.white : _colors[_position],
      backgroundColor: Colors.white,
      iconSize: 25,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: iconsMap.keys
          .map((key) => BottomNavigationBarItem(
              title: Text(
                key,
              ),
              icon: Icon(Cons.ICONS_MAP[key]),
              backgroundColor: _colors[_position]))
          .toList(),
    );
  }

  Widget _buildOp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          _type.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Switch(
            value: _type == BottomNavigationBarType.shifting,
            onChanged: (b) {
              setState(() => _type = b
                  ? BottomNavigationBarType.shifting
                  : BottomNavigationBarType.fixed);
            }),
      ],
    );
  }
}
"""
    },
    {
      "widgetId": 60,
      "name": '可结合PageView进行切页',
      "priority": 2,
      "subtitle": "在onTap时进行使用控制器进行切页",
      "code": """class BottomNavigationBarWithPageView extends StatefulWidget {
  @override
  _BottomNavigationBarWithPageViewState createState() =>
      _BottomNavigationBarWithPageViewState();
}

class _BottomNavigationBarWithPageViewState
    extends State<BottomNavigationBarWithPageView> {
  var _position = 0;
  final iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];
  PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    _controller = PageController(
      initialPage: _position,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.orange.withAlpha(88),
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: PageView(
              controller: _controller,
              children: iconsMap.keys
                  .map((e) => Center(
                        child: Text(
                          e,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))
                  .toList(),
            ),
          ),
          _buildBottomNavigationBar()
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (position) {
        _controller.jumpToPage(position);
        setState(() => _position = position);
      },
      currentIndex: _position,
      elevation: 1,
      type: BottomNavigationBarType.shifting,
      fixedColor: Colors.white,
      backgroundColor: Colors.white,
      iconSize: 25,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: iconsMap.keys
          .map((key) => BottomNavigationBarItem(
              title: Text(
                key,
              ),
              icon: Icon(iconsMap[key]),
              backgroundColor: _colors[_position]))
          .toList(),
    );
  }
}
"""
    },
  ],
  "BottomAppBar": [
    {
      "widgetId": 61,
      "name": 'BottomAppBar基本用法',
      "priority": 1,
      "subtitle": "【elevation】 : 影深   【double】\n"
          "【shape】 : 形状   【NotchedShape】\n"
          "【notchMargin】 : 间隔距离   【double】\n"
          "【color】 : 颜色   【Color】\n"
          "【child】 : 孩子   【Widget】",
      "code": """class CustomBottomAppBar extends StatefulWidget {
  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  var _position = 0;
  var _location = FloatingActionButtonLocation.centerDocked;
  final iconsMap = {
    "图鉴": Icons.home,
    "动态": Icons.toys,
    "喜欢": Icons.favorite,
    "手册": Icons.class_,
  };
  var activeColor = Colors.blue.withAlpha(240);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: Scaffold(
        backgroundColor: Colors.purple.withAlpha(22),
        floatingActionButton: FloatingActionButton(
          onPressed: () => DialogAbout.show(context),
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: _buildBottomAppBar(),
        floatingActionButtonLocation: _location,
        body: _buildContent(),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      elevation: 1,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.red,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: info.asMap().keys.map((i) => _buildChild(i)).toList()
            ..insertAll(isCenter ? 2 : 4, [SizedBox(width: 30)])),
    );
  }

  Container _buildContent() {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            '当前页索引:\$_position',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
          Switch(
              value: isCenter,
              onChanged: (v) {
                setState(() {
                  _location = v
                      ? FloatingActionButtonLocation.centerDocked
                      : FloatingActionButtonLocation.endDocked;
                });
              }),
        ],
      ),
    );
  }

  List<String> get info => iconsMap.keys.toList();

  bool get isCenter => _location == FloatingActionButtonLocation.centerDocked;

  Widget _buildChild(int i) {
    var active = i == _position;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => setState(() => _position = i),
        child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Icon(
              iconsMap[info[i]],
              color: active ? activeColor : Colors.white,
              size: 30,
            ),
            Text(info[i],
                style: TextStyle(
                    color: active ? activeColor : Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}"""
    },
  ],
  "CupertinoNavigationBar": [
    {
      "widgetId": 62,
      "name": 'CupertinoNavigationBar基本用法',
      "priority": 1,
      "subtitle": "【leading】 : 左侧组件   【Widget】\n"
          "【middle】 : 中间组件   【Widget】\n"
          "【trailing】 : 尾部组件   【Widget】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【padding】 : 内边距   【EdgeInsetsDirectional】\n"
          "【border】 : 边线   【Border】",
      "code": """class CustomCupertinoNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: Icon(
        CupertinoIcons.back,
        color: Colors.blue,
      ),
      middle: Text("风雪雅舍"),
      trailing: Image.asset(
        "assets/images/icon_head.png",
        width: 25.0,
        height: 25.0,
      ),
      backgroundColor: Color(0xfff1f1f1),
      padding: EdgeInsetsDirectional.only(start: 10,end: 20),
      border: Border.all(color: Colors.transparent),
    );
  }
}"""
    },
  ],
  "CupertinoTabBar": [
    {
      "widgetId": 63,
      "name": 'CupertinoNavigationBar基本用法',
      "priority": 1,
      "subtitle": "【currentIndex】 : 当前激活索引   【Widget】\n"
          "【items】 : 条目组件   【Widget】\n"
          "【trailing】 : 尾部组件   【Widget】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【inactiveColor】 : 非激活色   【Color】\n"
          "【activeColor】 : 激活色   【Color】\n"
          "【iconSize】 : 图标大小    【double】\n"
          "【border】 : 边线   【Border】\n"
          "【onTap】 : 点击事件   【Function(int)】",
      "code": """class CustomCupertinoTabBar extends StatefulWidget {
  @override
  _CustomCupertinoTabBarState createState() => _CustomCupertinoTabBarState();
}

class _CustomCupertinoTabBarState extends State<CustomCupertinoTabBar> {
  var _position = 0;
  final iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildContent(context),
        _buildTabBar(),
      ],
    );
  }

  Widget _buildTabBar() {
    return CupertinoTabBar(
      currentIndex: _position,
      onTap: (value) => setState(() => _position = value),
      items: iconsMap.keys
          .map((e) => BottomNavigationBarItem(
                icon: Icon(
                  iconsMap[e],
                ),
                title: Text(e),
              ))
          .toList(),
      activeColor: Colors.blue,
      inactiveColor: Color(0xff333333),
      backgroundColor: Color(0xfff1f1f1),
      iconSize: 25.0,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 150,
      color: Color(0xffE7F3FC),
      child: Text(
        iconsMap.keys.toList()[_position],
        style: TextStyle(color: Colors.blue, fontSize: 24),
      ),
    );
  }
}"""
    },
  ],
  "Scaffold": [
    {
      "widgetId": 64,
      "name": 'Scaffold基本用法',
      "priority": 1,
      "subtitle": "【appBar】 : 头部组件   【PreferredSizeWidget】\n"
          "【bottomNavigationBar】 : 底部组件   【Widget】\n"
          "【drawer】 : 左侧滑组件   【Widget】\n"
          "【endDrawer】 : 右侧滑组件   【Widget】\n"
          "【body】 : 内容组件   【Widget】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【floatingActionButton】 : 浮动按钮   【Widget】\n"
          "【floatingActionButtonLocation】 : 浮动按钮位置   【FloatingActionButtonLocation】",
      "code": """class CustomScaffold extends StatefulWidget {
  CustomScaffold({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

// AppBar 默认的实例,有状态
class _CustomScaffoldState extends State with SingleTickerProviderStateMixin {
  final tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  var _position = 0;
  final iconsMap = {
    "图鉴": Icons.home,
    "动态": Icons.toys,
    "喜欢": Icons.favorite,
    "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final _colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 300,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        drawer: _buildLeftDrawer(),
        endDrawer: _buildLeftDrawer(),
        appBar: AppBar(
          title: Text('风雅六社'),
          backgroundColor: Colors.blue,
          centerTitle: true,
          actions: <Widget>[Icon(Icons.star), CustomPopupMenuButton()],
          bottom: _buildTabBar(),
        ),
        body: _buildTableBarView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Drawer _buildLeftDrawer() => Drawer(
        elevation: 1,
        child: Image.asset(
          'assets/images/sabar.jpg',
          fit: BoxFit.cover,
        ),
      );

  Widget _buildTabBar() => TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: Colors.orangeAccent,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      );

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
        onTap: (position) => setState(() => _position = position),
        currentIndex: _position,
        elevation: 1,
        backgroundColor: Colors.white,
        iconSize: 25,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: iconsMap.keys
            .map((key) => BottomNavigationBarItem(
                title: Text(
                  key,
                ),
                icon: Icon(iconsMap[key]),
                backgroundColor: _colors[_position]))
            .toList(),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => Center(
                  child: Text(
                e,
                style: TextStyle(color: Colors.blue, fontSize: 20),
              )))
          .toList());
}"""
    },
  ],
  "MaterialApp": [
    {
      "widgetId": 65,
      "name": 'MaterialApp基本用法',
      "priority": 1,
      "subtitle": "【theme】 : 主题   【ThemeData】\n"
          "【title】 : 任务栏标题   【String】\n"
          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
          "【home】 : 主页   【Widget】",
      "code": """class CustomMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CustomScaffold(),
      ),
    );
  }
}"""
    },
  ],
  "ClipOval": [
    {
      "widgetId": 66,
      "name": 'ClipOval基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【clipBehavior】 : 裁剪行为   【Clip】\n"
          "【clipper】 : 裁剪器   【CustomClipper<Rect>】",
      "code": """class CustomClipOval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        ClipOval(
          child: Image.asset(
            "assets/images/wy_300x200.jpg",
            width: 150,
            height: 100,
          ),
        ),
        ClipOval(
          child: Image.asset(
            "assets/images/wy_300x200.jpg",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}"""
    },
  ],
  "ClipRect": [
    {
      "widgetId": 67,
      "name": 'ClipRect基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【clipBehavior】 : 裁剪行为   【Clip】\n"
          "【clipper】 : 裁剪器   【CustomClipper<Rect>】",
      "code": """"""
    },
  ],
  "ClipRRect": [
    {
      "widgetId": 68,
      "name": 'ClipRRect基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【borderRadius】 : 边线半径   【BorderRadius】\n"
          "【clipBehavior】 : 裁剪行为   【Clip】\n"
          "【clipper】 : 裁剪器   【CustomClipper<Rect>】",
      "code": """class CustomClipRRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.elliptical(35, 30)),
      child: Image.asset(
        "assets/images/wy_300x200.jpg",
        width: 150,
        height: 100,
      ),
    );
  }
}"""
    },
  ],
  "ClipPath": [
    {
      "widgetId": 69,
      "name": 'ClipPath基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【clipBehavior】 : 裁剪行为   【Clip】\n"
          "【clipper】 : 裁剪器   【CustomClipper<Path>】",
      "code": """class CustomClipPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(shape: _StarShapeBorder()),
      child: Image.asset(
        "assets/images/wy_300x200.jpg",
        width: 150,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _StarShapeBorder extends ShapeBorder {
  final Path _path = Path();

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) =>
      nStarPath(20, rect.height / 2, rect.height / 2 * 0.85,
          dx: rect.width / 2, dy: rect.height / 2);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  Path nStarPath(int num, double R, double r, {dx = 0, dy = 0}) {
    double perRad = 2 * pi / num;
    double radA = perRad / 2 / 2;
    double radB = 2 * pi / (num - 1) / 2 - radA / 2 + radA;
    _path.moveTo(cos(radA) * R + dx, -sin(radA) * R + dy);
    for (int i = 0; i < num; i++) {
      _path.lineTo(
          cos(radA + perRad * i) * R + dx, -sin(radA + perRad * i) * R + dy);
      _path.lineTo(
          cos(radB + perRad * i) * r + dx, -sin(radB + perRad * i) * r + dy);
    }
    _path.close();
    return _path;
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}"""
    },
  ],
  "DecoratedBox": [
    {
      "widgetId": 70,
      "name": 'DecoratedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【decoration】 : 装饰对象   【Decoration】\n"
          "【decoration】 : 裁剪行为   【Clip】\n"
          "【position】 : 前景色(左)/后景色(右)   【DecorationPosition】",
      "code": """class CustomDecoratedBox extends StatelessWidget {
  final rainbow = <int>[
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      children: <Widget>[_buildDecoratedBox1(), _buildDecoratedBox2()],
    );
  }

  Widget _buildDecoratedBox2() {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.black, width: 2)),
          //添加渐变色
          gradient: LinearGradient(
              stops: <double>[0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0],
              colors: rainbow.map((e) => Color(e)).toList()),
          boxShadow: [
            BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: Icon(
        Icons.android,
        size: 80,
        color: Colors.black.withAlpha(123),
      ),
    );
  }

  Widget _buildDecoratedBox1() {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
          //添加渐变色
          gradient: LinearGradient(
              stops: <double>[0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0],
              colors: rainbow.map((e) => Color(e)).toList()),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: Icon(
        Icons.android,
        size: 80,
        color: Colors.black.withAlpha(123),
      ),
    );
  }
}"""
    },
  ],
  "Offstage": [
    {
      "widgetId": 71,
      "name": 'Offstage基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【offstage】 : 是否消失   【bool】",
      "code": """class CustomOffstage extends StatefulWidget {
  @override
  _CustomOffstageState createState() => _CustomOffstageState();
}

class _CustomOffstageState extends State<CustomOffstage> {
  bool _off = false;

  @override
  Widget build(BuildContext context) {
    var radBox = Container(
      height: 50,
      width: 60,
      color: Colors.red,
      child: Switch(
          value: _off, 
          onChanged: (v) => setState(() => _off = v)),
    );

    return Container(
      width: 250,
      height: 200,
      child: Row(
        children: <Widget>[radBox, _buildOffStage(), radBox],
      ),
    );
  }

  Widget _buildOffStage() => Offstage(
      offstage: _off,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        color: Colors.blue,
        child: Text(
          "Offstage",
          style: TextStyle(fontSize: 20),
        ),
      ));
}"""
    },
  ],
  "RotatedBox": [
    {
      "widgetId": 72,
      "name": 'RotatedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【quarterTurns】 : 旋转多少个90°   【int】",
      "code": """class CustomRotatedBox extends StatefulWidget {
  @override
  _CustomRotatedBoxState createState() => _CustomRotatedBoxState();
}

class _CustomRotatedBoxState extends State<CustomRotatedBox> {
  int _quarterTurns = 0;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: _quarterTurns,
      child: GestureDetector(
          onTap: () => setState(() => _quarterTurns++),
          child: Icon(
            Icons.android,
            size: 60,
            color: Colors.blue,
          )),
    );
  }
}"""
    },
  ],
  "Opacity": [
    {
      "widgetId": 73,
      "name": 'Opacity基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【opacity】 : 透明度0~1   【double】",
      "code": """class CustomOpacity extends StatefulWidget {
  @override
  _CustomOpacityState createState() => _CustomOpacityState();
}

class _CustomOpacityState extends State<CustomOpacity> {
  var _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_buildSlider(), _buildOpacity()],
    );
  }
  
  Widget _buildOpacity() => Opacity(
        opacity: _opacity,
        child: Image.asset(
          'assets/images/icon_head.png',
          width: 100,
        ),
    
      );
  Widget _buildSlider() => Slider(
      divisions: 20,
      label: _opacity.toString(),
      value: _opacity,
      onChanged: (v) => setState(() => _opacity = v));
}"""
    },
  ],
  "Padding": [
    {
      "widgetId": 74,
      "name": 'Padding基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【padding】 : 内四边距   【EdgeInsetsGeometry】",
      "code": """"""
    },
  ],
  "Baseline": [
    {
      "widgetId": 75,
      "name": 'Baseline基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【baseline】 : 基线位置   【double】\n"
          "【baselineType】 : 基线类型   【TextBaseline】",
      "code": """class CustomBaseline extends StatefulWidget {
  @override
  _CustomBaselineState createState() => _CustomBaselineState();
}

class _CustomBaselineState extends State<CustomBaseline> {
  double _baseline=20;

  @override
  Widget build(BuildContext context) {

    var childBox = Text(//孩子组件
      '你好,Flutter',
      style: TextStyle(fontSize: 20,fontFamily: "Menlo"),
    );


    var baseline = Baseline(
        child: childBox,
        baseline: _baseline,
        baselineType: TextBaseline.alphabetic
    );

    return Column(
      children: <Widget>[
        _buildSlider(),
        Container(
          width: 100/0.618,
          height: 100,
          color: Colors.grey.withAlpha(22),
          child: baseline,
        ),
      ],
    );
  }

  Widget _buildSlider() => Slider(
      divisions: 20,
      min: 0,
      max: 60,
      label: _baseline.toString(),
      value: _baseline,
      onChanged: (v) => setState(() => _baseline = v));
}"""
    },
  ],
  "SizedBox": [
    {
      "widgetId": 76,
      "name": 'SizedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【width】 : 宽   【double】\n"
          "【height】 : 高   【double】",
      "code": """class CustomSizedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: Text("Static"),
    );

    var box = SizedBox(
      width: 80,
      height: 40,
      child: Container(
          color: Colors.orange,
          child: Icon(
            Icons.android,
            color: Colors.white,
          )),
    );

    return Container(
      color: Colors.grey.withAlpha(22),
      width: 200,
      height: 100,
      child: Row(
        children: <Widget>[child, box, child],
      ),
    );
  }
}"""
    },
  ],
  "AspectRatio": [
    {
      "widgetId": 77,
      "name": 'AspectRatio基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【aspectRatio】 : 宽高比例   【double】",
      "code": """class CustomAspectRatio extends StatefulWidget {
  @override
  _CustomAspectRatioState createState() => _CustomAspectRatioState();
}

class _CustomAspectRatioState extends State<CustomAspectRatio> {
  var _ratio = 0.75;

  @override
  Widget build(BuildContext context) {
    var child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: Text("Static"),
    );

    var box = AspectRatio(
      aspectRatio: _ratio,
      child: Container(
          color: Colors.orange,
          child: Icon(
            Icons.android,
            color: Colors.white,
          )),
    );

    return Column(
      children: <Widget>[
        _buildSlider(),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: Row(
            children: <Widget>[child, box, child],
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() => Slider(
      divisions: 20,
      min: 0.1,
      max: 2.0,
      label: _ratio.toStringAsFixed(2),
      value: _ratio,
      onChanged: (v) => setState(() => _ratio = v));
}"""
    },
  ],
  "Transform": [
    {
      "widgetId": 78,
      "name": '斜切变换skew',
      "priority": 1,
      "subtitle": "斜切x由R0C1数控制,入参为弧度值,表示斜切角度\n"
          "斜切y由R1C0数控制,入参为弧度值,表示斜切角度",
      "code": """class SkewTransform extends StatefulWidget {
  @override
  _SkewTransformState createState() => _SkewTransformState();
}

class _SkewTransformState extends State<SkewTransform> {
  Matrix4 _m4;
  double _alpha = 0;
  double _beta = 0;

  @override
  void initState() {
    _m4 = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_buildTransform(), Matrix4Shower(_m4)],
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildTransform() {
    _m4 = Matrix4.skew(_alpha, _beta);
    return Transform(
      transform: _m4,
      child: Container(
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.jpg',
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildSliders() => Column(
        children: <Widget>[
          Slider(
              min: -pi,
              max: pi,
              value: _alpha,
              divisions: 360,
              label: 'alpha:' + (_alpha * 180 / pi).toStringAsFixed(1) + "°",
              onChanged: (v) {
                setState(() {
                  _alpha = v;
                });
              }),
          Slider(
              min: -pi,
              max: pi,
              value: _beta,
              divisions: 360,
              label: 'beta:' + (_beta * 180 / pi).toStringAsFixed(1) + "°",
              onChanged: (v) {
                setState(() {
                  _beta = v;
                });
              })
        ],
      );
}

class Matrix4Shower extends StatelessWidget {
  final Matrix4 matrix4;

  Matrix4Shower(this.matrix4);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '\${matrix4.entry(0, 0).toStringAsFixed(1)},\${matrix4.entry(0, 1).toStringAsFixed(1)},\${matrix4.entry(0, 2).toStringAsFixed(1)},\${matrix4.entry(0, 3).toStringAsFixed(1)},\n'
        '\${matrix4.entry(1, 0).toStringAsFixed(1)},\${matrix4.entry(1, 1).toStringAsFixed(1)},\${matrix4.entry(1, 2).toStringAsFixed(1)},\${matrix4.entry(1, 3).toStringAsFixed(1)},\n'
        '\${matrix4.entry(2, 0).toStringAsFixed(1)},\${matrix4.entry(2, 1).toStringAsFixed(1)},\${matrix4.entry(2, 2).toStringAsFixed(1)},\${matrix4.entry(2, 3).toStringAsFixed(1)},\n'
        '\${matrix4.entry(3, 0).toStringAsFixed(1)},\${matrix4.entry(3, 1).toStringAsFixed(1)},\${matrix4.entry(3, 2).toStringAsFixed(1)},\${matrix4.entry(3, 3).toStringAsFixed(1)}',
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
    );
  }
}
"""
    },
    {
      "widgetId": 78,
      "name": '平移变换translationValues',
      "priority": 2,
      "subtitle": "平移x由R0C3数控制,入参为数值,表示平移长度\n"
          "平移y由R1C3数控制,入参为数值,表示平移长度\n"
          "平移z由R2C3数控制,入参为数值,表示平移长度",
      "code": """class TranslationTransform extends StatefulWidget {
  @override
  _TranslationTransformState createState() => _TranslationTransformState();
}

class _TranslationTransformState extends State<TranslationTransform> {
  Matrix4 _m4;
  double _x = 0;
  double _y = 0;
  double _z = 0;

  @override
  void initState() {
    _m4 = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_buildTransform(), Matrix4Shower(_m4)],
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildTransform() {
    _m4 = Matrix4.translationValues(_x, _y, _z);
    return Transform(
      transform: _m4,
      child: Container(
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.jpg',
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildSliders() => Column(
        children: <Widget>[
          Slider(
              min: -100,
              max: 100,
              value: _x,
              divisions: 360,
              label: 'x:\${_x.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _x = v;
                });
              }),
          Slider(
              min: -100,
              max: 100,
              value: _y,
              divisions: 360,
              label: 'y:\${_y.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _y = v;
                });
              }),
          Slider(
              min: -100,
              max: 100,
              value: _z,
              divisions: 360,
              label: 'z:\${_z.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _z = v;
                });
              })
        ],
      );
}"""
    },
    {
      "widgetId": 78,
      "name": '缩放变换diagonal3Values',
      "priority": 3,
      "subtitle": "缩放x由R0C0数控制,入参为数值,表示缩放分率\n"
          "缩放y由R1C2数控制,入参为数值,表示缩放分率\n"
          "缩放z由R2C2数控制,入参为数值,表示缩放分率",
      "code": """class ScaleTransform extends StatefulWidget {
  @override
  _ScaleTransformState createState() => _ScaleTransformState();
}

class _ScaleTransformState extends State<ScaleTransform> {
  Matrix4 _m4;
  double _x = 1.0;
  double _y = 1.0;
  double _z = 1.0;

  @override
  void initState() {
    _m4 = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_buildTransform(), Matrix4Shower(_m4)],
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildTransform() {
    _m4 = Matrix4.diagonal3Values(_x, _y, _z);
    return Transform(
      transform: _m4,
      child: Container(
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.jpg',
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildSliders() => Column(
        children: <Widget>[
          Slider(
              min: -2,
              max: 2,
              value: _x,
              divisions: 360,
              label: 'x:\${_x.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _x = v;
                });
              }),
          Slider(
              min: -2,
              max: 2,
              value: _y,
              divisions: 360,
              label: 'y:\${_y.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _y = v;
                });
              }),
          Slider(
              min: -2,
              max: 2,
              value: _z,
              divisions: 360,
              label: 'z:\${_z.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _z = v;
                });
              })
        ],
      );
}"""
    },
    {
      "widgetId": 78,
      "name": '旋转变换rotation',
      "priority": 4,
      "subtitle": "x旋转由R1C1、R1C2、R2C1、R2C2控制,入参表示弧度\n"
          "y旋转由R0C0、R0C2、R2C0、R2C2控制,入参表示弧度\n"
          "z旋转由R0C0、R0C1、R1C0、R1C1控制,入参表示弧度",
      "code": """class RotateTransform extends StatefulWidget {
  @override
  _RotateTransformState createState() => _RotateTransformState();
}

class _RotateTransformState extends State<RotateTransform> {
  Matrix4 _m4;
  double _x = 0;
  int _rotateFlag = 1;

  @override
  void initState() {
    _m4 = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_buildTransform(), Matrix4Shower(_m4)],
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildTransform() {
    if (_rotateFlag == 1) {
      _m4 = Matrix4.rotationX(_x);
    } else if (_rotateFlag == 2) {
      _m4 = Matrix4.rotationY(_x);
    } else {
      _m4 = Matrix4.rotationZ(_x);
    }

    return Transform(
      transform: _m4,
      child: Container(
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.jpg',
            fit: BoxFit.cover,
          )),
    );
  }

  final Map<int, String> map = {
    1: 'rotationX',
    2: 'rotationY',
    3: 'rotationZ',
  };

  Widget _buildSliders() => Column(
        children: <Widget>[
          Wrap(
            children: map.keys.map((key) => _buildChild(key)).toList(),
          ),
          Slider(
              min: -pi,
              max: pi,
              value: _x,
              divisions: 360,
              label: 'x:\${_x.toStringAsFixed(1)}',
              onChanged: (v) {
                setState(() {
                  _x = v;
                });
              }),
        ],
      );

  Padding _buildChild(int key) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        selectedColor: Colors.orange.withAlpha(55),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        pressElevation: 5,
        elevation: 3,
        avatar: CircleAvatar(child: Text(key.toString())),
        label: Text(map[key]),
        selected: _rotateFlag == key,
        onSelected: (bool value) {
          print(map[key]);
          setState(() {
            _x = 0;
            if (value) {
              _rotateFlag = key;
            }
          });
        },
      ),
    );
  }
}"""
    },
    {
      "widgetId": 78,
      "name": '透视变换rotation',
      "priority": 5,
      "subtitle": "由R3C1、R3C2、R3C3控制透视",
      "code": """class R3C2 extends StatefulWidget {
  @override
  _R3C2State createState() => _R3C2State();
}

class _R3C2State extends State<R3C2> {
  Matrix4 _m4;
  double _value = 0;
  double _rad = 0;

  @override
  Widget build(BuildContext context) {
    _m4 = Matrix4.identity()
//      ..setEntry(3, 0, _value) // x
//      ..setEntry(3, 1, _value)//   y
          ..setEntry(3, 2, _value) // z
          ..rotateY(_rad)
//      ..rotateX(_rad)
        ;
    return Column(
      children: <Widget>[
        Transform(
          transform: _m4,
          child: Container(
              color: Colors.cyanAccent,
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/wy_300x200.jpg',
                fit: BoxFit.cover,
              )),
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildSliders() => Column(
        children: <Widget>[
          Slider(
              min: -0.01,
              max: 0.01,
              value: _value,
              divisions: 360,
              label: 'x:\${_value.toStringAsFixed(5)}',
              onChanged: (v) {
                setState(() {
                  _value = v;
                });
              }),
          Slider(
              min: -pi,
              max: pi,
              value: _rad,
              divisions: 360,
              label: '角度:' + (_rad * 180 / pi).toStringAsFixed(1) + "°",
              onChanged: (v) {
                setState(() {
                  _rad = v;
                });
              }),
        ],
      );
}"""
    },
  ],
  "LimitedBox": [
    {
      "widgetId": 79,
      "name": 'LimitedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【maxHeight】 : 最大高   【double】\n"
          "【maxWidth】 : 最大宽   【double】",
      "code": """class CustomLimitedBox extends StatefulWidget {
  @override
  _CustomLimitedBoxState createState() => _CustomLimitedBoxState();
}

class _CustomLimitedBoxState extends State<CustomLimitedBox> {
  var _text = '';

  @override
  Widget build(BuildContext context) {
    var child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: Text("Static"),
    );

    var box = LimitedBox(
      maxHeight: 60,
      maxWidth: 100,
      child: Container(color: Colors.orange, child: Text(_text)),
    );
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: Row(
            children: <Widget>[child, UnconstrainedBox(child: box), child],
          ),
        ),
        _buildInput()
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '请输入',
        ),
        onChanged: (v) {
          setState(() {
            _text = v;
          });
        },
      ),
    );
  }
}"""
    },
  ],
  "ConstrainedBox": [
    {
      "widgetId": 80,
      "name": 'BoxConstraints基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【minWidth】 : 最小宽   【double】\n"
          "【minHeight】 : 最小高   【double】\n"
          "【maxHeight】 : 最大高   【double】\n"
          "【maxWidth】 : 最大宽   【double】",
      "code": """"class CustomConstrainedBox extends StatefulWidget {
  @override
  _CustomConstrainedBoxState createState() => _CustomConstrainedBoxState();
}

class _CustomConstrainedBoxState extends State<CustomConstrainedBox> {
  var _text = '';

  @override
  Widget build(BuildContext context) {
    var child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 40,
      height: 40,
      child: Text("Static"),
    );

    var box = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 50,
        minWidth: 20,
        maxHeight: 100,
        maxWidth: 150,
      ),
      child: Container(color: Colors.orange, child: Text(_text)),
    );
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: Row(
            children: <Widget>[child, UnconstrainedBox(child: box), child],
          ),
        ),
        _buildInput(),
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '请输入',
        ),
        onChanged: (v) {
          setState(() {
            _text = v;
          });
        },
      ),
    );
  }
}"""
    },
  ],
  "UnconstrainedBox": [
    {
      "widgetId": 81,
      "name": 'UnConstrainedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【constrainedAxis】 : 仍受约束的轴*2   【Axis】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】",
      "code": """class CustomUnConstrainedBox extends StatefulWidget {
  @override
  _CustomUnConstrainedBoxState createState() => _CustomUnConstrainedBoxState();
}

class _CustomUnConstrainedBoxState extends State<CustomUnConstrainedBox> {
  var _value = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[_buildUnconstrainedBox(), _buildConstrainedAxis()],
    );
  }

  Widget _buildUnconstrainedBox() {
    var child = Container(
      color: Colors.cyanAccent,
      width: 60,
      height: 60,
      child: Switch(
        value: _value,
        onChanged: (v) {
          setState(() {
            _value = v;
          });
        },
      ),
    );

    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 150,
          height: 100,
          child: _value
              ? UnconstrainedBox(alignment: Alignment.center, child: child)
              : child,
        ),
        Text(_value ? "已解除约束" : "子组件受约束")
      ],
    );
  }

  Widget _buildConstrainedAxis() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 150,
          height: 100,
          child: UnconstrainedBox(
              alignment: Alignment.center,
              constrainedAxis: Axis.vertical,
              child: Container(
                color: Colors.cyanAccent,
                width: 60,
                height: 60,
              )),
        ),
        Text("竖直方向仍约束")
      ],
    );
  }
}"""
    },
  ],
  "FractionallySizedBox": [
    {
      "widgetId": 82,
      "name": 'FractionallySizedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【widthFactor】 : 宽分率   【double】\n"
          "【heightFactor】 : 高分率   【double】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】",
      "code": """class CustomFractionallySizedBox extends StatefulWidget {
  @override
  _CustomFractionallySizedBoxState createState() =>
      _CustomFractionallySizedBoxState();
}

class _CustomFractionallySizedBoxState
    extends State<CustomFractionallySizedBox> {
  var _hf = 0.5;
  var _wf = 0.4;

  @override
  Widget build(BuildContext context) {
    var box = FractionallySizedBox(
      widthFactor: _wf,
      heightFactor: _hf,
      alignment: Alignment.center,
      child: Container(color: Colors.orange),
    );
    return Column(
      children: <Widget>[
        Container(
            color: Colors.grey.withAlpha(22),
            width: 200,
            height: 100,
            child: box),
        _buildSlider()
      ],
    );
  }

  Widget _buildSlider() => Column(
    children: <Widget>[
      Slider(
          divisions: 20,
          min: 0.0,
          max: 2,
          label: '宽分率:' + _wf.toStringAsFixed(1),
          value: _wf,
          onChanged: (v) => setState(() => _wf = v)),
      Slider(
          divisions: 20,
          min: 0.0,
          max: 2,
          label: '高分率:' + _hf.toStringAsFixed(1),
          value: _hf,
          onChanged: (v) => setState(() => _hf = v)),
    ],
  );
}"""
    },
  ],
  "OverflowBox": [
    {
      "widgetId": 83,
      "name": 'OverflowBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【minWidth】 : 最小宽   【double】\n"
          "【minHeight】 : 最小高   【double】\n"
          "【maxHeight】 : 最大高   【double】\n"
          "【maxWidth】 : 最大宽   【double】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】",
      "code": """class CustomOverflowBox extends StatefulWidget {
  @override
  _CustomOverflowBoxState createState() => _CustomOverflowBoxState();
}

class _CustomOverflowBoxState extends State<CustomOverflowBox> {
  var _text = '';

  @override
  Widget build(BuildContext context) {
    var box = OverflowBox(
      alignment: Alignment.center,
      minHeight: 50,
      minWidth: 50,
      maxWidth: 200,
      maxHeight: 120,
      child: Container(
        color: Colors.orange,
        child: Text(_text),
      ),
    );
    return Column(
      children: <Widget>[
        Container(
            color: Colors.grey.withAlpha(33),
            width: 100,
            height: 100,
            child: box),
        _buildInput()
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '请输入',
        ),
        onChanged: (v) {
          setState(() {
            _text = v;
          });
        },
      ),
    );
  }
}"""
    },
  ],
  "SizedOverflowBox": [
    {
      "widgetId": 84,
      "name": 'SizedOverflowBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【size】 : 尺寸偏移   【Size】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】",
      "code": """class CustomSizedOverflowBox extends StatefulWidget {

  @override
  _CustomSizedOverflowBoxState createState() => _CustomSizedOverflowBoxState();
}

class _CustomSizedOverflowBoxState extends State<CustomSizedOverflowBox> {
  double _x = 50;
  double _y = 44;

  @override
  Widget build(BuildContext context) {
    var box = SizedOverflowBox(
      alignment: Alignment.bottomRight,
      size: Size(_x, _y),
      child: Container(width: 30, height: 50, color: Colors.orange),
    );
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            color: Colors.grey.withAlpha(88),
            width: 250,
            height: 60,
            child: box),
        _buildSlider()
      ],
    );
  }

  Widget _buildSlider() =>
      Column(
        children: <Widget>[
          Slider(
              divisions: 100,
              min: 0,
              max: 250,
              label: 'x:' + _x.toStringAsFixed(1),
              value: _x,
              onChanged: (v) => setState(() => _x = v)),
          Slider(
              divisions: 100,
              min: 0,
              max: 100,
              label: 'y:' + _y.toStringAsFixed(1),
              value: _y,
              onChanged: (v) => setState(() => _y = v)),

        ],
      );
}"""
    },
  ],
  "Align": [
    {
      "widgetId": 85,
      "name": 'Align基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】",
      "code": """class CustomAlign extends StatelessWidget {
  final alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  final alignmentsInfo = [
    "topLeft",
    "topCenter",
    "topRight",
    "centerLeft",
    "center",
    "centerRight",
    "bottomLeft",
    "bottomCenter",
    "bottomRight",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: alignments
            .toList()
            .map((mode) => Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(5),
                      width: 100,
                      height: 60,
                      color: Colors.grey.withAlpha(88),
                      child: Align(
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.cyanAccent,
                          ),
                          alignment: mode)),
                  Text(alignmentsInfo[alignments.indexOf(mode)])
                ]))
            .toList());
  }

}"""
    },
    {
      "widgetId": 85,
      "name": 'Align其他用法',
      "priority": 2,
      "subtitle": "由于Alignment对象可指定在父容器中宽高的分率位置\n"
          "可以使用Align实现一些复杂的排布需求，比如按指定的数学方程变化位置",
      "code": """class Ball extends StatelessWidget {
  Ball({
    Key key,
    this.radius = 15,
    this.color = Colors.blue,
  }) : super(key: key);
  final double radius; //半径
  final Color color; //颜色

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class SinLayout extends StatefulWidget {
  SinLayout({
    Key key,
  }) : super(key: key);

  @override
  _SinLayoutState createState() => _SinLayoutState();
}

class _SinLayoutState extends State<SinLayout> {
  var _x = 0.0; //Alignment坐标系上的x坐标

  @override
  Widget build(BuildContext context) {
    var item = Container(
      width: 300,
      height: 120,
      color: Colors.black.withAlpha(10),
      child: Align(
        child: Ball(
          color: Colors.orangeAccent,
        ),
        alignment: Alignment(_x, f(_x * pi)),
      ),
    );

    var slider = Slider(
        max: 180,
        min: -180,
        divisions: 360,
        label: "\${_x.toStringAsFixed(2)}π",
        value: _x * 180,
        onChanged: (v) => setState(() => _x = v / 180));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[slider, item],
    );
  }

  double f(x) {
    //映射函数 -- 可随意指定
    double y = sin(x);
    return y;
  }
}"""
    },
  ],
  "Center": [
    {
      "widgetId": 86,
      "name": 'Center基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】",
      "code": """class CustomCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        width: 200,
        height: 100,
        color: Colors.grey.withAlpha(88),
        child: Center(
            child: Container(
          width: 80,
          height: 60,
          color: Colors.cyanAccent,
        )));
  }
}"""
    },
  ],
  "FittedBox": [
    {
      "widgetId": 87,
      "name": 'FittedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【fit】 : 适应模式   【BoxFit】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】",
      "code": """class CustomFittedBox extends StatefulWidget {
  @override
  _CustomFittedBoxState createState() => _CustomFittedBoxState();
}

class _CustomFittedBoxState extends State<CustomFittedBox> {
  double _childW = 20;
  double _childH = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: BoxFit.values
                .map((mode) => Column(
                      children: <Widget>[
                        _buildChild(mode),
                        SizedBox(
                          height: 10,
                        ),
                        Text(mode.toString().split('.')[1])
                      ],
                    ))
                .toList()),
        _buildSlider()
      ],
    );
  }

  Widget _buildChild(BoxFit m) {
    return Container(
      color: Colors.grey.withAlpha(44),
      width: 80,
      height: 60,
      child: FittedBox(
        fit: m,
        child: Container(
          width: _childW,
          height: _childH,
          decoration: BoxDecoration(
            //添加渐变色
            gradient: LinearGradient(
                stops: <double>[0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0],
                colors: Cons.rainbow.map((e) => Color(e)).toList()),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider() => Column(
        children: <Widget>[
          Slider(
              min: 10,
              max: 150,
              divisions: 100,
              label: '子宽度:' + _childW.toStringAsFixed(1),
              value: _childW,
              onChanged: (v) => setState(() => _childW = v)),
          Slider(
              min: 10,
              max: 150,
              divisions: 100,
              label: '子高度:' + _childH.toStringAsFixed(1),
              value: _childH,
              onChanged: (v) => setState(() => _childH = v)),
        ],
      );
}"""
    },
  ],
  "ColorFiltered": [
    {
      "widgetId": 88,
      "name": 'FittedBox基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【colorFilter】 : 滤色器   【ColorFilter】",
      "code": """class CustomColorFiltered extends StatefulWidget {
  @override
  _CustomColorFilteredState createState() => _CustomColorFilteredState();
}

class _CustomColorFilteredState extends State<CustomColorFiltered> {
  Color _color = Colors.blue.withAlpha(88);

  @override
  Widget build(BuildContext context) {
    _color = ColorUtils.randomColor();
    return Column(
      children: <Widget>[
        Wrap(spacing: 10, runSpacing: 10, children: [
          _buildRandomColor(),
          ...BlendMode.values
              .map((mode) => Column(
                    children: <Widget>[
                      _buildChild(mode),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        mode.toString().split('.')[1],
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ))
              .toList()
        ]),
      ],
    );
    ;
  }

  Widget _buildChild(m) => Container(
        width: 58,
        height: 58,
        child: ColorFiltered(
            child: Image(image: AssetImage("assets/images/icon_head.png")),
            colorFilter: ColorFilter.mode(_color, m)),
      );

  Widget _buildRandomColor() => GestureDetector(
        onTap: () => setState(() {}),
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          child: Text('点我'),
        ),
      );
}"""
    },
  ],
  "FadeTransition": [
    {
      "widgetId": 89,
      "name": 'FadeTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【opacity】 : 动画   【Animation<double>】",
      "code": """class CustomFadeTransition extends StatefulWidget {
  @override
  _CustomFadeTransitionState createState() => _CustomFadeTransitionState();
}

class _CustomFadeTransitionState extends State<CustomFadeTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _ctrl.reset();
          _ctrl.forward();
        });
      },
      child: Container(
        color: Colors.grey.withAlpha(22),
        width: 100,
        height: 100,
        child: FadeTransition(
          opacity: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
          child: Icon(Icons.android, color: Colors.green, size: 60),
        ),
      ),
    );
  }
}"""
    },
  ],
  "RotationTransition": [
    {
      "widgetId": 90,
      "name": 'RotationTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【turns】 : 动画   【Animation<double>】",
      "code": """class CustomRotationTransition extends StatefulWidget {
  @override
  _CustomRotationTransitionState createState() => _CustomRotationTransitionState();
}

class _CustomRotationTransitionState extends State<CustomRotationTransition> with SingleTickerProviderStateMixin{

  AnimationController _ctrl;

  @override
  void initState() {
     _ctrl= AnimationController(vsync: this,duration: Duration(seconds: 2));
     _ctrl.forward();
    super.initState();
  }
@override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          _ctrl.reset();
          _ctrl.forward();
        });
      },
      child: Container(
        color: Colors.grey.withAlpha(22),
        width: 100,
        height: 100,
        child: RotationTransition(
          turns: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
          child: Icon(Icons.android,color: Colors.green,size: 60),
        ),
      ),
    );
  }
}"""
    },
  ],
  "ScaleTransition": [
    {
      "widgetId": 91,
      "name": 'ScaleTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【scale】 : 动画   【Animation<double>】",
      "code": """class CustomScaleTransition extends StatefulWidget {
  @override
  _CustomScaleTransitionState createState() => _CustomScaleTransitionState();
}

class _CustomScaleTransitionState extends State<CustomScaleTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          color: Colors.grey.withAlpha(22),
          width: 100,
          height: 100,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Icon(Icons.android, color: Colors.green, size: 60),
          ),
        ));
  }
}"""
    },
  ],
  "SizeTransition": [
    {
      "widgetId": 92,
      "name": 'FadeTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【axis】 : 轴向*2   【Axis】\n"
          "【sizeFactor】 : 动画   【Animation<double>】",
      "code": """class CustomSizeTransition extends StatefulWidget {
  @override
  _CustomSizeTransitionState createState() => _CustomSizeTransitionState();
}

class _CustomSizeTransitionState extends State<CustomSizeTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _ctrl.reset();
          _ctrl.forward();
        });
      },
      child: Wrap(
        runSpacing: 20,
        children: <Widget>[
          SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child: Icon(Icons.android, color: Colors.green, size: 80)),
          ),
          SizeTransition(
            axis: Axis.vertical,
            sizeFactor: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.orange,
                child: Icon(Icons.android, color: Colors.green, size: 80)),
          ),
        ],
      ),
    );
  }
}"""
    },
  ],
  "PositionedTransition": [
    {
      "widgetId": 93,
      "name": 'PositionedTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【rect】 : 动画   【Animation<RelativeRect>】\n"
          "    PositionedTransition组件只能在Stack内起作用",
      "code": """class CustomPositionedTransition extends StatefulWidget {
  @override
  _CustomPositionedTransitionState createState() =>
      _CustomPositionedTransitionState();
}

class _CustomPositionedTransitionState extends State<CustomPositionedTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: <Widget>[
              PositionedTransition(
                rect: RelativeRectTween(
                  begin: RelativeRect.fromLTRB(0, 50, 150, 100),
                  end: RelativeRect.fromLTRB(60, 0, 150, -50),
                ).animate(_ctrl),
                child: Icon(
                  Icons.android,
                  color: Colors.green,
                  size: 50,
                ),
              )
            ],
          ),
        ));
  }
}"""
    },
  ],
  "Flex": [
    {
      "widgetId": 94,
      "name": 'Flex的排布方向',
      "priority": 1,
      "subtitle":
      "【children】 : 组件列表   【List<Widget>】\n"
          "【direction】 : 方向   【Axis】",
      "code": """class DirectionFlex extends StatelessWidget {

 final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

 final blueBox= Container(
    color: Colors.blue,
   height: 20,
   width: 30,
  );

 final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: Axis.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}"""
    },
    {
      "widgetId": 94,
      "name": 'Flex主轴对齐方式',
      "priority": 2,
      "subtitle":
      "【mainAxisAlignment】 : 主轴对齐   【MainAxisAlignment】",
      "code": """class MainAxisAlignmentFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 5,
        children: MainAxisAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    mainAxisAlignment: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}"""
    },
    {
      "widgetId": 94,
      "name": 'Flex交叉轴对齐方式',
      "priority": 3,
      "subtitle":
          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】",
      "code": """class CrossAxisAlignmentFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: CrossAxisAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    crossAxisAlignment: mode,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}"""
    },
    {
      "widgetId": 94,
      "name": 'Flex垂直方向顺序',
      "priority": 4,
      "subtitle":
          "【verticalDirection】 : 垂直方向顺序   【VerticalDirection】",
      "code": """class VerticalDirectionFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: VerticalDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.vertical,
    verticalDirection: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}"""
    },
    {
      "widgetId": 94,
      "name": 'Flex水平方向顺序',
      "priority": 5,
      "subtitle":
          "【textDirection】 : 水平方向顺序   【TextDirection】",
      "code": """class TextDirectionFlex extends StatelessWidget {

  final  redBox= Container(
    color: Colors.red,
    height: 30,
    width: 40,
  );

  final blueBox= Container(
    color: Colors.blue,
    height: 20,
    width: 30,
  );

  final greenBox= Container(
    color: Colors.green,
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: TextDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.horizontal,
    textDirection: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}"""
    },
  ],
  "Row": [
    {
      "widgetId": 95,
      "name": 'Row基本使用',
      "priority": 1,
      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
          "【mainAxisAlignment】 : 主轴对齐   【MainAxisAlignment】\n"
          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】\n"
          "【textBaseline】 : 文字基线   【TextBaseline】\n"
          "【verticalDirection】 : 竖直方向   【VerticalDirection】\n"
          "【mainAxisSize】 : 主轴尺寸   【MainAxisSize】",
      "code": """class CustomRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        color: Color(0x4484FFFF),
        child: Row(
          children: <Widget>[
            Padding(
              child: Icon(
                Icons.add_location,
                size: 30,
                color: Colors.pink,
              ),
              padding: EdgeInsets.only(left: 25, right: 20),
            ),
            Expanded(
              child: Text(
                "附近",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              child: Icon(Icons.keyboard_arrow_right, color: Colors.black38),
              padding: EdgeInsets.only(right: 25),
            ),
          ],
        ));
  }
}"""
    },
  ],
  "Column": [
    {
      "widgetId": 96,
      "name": 'Column基本使用',
      "priority": 1,
      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
          "【mainAxisAlignment】 : 主轴对齐   【MainAxisAlignment】\n"
          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】\n"
          "【textBaseline】 : 文字基线   【TextBaseline】\n"
          "【verticalDirection】 : 竖直方向   【VerticalDirection】\n"
          "【mainAxisSize】 : 主轴尺寸   【MainAxisSize】",
      "code": """class CustomColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTitle(),
        _buildContent(context),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
        height: 70,
        color: Color(0x4484FFFF),
        child: Row(
          children: <Widget>[
            Padding(
              child: Icon(
                Icons.add_location,
                size: 30,
                color: Colors.pink,
              ),
              padding: EdgeInsets.only(left: 25, right: 20),
            ),
            Expanded(
              child: Text(
                "附近",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              child: Icon(Icons.keyboard_arrow_right, color: Colors.black38),
              padding: EdgeInsets.only(right: 25),
            ),
          ],
        ));
  }

  Widget _buildContent(ctx) => Container(
        width: MediaQuery.of(ctx).size.width,
        color: Colors.purple,
        height: 100,
        child: Icon(
          Icons.android,
          size: 50,
          color: Colors.white,
        ),
      );
}"""
    },
  ],
  "Stack": [
    {
      "widgetId": 97,
      "name": 'Stack基本使用',
      "priority": 1,
      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
          "【textDirection】 : 孩子排布方向   【MainAxisAlignment】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】\n"
          "【overflow】 : 溢出模式   【Overflow】\n"
          "【fit】 : 适应模式   【StackFit】",
      "code": """class CustomStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    var redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    var greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    var cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
      width: 200,
      height: 120,
      color: Colors.grey.withAlpha(33),
      child: Stack(
        textDirection: TextDirection.rtl,
        fit: StackFit.loose,
        alignment: Alignment.topRight,
        overflow: Overflow.clip,
        children: <Widget>[yellowBox, redBox, greenBox, cyanBox],
      ),
    );
  }
}"""
    },
    {
      "widgetId": 97,
      "name": 'Stack和Positioned结合使用',
      "priority": 2,
      "subtitle": "Positioned组件只能用与Stack中，可以指定左上右下的距离对某个组件进行位置精确安放。",
      "code": """class PositionedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    var redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    var greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    var cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
        width: 200,
        height: 120,
        color: Colors.grey.withAlpha(33),
        child: Stack(
          children: <Widget>[yellowBox, redBox, greenBox,
            Positioned(
              child: cyanBox,
              bottom: 10,
              right: 10,
            )
          ],
        ));
  }
"""
    },
  ],
  "Wrap": [
    {
      "widgetId": 98,
      "name": 'Wrap的基础用法',
      "priority": 1,
      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
          "【spacing】 : 主轴条目间距   【double】\n"
          "【runSpacing】 : 交叉轴条目间距   【double】\n"
          "【direction】 : 主轴对齐   【Axis】",
      "code": """class DirectionWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: Axis.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());;
  }
  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    direction: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}"""
    },
    {
      "widgetId": 98,
      "name": 'Wrap的alignment属性',
      "priority": 2,
      "subtitle": "【alignment】 : 主轴对齐   【WrapAlignment】",
      "code": """class CustomWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: WrapAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());;
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
        alignment: mode,
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          yellowBox, redBox,
          greenBox, cyanBox,
          blackBox, purpleBox,
          orangeBox,
        ],
    );
}"""
    },

    {
      "widgetId": 98,
      "name": 'Wrap的crossAxisAlignment属性',
      "priority": 3,
      "subtitle": "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】",
      "code": """class CrossAxisAlignmentWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: WrapCrossAlignment.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    crossAxisAlignment: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox,
      greenBox, cyanBox,
      blackBox, purpleBox,
      orangeBox,
    ],
  );
}"""
    },
    {
      "widgetId": 98,
      "name": 'Wrap的textDirection属性',
      "priority": 4,
      "subtitle": "【textDirection】 : 文字方向   【TextDirection】",
      "code": """class TextDirectionWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: TextDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    textDirection: mode,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}"""
    },
    {
      "widgetId": 98,
      "name": 'Wrap的textDirection属性',
      "priority": 5,
      "subtitle": "【verticalDirection】 : 竖直方向  【VerticalDirection】",
      "code": """class VerticalDirectionWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: VerticalDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 100,
              color: Colors.grey.withAlpha(88),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  final yellowBox = Container(
    color: Colors.yellow,
    height: 30,
    width: 50,
  );

  final redBox = Container(
    color: Colors.red,
    height: 40,
    width: 40,
  );
  final greenBox = Container(
    color: Colors.green,
    height: 40,
    width: 20,
  );
  final blackBox = Container(
    color: Colors.black,
    height: 10,
    width: 10,
  );
  final purpleBox = Container(
    color: Colors.purple,
    height: 20,
    width: 20,
  );
  final orangeBox = Container(
    color: Colors.orange,
    height: 80,
    width: 20,
  );
  final cyanBox = Container(
    color: Colors.cyanAccent,
    height: 10,
    width: 20,
  );

  _buildItem(mode) => Wrap(
    verticalDirection: mode,
    direction: Axis.vertical,
    runSpacing: 10,
    spacing: 10,
    children: <Widget>[
      yellowBox, redBox, greenBox, cyanBox,
      blackBox, purpleBox, orangeBox,
    ],
  );
}"""
    },
//    {"code": """"""},
  ],
  "Flow": [
    {
      "widgetId": 99,
      "name": 'Flow圆形排布',
      "priority": 1,
      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
          "【delegate】 : 代理   【FlowDelegate】",
      "code": """class CircleFlow extends StatelessWidget {
  final data = List.generate(
      16,
      (index) => index.isEven
          ? "assets/images/icon_head.png"
          : "assets/images/wy_300x200.jpg");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      alignment: Alignment.center,
      child: Flow(
        delegate: _CircleFlowDelegate(),
        children: data
            .map((e) => CircleAvatar(backgroundImage: AssetImage(e)))
            .toList(),
      ),
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    print(context.getChildSize(0));
    var count = context.childCount;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;

      var offsetX = (radius - cSizeX) * cos(i * perRad) + radius;
      var offsetY = (radius - cSizeY) * sin(i * perRad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}"""
    },
    {
      "widgetId": 99,
      "name": 'Flow圆形与动画结合',
      "priority": 2,
      "subtitle": "通过动画来更改周围组件的位置实现效果",
      "code": """class BurstFlow extends StatefulWidget {
  static final data = List.generate(
      16,
      (index) => index.isEven
          ? "assets/images/icon_head.png"
          : "assets/images/wy_300x200.jpg");
  static final show = Container(
      width: 300,
      height: 300,
      alignment: Alignment.center,
      child: BurstFlow(
          children: data
              .map((e) => CircleAvatar(backgroundImage: AssetImage(e)))
              .toList(),
          menu: CircleAvatar(
            backgroundImage: AssetImage('assets/images/icon_head.png'),
          )));

  final List<Widget> children;
  final Widget menu;

  BurstFlow({@required this.children, @required this.menu});

  @override
  _BurstFlowState createState() => _BurstFlowState();
}

class _BurstFlowState extends State<BurstFlow>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _rad = 0.0;
  bool _closed = true;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this)
      ..addListener(() => setState(
          () => _rad = (_closed ? (_controller.value) : 1 - _controller.value)))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _closed = !_closed;
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _BurstFlowDelegate(_rad),
      children: [
        ...widget.children,
        InkWell(
            onTap: () {
              _controller.reset();
              _controller.forward();
            },
            child: widget.menu)
      ],
    );
  }
}

class _BurstFlowDelegate extends FlowDelegate {
  final double rad;

  _BurstFlowDelegate(this.rad);

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    var count = context.childCount - 1;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      print(i);
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;
      var offsetX = rad * (radius - cSizeX) * cos(i * perRad) + radius;
      var offsetY = rad * (radius - cSizeY) * sin(i * perRad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
    context.paintChild(context.childCount - 1,
        transform: Matrix4.translationValues(
            radius - context.getChildSize(context.childCount - 1).width / 2,
            radius - context.getChildSize(context.childCount - 1).height / 2,
            0.0));
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}"""
    },
  ],
  "AnimatedCrossFade": [
    {
      "widgetId": 100,
      "name": 'AnimatedCrossFade基本使用',
      "priority": 1,
      "subtitle": "【firstChild】 : 第一孩子   【Widget】\n"
          "【secondChild】 : 第二孩子   【Widget】\n"
          "【crossFadeState】 : 显示第几个   【CrossFadeState】\n"
          "【duration】 : 时长   【Duration】",
      "code": """class CustomAnimatedCrossFade extends StatefulWidget {
  @override
  _CustomAnimatedCrossFadeState createState() =>
      _CustomAnimatedCrossFadeState();
}

class _CustomAnimatedCrossFadeState extends State<CustomAnimatedCrossFade> {
  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          child: AnimatedCrossFade(
            firstChild: Container(
              alignment: Alignment.center,
              width: 200,
              height: 150,
              color: Colors.orange,
              child: FlutterLogo(colors: Colors.blue, size: 100,),
            ),
            secondChild: Container(
              width: 200,
              height: 150,
              alignment: Alignment.center,
              color: Colors.blue,
              child: FlutterLogo(
                textColor: Colors.white,
                colors: Colors.orange,
                size: 100,
                style: FlutterLogoStyle.stacked,),
            ),
            duration: Duration(milliseconds: 600),

            crossFadeState: _crossFadeState,
          ),
        ),
        _buildSwitch(),
      ],

    );
  }

  Widget _buildSwitch() =>
      Switch(value: isFirst, onChanged: (v) {
        setState(() {
          _crossFadeState =
          v ? CrossFadeState.showFirst : CrossFadeState.showSecond;
        });
      });
}"""
    },
    {
      "widgetId": 100,
      "name": 'AnimatedCrossFade基本使用',
      "priority": 2,
      "subtitle": "【firstCurve】 : 第一曲线   【Curve】\n"
          "【secondCurve】 : 第二曲线   【Curve】\n"
          "【sizeCurve】 : 尺寸变化曲线   【CrossFadeState】",
      "code": """class CurveAnimatedCrossFade extends StatefulWidget {
  @override
  _CurveAnimatedCrossFadeState createState() => _CurveAnimatedCrossFadeState();
}

class _CurveAnimatedCrossFadeState extends State<CurveAnimatedCrossFade> {
  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst=> _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          child: AnimatedCrossFade(
            firstCurve: Curves.easeInCirc,
            secondCurve: Curves.easeInToLinear,
            sizeCurve: Curves.bounceOut,
            firstChild: Container(
              alignment: Alignment.center,
              width: 200,
              height: 80,
              color: Colors.orange  ,
              child: FlutterLogo(colors: Colors.blue,size: 50,),
            ),
            secondChild: Container(
              width: 200,
              height: 150,
              alignment: Alignment.center,
              color: Colors.blue,
              child: FlutterLogo(
                textColor: Colors.white,
                colors: Colors.orange,size: 100,style: FlutterLogoStyle.stacked,),
            ),
            duration: Duration(milliseconds: 1000),
            crossFadeState: _crossFadeState,
          ),
        ),
        _buildSwitch(),
      ],
    );
  }

  Widget _buildSwitch() => Switch(value: isFirst, onChanged: (v){
    setState(() {
      _crossFadeState= v?CrossFadeState.showFirst:CrossFadeState.showSecond;
    });
  });
}"""
    },
  ],
  "RichText": [
    {"widgetId": 101,
      "name": 'RichText基本使用',
      "priority": 1,
      "subtitle":
      "【text】 : 文字   【TextSpan】",
      "code": """class CustomRichText extends StatelessWidget {
  final str =
      "        发光强度简称光强，国际单位是（坎德拉）简写cd。"
      "1cd是指光源在指定方向的单位立体角内发出的光通量。"
      "光源辐射是均匀时，则光强为I=F/Ω，Ω为立体角，单位为球面度（sr）,F为光通量，"
      "单位是流明，对于点光源由I=F/4π 。光亮度是表示发光面明亮程度的，"
      "指发光表面在指定方向的发光强度与垂直且指定方向的发光面的面积之比，"
      "单位是坎德拉/平方米。对于一个漫散射面，尽管各个方向的光强和光通量不同，"
      "但各个方向的亮度都是相等的。电视机的荧光屏就是近似于这样的漫散射面，"
      "所以从各个方向上观看图像，都有相同的亮度感。";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          text: TextSpan(
              children: str
                  .split("")
                  .map((str) => TextSpan(
                      text: str,
                      style: TextStyle(
                          fontSize: 14, color: ColorUtils.randomColor())))
                  .toList())),
    );
  }
}"""},
  ],
  "DataTable": [
    {"widgetId": 102,
      "name": 'DataTable基本使用',
      "priority": 1,
      "subtitle":
      "【columns】 : 列   【List<DataColumn>】\n"
          "【rows】 : 行  【List<DataRow>】",
      "code": """class CustomDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(columns: [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('名称')),
      DataColumn(label: Text('类型')),
      DataColumn(label: Text('子数目')),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('101')),
        DataCell(Text('DataTable')),
        DataCell(Text('StatelessWidget')),
        DataCell(Text('n')),
      ]),
      DataRow(cells: [
        DataCell(Text('1')),
        DataCell(Text('Container')),
        DataCell(Text('StatelessWidget')),
        DataCell(Text('1')),
      ]),
      DataRow(cells: [
        DataCell(Text('98')),
        DataCell(Text('Wrap')),
        DataCell(Text('MultiChildRenderObjectWidget')),
        DataCell(Text('n')),
      ]),
    ]);
  }
}"""},
    {"widgetId": 102,
      "name": 'DataTable的sort',
      "priority": 1,
      "subtitle":
      "【sortColumnIndex】 : 列号   【int】\n"
          "【sortAscending】 : 是否顺序  【bool】",
      "code": """class SortDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        sortColumnIndex: 0, 
        sortAscending: true, 
        columns: [
      DataColumn(
          label: Text('id'),
          numeric: false,
          onSort: (int columnIndex, bool ascending) {
            print('\$columnIndex----\$ascending');
          }),
      DataColumn(label: Text('名称')),
      DataColumn(label: Text('类型')),
      DataColumn(label: Text('子数目')),
    ], rows: [
      DataRow(cells: [
        DataCell(Text('101')),
        DataCell(Text('DataTable')),
        DataCell(Text('StatelessWidget')),
        DataCell(Text('n')),
      ]),
      DataRow(selected: true, cells: [
        DataCell(Text('1')),
        DataCell(Text('Container'), showEditIcon: true,onTap: (){

        }),
        DataCell(Text('StatelessWidget')),
        DataCell(Text('1')),
      ]),
      DataRow(cells: [
        DataCell(Text('98')),
        DataCell(Text('Wrap')),
        DataCell(Text('MultiChildRenderObjectWidget')),
        DataCell(Text('n')),
      ]),
    ]);
  }
}"""},
  ],
  "Draggable": [
    {
      "widgetId": 103,
      "name": 'Draggable基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子   【Widget】\n"
          "【feedback】 : 拖拽时的孩子   【Widget】\n"
          "【axis】 : 拖动的轴   【Axis】",
      "code": """class CustomDraggable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var axis = [null, Axis.vertical, Axis.horizontal];
    return Wrap(
        spacing: 30,
        children: axis
            .map((e) => Draggable(
                  axis: e,
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                  feedback: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                ))
            .toList());
  }
}"""
    },
    {
      "widgetId": 103,
      "name": 'Draggable与DragTarget联用',
      "priority": 2,
      "subtitle": "【data】 : 数据   【T】\n"
          "【onDragStarted】 : 开始拖拽   【Function()】\n"
          "【onDragEnd】 : 结束拖拽   【Function(DraggableDetails)】\n"
          "【onDragCompleted】 : 拖拽完成   【Function()】\n"
          "【onDraggableCanceled】 : 拖拽取消   【Function(Velocity,Offset)】",
      "code": """lass DraggablePage extends StatefulWidget {
  @override
  _DraggablePageState createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  Color _color = Colors.grey;
  String _info = 'DragTarget';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: _buildColors(),
            spacing: 10,
          ),
          SizedBox(height: 20,),
          _buildDragTarget()
        ],
      ),
    );
  }

  List<Widget> _buildColors() {
    var colors = [
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyanAccent
    ];
    return colors
        .map(
          (e) => Draggable<Color>(
              onDragStarted: () => setState(() => _info = '开始拖拽'),
              onDragEnd: (d) => setState(() => _info = '结束拖拽'),
              onDragCompleted: () => _info = '拖拽完成',
              onDraggableCanceled: (v, o) => _info = '拖拽取消',
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  colors.indexOf(e).toString(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(color: e, shape: BoxShape.circle),
              ),
              data: e,
              feedback: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(color: e, shape: BoxShape.circle),
              )),
        )
        .toList();
  }

  Widget _buildDragTarget() {
    return DragTarget<Color>(
        onLeave: (data) => print("onLeave: data = \$data "),
        onAccept: (data) {
          print("onAccept: data = \$data ");
          setState(() {
            _color = data;
          });
        },
        onWillAccept: (data) {
          print("onWillAccept: data = \$data ");
          return data != null;
        },
        builder: (context, candidateData, rejectedData) => Container(
            width: 150.0,
            height: 50.0,
            color: _color,
            child: Center(
              child: Text(
                _info,
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}"""
    },
    {
      "widgetId": 103,
      "name": 'Draggable其他使用',
      "priority": 3,
      "subtitle": "可以根据拖拽来处理一些事件。如删除、查询、弹框等",
      "code": """class DeleteDraggable extends StatefulWidget {
  @override
  _DeleteDraggableState createState() => _DeleteDraggableState();
}

class _DeleteDraggableState extends State<DeleteDraggable> {
  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyanAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: _buildColors(),
            spacing: 10,
          ),
          SizedBox(height: 20,),
          _buildDragTarget()
        ],
      ),
    );
  }

  Widget _buildDragTarget() {
    return DragTarget<int>(
            onAccept: (data) {
              setState(() {
                colors.removeAt(data);
              });
            },
            onWillAccept: (data) => data != null,
            builder: (context, candidateData, rejectedData) => Container(
                width: 50.0,
                height: 50.0,
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Center(
                  child: Icon(Icons.delete_sweep, color: Colors.white),
                )));
  }

  List<Widget> _buildColors() => colors
      .map(
        (e) => Draggable<int>(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                colors.indexOf(e).toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(color: e, shape: BoxShape.circle),
            ),
            data: colors.indexOf(e),
            feedback: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: e.withAlpha(100), shape: BoxShape.circle),
            )),
      )
      .toList();
}"""
    },
  ],
  "DragTarget": [
    {
      "widgetId": 104,
      "name": 'DragTarget基本使用',
      "priority": 1,
      "subtitle": "【builder】 : 组件构造器   【DragTargetBuilder<T>】\n"
          "【onWillAccept】 : 拖入时   【Function(T)】\n"
          "【onAccept】 : 拖拽成功   【Function(T)】\n"
          "【onLeave】 : 拖入再脱出   【Function(T)】",
      "code": """class CustomDragTarget extends StatefulWidget {
  @override
  _CustomDragTargetState createState() => _CustomDragTargetState();
}

class _CustomDragTargetState extends State<CustomDragTarget> {
  Color _color = Colors.grey;
  String _info = 'DragTarget';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: _buildColors(),
            spacing: 10,
          ),
          SizedBox(height: 20,),
          _buildDragTarget()
        ],
      ),
    );
  }

  List<Widget> _buildColors() {
    var colors = [
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyanAccent
    ];
    return colors
        .map(
          (e) => Draggable<Color>(
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              colors.indexOf(e).toString(),
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          ),
          data: e,
          feedback: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          )),
    )
        .toList();
  }

  Widget _buildDragTarget() {
    return DragTarget<Color>(
        onLeave: (data) => setState(() => _info='onLeave'),
        onAccept: (data) => setState(() {
            _info='onAccept';
            _color = data;
          }),
        onWillAccept: (data) {
          setState(() {
            _info='onWillAccept';
          });
          print("onWillAccept: data = \$data ");
          return data != null;
        },
        builder: (context, candidateData, rejectedData) => Container(
            width: 150.0,
            height: 50.0,
            color: _color,
            child: Center(
              child: Text(
                _info,
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}"""
    },
  ],
  "LongPressDraggable": [
    {
      "widgetId": 105,
      "name": 'LongPressDraggable与DragTarget联用',
      "priority": 1,
      "subtitle": "【child】 : 孩子   【Widget】\n"
          "【feedback】 : 拖拽时的孩子   【Widget】\n"
          "【axis】 : 拖动的轴   【Axis】\n"
          "【data】 : 数据   【T】\n"
          "【onDragStarted】 : 开始拖拽   【Function()】\n"
          "【onDragEnd】 : 结束拖拽   【Function(DraggableDetails)】\n"
          "【onDragCompleted】 : 拖拽完成   【Function()】\n"
          "【onDraggableCanceled】 : 拖拽取消   【Function(Velocity,Offset)】",
      "code": """class CustomLongPressDraggable extends StatefulWidget {
  @override
  _CustomLongPressDraggableState createState() => _CustomLongPressDraggableState();
}

class _CustomLongPressDraggableState extends State<CustomLongPressDraggable> {
  Color _color = Colors.grey;
  String _info = 'DragTarget';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            children: _buildColors(),
            spacing: 10,
          ),
          SizedBox(height: 20,),
          _buildDragTarget()
        ],
      ),
    );
  }

  List<Widget> _buildColors() {
    var colors = [
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyanAccent
    ];
    return colors
        .map(
          (e) => LongPressDraggable<Color>(
              onDragStarted: () => setState(() => _info = '开始拖拽'),
              onDragEnd: (d) => setState(() => _info = '结束拖拽'),
              onDragCompleted: () => _info = '拖拽完成',
              onDraggableCanceled: (v, o) => _info = '拖拽取消',
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              colors.indexOf(e).toString(),
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          ),
          data: e,
          feedback: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(color: e, shape: BoxShape.circle),
          )),
    )
        .toList();
  }

  Widget _buildDragTarget() {
    return DragTarget<Color>(
        onAccept: (data) => setState(() {
          _info='onAccept';
          _color = data;
        }),
        builder: (context, candidateData, rejectedData) => Container(
            width: 150.0,
            height: 50.0,
            color: _color,
            child: Center(
              child: Text(
                _info,
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}"""
    },
  ],
  "Expended": [
    {
      "widgetId": 106,
      "name": 'Expanded基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子   【Widget】\n"
          "【flex】 : 剩余空间分配占比   【int】",
      "code": """class CustomExpended extends StatefulWidget {
  @override
  _CustomExpendedState createState() => _CustomExpendedState();
}

class _CustomExpendedState extends State<CustomExpended> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildRow([0, 0, 0]),
          SizedBox(height: 10,),
          buildRow([0, 0, 1]),
          SizedBox(height: 10,),
          buildRow([1, 1, 1]),
          SizedBox(height: 10,),
          buildRow([2, 3, 3]),
        ],
      ),
    );
  }

  Widget buildRow(List<int> num) {
    return Row(
        children: num.map((e) => Expanded(
              flex: e,
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                color: ColorUtils.randomColor(),
                child: Text(
                  'flex=\$e',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )).toList());
  }
}
"""
    },
  ],
  "Spacer": [
    {
      "widgetId": 107,
      "name": 'Spacer基本使用',
      "priority": 1,
      "subtitle": "【flex】 : 剩余空间分配占比   【int】",
      "code": """class CustomSpacer extends StatefulWidget {
  @override
  _CustomSpacerState createState() => _CustomSpacerState();
}

class _CustomSpacerState extends State<CustomSpacer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildRow([1, 1, 1]),
          SizedBox(height: 10,),
          buildRow([1, 2, 1]),
          SizedBox(height: 10,),
          buildRow([2, 2, 1]),
          SizedBox(height: 10,),
          buildRow([3, 7, 3]),
        ],
      ),
    );
  }

  Widget buildRow(List<int> num) {
    return Row(
        children:[
          Spacer(flex: num[0]),
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            color: ColorUtils.randomColor(),
          ),
          Spacer(flex: num[1]),
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            color: ColorUtils.randomColor(),
          ),
          Spacer(flex: num[2]),
        ]
    );
  }
}"""
    },
  ],
  "Positioned": [
    {
      "widgetId": 108,
      "name": 'Positioned基本使用',
      "priority": 1,
      "subtitle": "【child】 : 组件   【Widget】\n"
          "【top】 : 到父顶距离   【double】\n"
          "【right】 : 到父右距离   【double】\n"
          "【left】 : 到父左距离   【double】\n"
          "【bottom】 : 到父底距离   【double】",
      "code": """class CustomPositioned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    var redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    var greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    var cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
        width: 200,
        height: 120,
        color: Colors.grey.withAlpha(33),
        child: Stack(
          children: <Widget>[
            yellowBox,
            redBox,
            Positioned(top: 20, left: 20, child: greenBox),
            Positioned(
              child: cyanBox,
              bottom: 10,
              right: 10,
            )
          ],
        ));
  }
}"""
    },
  ],
  "Flexible": [
    {
      "widgetId": 109,
      "name": 'Flexible基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子   【Widget】\n"
          "【fit】 : 适应模式*2   【FlexFit】\n"
          "【flex】 : 剩余空间分配占比   【int】",
      "code": """class CustomFlexible extends StatefulWidget {
  @override
  _CustomFlexibleState createState() => _CustomFlexibleState();
}

class _CustomFlexibleState extends State<CustomFlexible> {
  double _width = 300.0;
  bool _loose = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          color: Colors.grey.withAlpha(33),
          width: _width,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.red,
                  child: Text(
                    'flex=2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.blue,
                  child: Text(
                    'flex=3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                fit: _loose?FlexFit.loose:FlexFit.tight,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 60),
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.green,
                  child: Text(
                    'flex=4 \nfit:\${_loose?'loose':'tight'}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
      _buildOp()
    ]);
  }

  Widget _buildOp() {
    return Row(
      children: <Widget>[
        Switch(
            value: _loose,
            onChanged: (v) => setState(() => _loose = v)),
        Expanded(
          child: Slider(
              min: 100,
              max: 350,
              value: _width,
              onChanged: (v) => setState(() => _width = v)),
        ),
      ],
    );
  }
}"""
    },
  ],
  "Table": [
    {
      "widgetId": 110,
      "name": 'Table基本使用',
      "priority": 1,
      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
          "【columnWidths】 : 列宽   【Map<int, TableColumnWidth>】\n"
          "【defaultColumnWidth】 : 默认列宽  【TableColumnWidth】\n"
          "【border】 : 边线   【TableBorder】\n"
          "【textDirection】 : 文字方向   【TextDirection】\n"
          "【defaultVerticalAlignment】 : 单元格竖直方向对齐模式   【TableCellVerticalAlignment】",
      "code": """class CustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = _ItemBean("单位称", "量纲", "单位", "单位名称", "单位符号");
    var m = _ItemBean("长度", "L", "1m", "米", "m");
    var kg = _ItemBean("质量", "M", "1Kg", "千克", "Kg");
    var s = _ItemBean("时间", "T", "1s", "秒", "s");
    var a = _ItemBean("安培", "Ι", "1A", "安培", "A");
    var k = _ItemBean("热力学温度", "θ", "1K", "开尔文", "K");
    var mol = _ItemBean("物质的量", "N", "1mol", "摩尔", "mol");
    var cd = _ItemBean("发光强度", "J", "1cd", "坎德拉", "cd");

    var data = <_ItemBean>[title, m, kg, s, a, k, mol, cd];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(80.0),
          1: FixedColumnWidth(80.0),
          2: FixedColumnWidth(80.0),
          3: FixedColumnWidth(80.0),
          4: FixedColumnWidth(80.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
            color: Colors.orangeAccent, width: 1.0, style: BorderStyle.solid),
        children: data
            .map((item) => TableRow(children: <Widget>[
                  Center(
                      child: Text(
                    item.name,
                    style: TextStyle(color: Colors.blue),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(item.symbol)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(item.unitSymbol)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(item.unitName)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(item.unit)),
                  ),
                ]))
            .toList(),
      ),
    );
  }
}

class _ItemBean {
  String name;
  String symbol;
  String unit;
  String unitName;
  String unitSymbol;

  _ItemBean(this.name, this.symbol, this.unit, this.unitName, this.unitSymbol);
}"""
    },
  ],
  "AlignTransition": [
    {
      "widgetId": 111,
      "name": 'AlignTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【alignment】 : 对齐动画   【Animation<AlignmentGeometry>】",
      "code": """class CustomAlignTransition extends StatefulWidget {
  @override
  _CustomAlignTransitionState createState() => _CustomAlignTransitionState();
}

class _CustomAlignTransitionState extends State<CustomAlignTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withAlpha(33),
          height: 100,
          child: AlignTransition(
            alignment: AlignmentTween(
                    begin: Alignment.topLeft, end: Alignment.bottomRight)
                .animate(_ctrl),
            child: Container(
                child: Icon(Icons.android, color: Colors.green, size: 60)),
          ),
        ));
  }
}"""
    },
  ],
  "SlideTransition": [
    {
      "widgetId": 112,
      "name": 'SlideTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【textDirection】 : x轴方向  【TextDirection】\n"
          "【position】 : 动画   【Animation<Offset>】",
      "code": """class CustomSlideTransition extends StatefulWidget {
  @override
  _CustomSlideTransitionState createState() => _CustomSlideTransitionState();
}

class _CustomSlideTransitionState extends State<CustomSlideTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withAlpha(33),
          height: 100,
          child: SlideTransition(
            textDirection: TextDirection.ltr,
            position: Tween<Offset>(
              begin: Offset.zero,
              end: Offset(0.2, 0.2),
            ).animate(_ctrl),
            child: Container(
                child: Icon(Icons.android, color: Colors.green, size: 60)),
          ),
        ));
  }
}"""
    },
  ],
  "DecoratedBoxTransition": [
    {
      "widgetId": 113,
      "name": 'DecoratedBoxTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【position】 : 前/背景色  【DecorationPosition】\n"
          "【decoration】 : 动画   【Animation<Decoration>】",
      "code": """class CustomDecoratedBoxTransition extends StatefulWidget {
  @override
  _CustomDecoratedBoxTransitionState createState() =>
      _CustomDecoratedBoxTransitionState();
}

class _CustomDecoratedBoxTransitionState
    extends State<CustomDecoratedBoxTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          width: 200,
          height: 100,
          child: DecoratedBoxTransition(
            position: DecorationPosition.background,
            decoration: DecorationTween(
                begin: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.purple,
                          blurRadius: 3,
                          spreadRadius: 1)
                    ]),
                end: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          color: Colors.blue,
                          blurRadius: 1,
                          spreadRadius: 0)
                    ])).animate(_ctrl),
            child: Container(
                child: Icon(Icons.android, color: Colors.white, size: 60)),
          ),
        ));
  }
}"""
    },
  ],
  "DefaultTextStyleTransition": [
    {
      "widgetId": 114,
      "name": 'DefaultTextStyleTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【textAlign】 : 文字对齐方式  【TextAlign】\n"
          "【softWrap】 : 是否包裹  【bool】\n"
          "【maxLines】 : 最大行数  【int】\n"
          "【overflow】 : 溢出模式  【TextOverflow】\n"
          "【style】 : 动画   【Animation<TextStyle>】",
      "code": """class CustomDefaultTextStyleTransition extends StatefulWidget {
  @override
  _CustomDefaultTextStyleTransitionState createState() =>
      _CustomDefaultTextStyleTransitionState();
}

class _CustomDefaultTextStyleTransitionState
    extends State<CustomDefaultTextStyleTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: 300,
          height: 100,
          child: DefaultTextStyleTransition(
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleTween(
                begin: TextStyle(color: Colors.blue, fontSize: 50, shadows: [
                  Shadow(
                      offset: Offset(1, 1), color: Colors.black, blurRadius: 3)
                ]),
                end: TextStyle(color: Colors.white, fontSize: 20, shadows: [
                  Shadow(
                      offset: Offset(1, 1), color: Colors.purple, blurRadius: 3)
                ])).animate(_ctrl),
            child: Text('张风捷特烈'),
          ),
        ));
  }
}"""
    },
  ],
  "RelativePositionedTransition": [
    {
      "widgetId": 115,
      "name": 'RelativePositionedTransition基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【size】 : 左和上的偏移量   【Size】\n"
          "【rect】 : 动画   【Animation<Rect>】\n"
          "    PositionedTransition组件只能在Stack内起作用",
      "code":
          """class CustomRelativePositionedTransition extends StatefulWidget {
  @override
  _CustomRelativePositionedTransitionState createState() =>
      _CustomRelativePositionedTransitionState();
}

class _CustomRelativePositionedTransitionState
    extends State<CustomRelativePositionedTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: <Widget>[
              RelativePositionedTransition(
                size: Size(200, 100),
                rect: RectTween(
                  begin: Rect.fromLTRB(0, 0, 50, 50),
                  end: Rect.fromLTRB(0, 0, 50, 50).translate(100, 50),
                ).animate(_ctrl),
                child: Icon(
                  Icons.android,
                  color: Colors.green,
                  size: 50,
                ),
              )
            ],
          ),
        ));
  }
}"""
    },
  ],
  "AnimatedSwitcher": [
    {
      "widgetId": 116,
      "name": 'AnimatedSwitcher基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长  【Duration】\n"
          "【switchOutCurve】 : 切出曲线  【Curves】\n"
          "【switchInCurve】 : 切入曲线  【Curves】\n"
          "【switchInCurve】 : 切入曲线  【Curves】\n"
          "【transitionBuilder】 : 动画构造器  【Widget Function(Widget, Animation<double>)】",
      "code": """class CustomAnimatedSwitcher extends StatefulWidget {
  @override
  _CustomAnimatedSwitcherState createState() => _CustomAnimatedSwitcherState();
}

class _CustomAnimatedSwitcherState extends State<CustomAnimatedSwitcher> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          _buildMinusBtn(),
          SizedBox(width:80,child: _buildAnimatedSwitcher(context)),
          _buildAddBtn()
        ],
      ),
    );
  }

  Widget _buildAnimatedSwitcher(BuildContext context) =>
      AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(
                  child: RotationTransition(turns: animation, child: child),
                  scale: animation),
          child: Text(
            '\$_count',
            key: ValueKey<int>(_count),
            style: Theme.of(context).textTheme.display3,
          ),
        );

  Widget _buildMinusBtn() {
   return MaterialButton(
        padding: EdgeInsets.all(0),
        textColor: Color(0xffFfffff),
        elevation: 3,
        color: Colors.red,
        highlightColor: Color(0xffF88B0A),
        splashColor: Colors.red,
        child: Icon(
          Icons.remove,
          color: Colors.white,
        ),
       shape: CircleBorder(
         side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
       ),
        onPressed: () => setState(() => _count -= 1));
  }

  Widget _buildAddBtn() => MaterialButton(
        padding: EdgeInsets.all(0),
        textColor: Color(0xffFfffff),
        elevation: 3,
        color: Colors.blue,
        highlightColor: Color(0xffF88B0A),
        splashColor: Colors.red,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: CircleBorder(
          side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
        ),
        onPressed: () => setState(() => _count += 1));
}"""
    },
  ],
  "AnimatedList": [
    {
      "widgetId": 117,
      "name": 'AnimatedList基本使用',
      "priority": 1,
      "subtitle": "【itemBuilder】 : 组件构造器   【AnimatedListItemBuilder】\n"
          "【initialItemCount】 : 子组件数量   【int】\n"
          "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【controller】 : 滑动控制器   【ScrollController】\n"
          "【reverse】 : 数据是否反向   【bool】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】",
      "code": """class CustomAnimatedList extends StatefulWidget {
  @override
  _CustomAnimatedListState createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2, 3],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 4;
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
  }

  void _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withAlpha(33),
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          children: <Widget>[
            _buildBtn(),
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: 300,
              child: AnimatedList(
                padding: EdgeInsets.all(10.0),
                key: _listKey,
                initialItemCount: _list.length,
                itemBuilder: _buildItem,
              ),
            )
          ],
        ));
  }

  Widget _buildBtn() => Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Colors.blue,
            ),
            onPressed: _insert,
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.blue),
            onPressed: _remove,
          ),
        ],
      );
}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);
  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);
  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: Card(
        child: Container(
          color: Colors.primaries[item % Colors.primaries.length],
          child: CheckboxListTile(
            dense: true,
              title: Text(
                'Item \$item',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              value: selected,
              onChanged: (v) => onTap()),
        ),
      ),
    );
  }
}"""
    },
  ],
  "AnimatedOpacity": [
    {
      "widgetId": 118,
      "name": 'AnimatedOpacity基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【opacity】 : 透明度   【double】",
      "code": """class CustomAnimatedOpacity extends StatefulWidget {
  @override
  _CustomAnimatedOpacityState createState() => _CustomAnimatedOpacityState();
}

class _CustomAnimatedOpacityState extends State<CustomAnimatedOpacity> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
            value: _opacity == 0,
            onChanged: (v) {
              setState(() {
                _opacity = v ? 0 : 1.0;
              });
            }),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            opacity: _opacity,
            onEnd: () => print('End'),
            child: Icon(Icons.android, color: Colors.green, size: 60),
          ),
        ),
      ],
    );
  }
}"""
    },
  ],
  "AnimatedPadding": [
    {
      "widgetId": 119,
      "name": 'AnimatedPadding基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】",
      "code": """class CustomAnimatedPadding extends StatefulWidget {
  @override
  _CustomAnimatedPaddingState createState() => _CustomAnimatedPaddingState();
}

class _CustomAnimatedPaddingState extends State<CustomAnimatedPadding> {
  final EdgeInsets startPadding = EdgeInsets.all(10);
  final EdgeInsets endPadding = EdgeInsets.all(30);

  EdgeInsets _padding;

  @override
  void initState() {
    _padding = startPadding;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
            value: _padding == endPadding,
            onChanged: (v) {
              setState(() {
                _padding = v ? endPadding : startPadding;
              });
            }),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          child: AnimatedPadding(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            padding: _padding,
            onEnd: () => print('End'),
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}"""
    },
  ],
  "AnimatedAlign": [
    {
      "widgetId": 120,
      "name": 'AnimatedAlign基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】",
      "code": """class CustomAnimatedAlign extends StatefulWidget {
  @override
  _CustomAnimatedAlignState createState() => _CustomAnimatedAlignState();
}

class _CustomAnimatedAlignState extends State<CustomAnimatedAlign> {
  final Alignment start = Alignment(0, 0);
  final Alignment end = Alignment.bottomRight;

  Alignment _alignment;

  @override
  void initState() {
    _alignment = start;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          child: AnimatedAlign(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: _alignment,
            onEnd: () => print('End'),
            child: Container(
              height: 40,
              width: 80,
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
          value: _alignment == end,
          onChanged: (v) {
            setState(() {
              _alignment = v ? end : start;
            });
          });
}"""
    },
  ],
  "AnimatedPositioned": [
    {
      "widgetId": 121,
      "name": 'AnimatedPositioned基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【top】 : 到父顶距离   【double】\n"
          "【right】 : 到父右距离   【double】\n"
          "【left】 : 到父左距离   【double】\n"
          "【bottom】 : 到父底距离   【double】",
      "code": """class CustomAnimatedPositioned extends StatefulWidget {
  @override
  _CustomAnimatedPositionedState createState() =>
      _CustomAnimatedPositionedState();
}

class _CustomAnimatedPositionedState extends State<CustomAnimatedPositioned> {
  final startTop = 0.0;
  final endTop = 30.0;

  var _top = 0.0;

  @override
  void initState() {
    _top = startTop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: _buildChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildren() => <Widget>[
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          top: _top,
          left: _top * 4,
          child: Icon(
            Icons.android,
            color: Colors.green,
            size: 50,
          ),
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          top: 50 - _top,
          left: 150 - _top * 4,
          child: Icon(
            Icons.android,
            color: Colors.red,
            size: 50,
          ),
        )
      ];

  Widget _buildSwitch() => Switch(
      value: _top == endTop,
      onChanged: (v) {
        setState(() {
          _top = v ? endTop : startTop;
        });
      });
}"""
    },
  ],
  "AnimatedPositionedDirectional": [
    {
      "widgetId": 122,
      "name": 'AnimatedPositionedDirectional基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【top】 : 到父顶距离   【double】\n"
          "【end】 : 到父右距离   【double】\n"
          "【start】 : 到父左距离   【double】\n"
          "【bottom】 : 到父底距离   【double】",
      "code":
          """class CustomAnimatedPositionedDirectional extends StatefulWidget {
  @override
  _CustomAnimatedPositionedDirectionalState createState() =>
      _CustomAnimatedPositionedDirectionalState();
}

class _CustomAnimatedPositionedDirectionalState
    extends State<CustomAnimatedPositionedDirectional> {
  final startTop = 0.0;
  final endTop = 30.0;

  var _top = 0.0;

  @override
  void initState() {
    _top = startTop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: _buildChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildren() => <Widget>[
        AnimatedPositionedDirectional(
          duration: Duration(seconds: 1),
          top: _top,
          start: _top * 4,
          child: Icon(
            Icons.android,
            color: Colors.green,
            size: 50,
          ),
        ),
        AnimatedPositionedDirectional(
          duration: Duration(seconds: 1),
          top: 50 - _top,
          start: 150 - _top * 4,
          child: Icon(
            Icons.android,
            color: Colors.red,
            size: 50,
          ),
        )
      ];

  Widget _buildSwitch() => Switch(
      value: _top == endTop,
      onChanged: (v) {
        setState(() {
          _top = v ? endTop : startTop;
        });
      });
}"""
    },
  ],
  "AnimatedContainer": [
    {
      "widgetId": 123,
      "name": 'AnimatedContainer基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【color】 : 颜色   【Color】\n"
          "【width】 : 宽   【double】\n"
          "【height】 : 高   【double】\n"
          "【alignment】 : 对齐   【AlignmentGeometry】\n"
          "【decoration】 : 装饰   【Decoration】\n"
          "【constraints】 : 约束   【BoxConstraints】\n"
          "【transform】 : 变化   【Matrix4】\n"
          "【margin】 : 外边距   【EdgeInsetsGeometry】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】",
      "code": """class CustomAnimatedContainer extends StatefulWidget {
  @override
  _CustomAnimatedContainerState createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  final Decoration startDecoration = BoxDecoration(
      color: Colors.blue,
      image: DecorationImage(
          image: AssetImage('assets/images/wy_200x300.jpg'), fit: BoxFit.cover),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  final Decoration endDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/wy_200x300.jpg'), fit: BoxFit.cover),
      color: Colors.orange,
      borderRadius: BorderRadius.all(Radius.circular(50)));

  final Alignment startAlignment = Alignment(0, 0);
  final Alignment endAlignment = Alignment.topLeft + Alignment(0.2, 0.2);

  final startHeight = 100.0;
  final endHeight = 50.0;

  Decoration _decoration;
  double _height;
  Alignment _alignment;

  @override
  void initState() {
    _decoration = startDecoration;
    _height = startHeight;
    _alignment=startAlignment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          alignment: _alignment,
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 120,
          child: UnconstrainedBox(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              decoration: _decoration,
              onEnd: () => print('End'),
              height: _height,
              width: _height,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
          value: _height == endHeight,
          onChanged: (v) {
            setState(() {
              _height = v ? endHeight : startHeight;
              _decoration = v ? endDecoration : startDecoration;
              _alignment = v ? endAlignment : startAlignment;
            });
          });
}"""
    },
  ],
  "AnimatedDefaultTextStyle": [
    {
      "widgetId": 124,
      "name": 'AnimatedDefaultTextStyle基本使用',
      "priority": 1,
      "subtitle": "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【onEnd】 : 动画结束回调   【Function()】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【textAlign】 : 文字对齐方式  【TextAlign】\n"
          "【softWrap】 : 是否包裹  【bool】\n"
          "【maxLines】 : 最大行数  【int】\n"
          "【overflow】 : 溢出模式  【TextOverflow】\n"
          "【style】 : 文字样式   【TextStyle】",
      "code": """class CustomAnimatedDefaultTextStyle extends StatefulWidget {
  @override
  _CustomAnimatedDefaultTextStyleState createState() =>
      _CustomAnimatedDefaultTextStyleState();
}

class _CustomAnimatedDefaultTextStyleState
    extends State<CustomAnimatedDefaultTextStyle> {
  final TextStyle start = TextStyle(color: Colors.blue, fontSize: 50, shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 3)
  ]);
  final TextStyle end = TextStyle(color: Colors.white, fontSize: 20, shadows: [
    Shadow(offset: Offset(1, 1), color: Colors.purple, blurRadius: 3)
  ]);

  TextStyle _style;

  @override
  void initState() {
    _style = start;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          alignment: Alignment.center,
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: AnimatedDefaultTextStyle(
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            style: _style,
            onEnd: () => print('End'),
            child: Text(
              '张风捷特烈',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
      value: _style == end,
      onChanged: (v) {
        setState(() {
          _style = v ? end : start;
        });
      });
}"""
    },
  ],
  "AnimatedIcon": [
    {
      "widgetId": 125,
      "name": 'AnimatedIcon基本使用',
      "priority": 1,
      "subtitle": "【icon】 : 动画图标数据   【AnimatedIcons】\n"
          "【size】 : 大小  【double】\n"
          "【color】 : 颜色  【Color】\n"
          "【progress】 : 动画   【Animation<double>】",
      "code": """class CustomAnimatedIcon extends StatefulWidget {
  @override
  _CustomAnimatedIconState createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _ctrl.reset();
          _ctrl.forward();
        });
      },
      child: Wrap(
        runSpacing: 30,
        children: _buildChildren(),
      ),
    );
  }

  final data = {
    Colors.orange: AnimatedIcons.menu_arrow,
    Colors.blue: AnimatedIcons.ellipsis_search,
    Colors.red: AnimatedIcons.close_menu,
    Colors.green: AnimatedIcons.arrow_menu,
    Colors.cyanAccent: AnimatedIcons.play_pause,
    Colors.purple: AnimatedIcons.pause_play,
  };

  List<Widget> _buildChildren() => data.keys
      .map((e) => AnimatedIcon(
            size: 50,
            color: e,
            icon: data[e],
            progress: _ctrl,
          ))
      .toList();
}"""
    },
  ],
  "Dialog": [
    {
      "widgetId": 126,
      "name": 'Dialog基本使用',
      "priority": 1,
      "subtitle": "【child】 : 动画图标数据   【Widget】\n"
          "【elevation】 : 影深  【double】\n"
          "【backgroundColor】 : 背景色  【Color】\n"
          "【shape】 : 形状   【ShapeBorder】",
      "code": """class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildDialog(),
      ],
    );
  }

  Widget _buildDialog() => Dialog(
      backgroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
      padding: const EdgeInsets.all(15.0),
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
      padding: const EdgeInsets.only(bottom: 15.0, top: 10,left: 10,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xff73D1EE)),
            child: Text('Yes',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          InkWell(
            onTap: ()=>Navigator.of(context).pop(),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 100,
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
}"""
    },
  ],
  "AlertDialog": [
    {
      "widgetId": 127,
      "name": 'AlertDialog基本使用',
      "priority": 1,
      "subtitle": "【title】 : 顶部组件   【Widget】\n"
          "【content】 : 内容组件  【Widget】\n"
          "【titleTextStyle】 : 顶部文字样式  【TextStyle】\n"
          "【contentTextStyle】 : 内容文字样式  【TextStyle】\n"
          "【titlePadding】 : 顶部内边距  【EdgeInsetsGeometry】\n"
          "【contentPadding】 : 内容内边距  【EdgeInsetsGeometry】\n"
          "【actions】 : 右下角组件列表  【List<Widget>】\n"
          "【backgroundColor】 : 右下角组件列表  【背景色】\n"
          "【elevation】 : 右下角组件列表  【背景色】\n"
          "【shape】 : 影深   【double】",
      "code": """class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildAlertDialog(),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.blue,
    onPressed: () {
      showDialog(context: context, builder: (ctx) => _buildAlertDialog());
    },
    child: Text(
      'Just Show It !',
      style: TextStyle(color: Colors.white),
    ),

  );
  Widget _buildAlertDialog() {
    return AlertDialog(
    title: _buildTitle(),
    titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
    titlePadding: EdgeInsets.only(
      top: 5,
      left: 20,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 5),
    backgroundColor: Colors.white,
    content: _buildContent(),
    actions: <Widget>[
      Icon(Icons.android, color: Colors.blue,),
      Icon(Icons.add, color: Colors.blue,),
      Icon(Icons.g_translate, color: Colors.blue,),
      Icon(Icons.games, color: Colors.blue,),
    ],
    elevation: 4,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
  }

  Widget _buildTitle() {
    return Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/icon_head.png",
          width: 30,
          height: 30,
        ),
        SizedBox(width: 10,),
        Expanded(
            child: Text(
          "关于",
          style: TextStyle(fontSize: 18),
        )),
        CloseButton()
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '      FlutterUnit是【张风捷特烈】的开源项目，'
            '收录Flutter的200+组件，并附加详细介绍以及操作交互，'
            '希望帮助广大编程爱好者入门Flutter。'
            '更多知识可以关注掘金账号、公众号【编程之王】。',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}"""
    },
  ],
  "SimpleDialog": [
    {
      "widgetId": 128,
      "name": 'SimpleDialog基本使用',
      "priority": 1,
      "subtitle": "【title】 : 顶部组件   【Widget】\n"
          "【children】 : 子组件列表  【List<Widget>】\n"
          "【titlePadding】 : 顶部内边距  【EdgeInsetsGeometry】\n"
          "【contentPadding】 : 内容内边距  【EdgeInsetsGeometry】\n"
          "【backgroundColor】 : 右下角组件列表  【背景色】\n"
          "【elevation】 : 右下角组件列表  【背景色】\n"
          "【shape】 : 影深   【double】",
      "code": """class CustomSimpleDialog extends StatelessWidget {
  final info = [
    '性别:    男     未婚',
    '微信:    zdl1994328',
    "掘金:    张风捷特烈",
    "github:    toly1994328",
    "邮箱:    1981462008@qq.com",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildSimpleDialog(context),
        Positioned(
            top: 70,
            right: 30,
            child: _buildRaisedButton(context)),

      ],
    );
  }
  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.blue,
    onPressed: () {
      showDialog(context: context, builder: (ctx) => _buildSimpleDialog(ctx));
    },
    child: Text(
      'Just Show It',
      style: TextStyle(color: Colors.white),
    ),
  );

  SimpleDialog _buildSimpleDialog(BuildContext context) {
    return SimpleDialog(
    title: _buildTitle(),
    titlePadding: EdgeInsets.only(
      top: 5,
      left: 20,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 5),
    children: _buildChild(context),
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
  }

  List<Column> _buildChild(BuildContext context) {
    return info
        .map((str) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () => print(str),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      str,
                      style: TextStyle(color: Color(0xff999999), fontSize: 16),
                    ),
                  ),
                ),
                Divider(
                  indent: 20,
                  height: 12,
                  color: info.indexOf(str) == info.length - 1
                      ? Colors.transparent
                      : Theme.of(context).dividerColor,
                )
              ],
            ))
        .toList();
  }

  Widget _buildTitle() {
    return Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/icon_head.png",
          width: 30,
          height: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
          "张风捷特烈",
          style: TextStyle(fontSize: 18),
        )),
        CloseButton()
      ],
    );
  }
}"""
    },
  ],
  "CupertinoAlertDialog": [
    {
      "widgetId": 129,
      "name": 'CupertinoAlertDialog基本使用',
      "priority": 1,
      "subtitle": "【title】 : 顶部组件   【Widget】\n"
          "【content】 : 内容组件  【Widget】\n"
          "【actions】 : 顶部文字样式  【List<Widget>】",
      "code": """class CustomCupertinoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildCupertinoAlertDialog(context),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) => _buildCupertinoAlertDialog(context));
        },
        child: Text(
          'Just Show It !',
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget _buildCupertinoAlertDialog(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CupertinoAlertDialog(
          title: _buildTitle(context),
          content: _buildContent(),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Yes, Delete"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoButton(
              child: Text("Cancle"),
              onPressed: () => Navigator.pop(context),
            ),
          ]),
    );
  }

  Widget _buildTitle(context) {
    return Row(
        //标题
        children: <Widget>[
          Icon(
            CupertinoIcons.delete_solid,
            color: Colors.red,
          ),
          Expanded(
              child: Text(
            'Delete File',
            style: TextStyle(color: Colors.red, fontSize: 20),
          )),
          InkWell(
            child: Icon(CupertinoIcons.clear_thick),
            onTap: () => Navigator.pop(context),
          )
        ]);
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Text(
            '    Hi toly! If you push the conform buttom ,'
            ' You will lose this file. Are you sure wand to do that?',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}"""
    },
  ],
  "AboutDialog": [
    {
      "widgetId": 130,
      "name": 'AboutDialog基本使用',
      "priority": 1,
      "subtitle": "【applicationIcon】 : 左上图标   【Widget】\n"
          "【applicationVersion】 : 版本号  【String】\n"
          "【applicationName】 : 应用名  【String】\n"
          "【applicationLegalese】 : 应用律术   【String】\n"
          "【children】 : 子组件列表   【List<Widget>】",
      "code": """class CustomAboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildAboutDialog(),
        Positioned(
            top: 50,
            right: 20,
            child: _buildRaisedButton(context)),

      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.blue,
        onPressed: () {
          showDialog(context: context, builder: (ctx) => _buildAboutDialog());
        },
        child: Text(
          'Just Show It',
          style: TextStyle(color: Colors.white),
        ),
      );

  AboutDialog _buildAboutDialog() {
    return AboutDialog(
      applicationIcon: FlutterLogo(),
      applicationVersion: 'v0.0.1',
      applicationName: 'Flutter Unit',
      applicationLegalese: 'Copyright© 2018-2020 张风捷特烈',
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 20),
            width: 80,
            height: 80,
            child: Image.asset('assets/images/icon_head.png')),
        Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              'The King Of Coder.',
              style: TextStyle(color: Colors.white, fontSize: 20, shadows: [
                Shadow(
                    color: Colors.blue, offset: Offset(.5, .5), blurRadius: 3)
              ]),
            ))
      ],
    );
  }
}"""
    },
  ],
  "CupertinoActionSheet": [
    {
      "widgetId": 131,
      "name": 'CupertinoActionSheet基本使用',
      "priority": 1,
      "subtitle": "【title】 : 第一行组件   【Widget】\n"
          "【message】 : 第二行组件  【Widget】\n"
          "【cancelButton】 : 取消按钮处组件  【Widget】\n"
          "【actions】 : 中间组件列表  【List<Widget>】",
      "code": """class CustomCupertinoActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildRaisedButton(context),
        _buildCupertinoActionSheet(context),
      ],
    );
  }

  Widget _buildCupertinoActionSheet(BuildContext context) =>
      Container(
        alignment: Alignment.bottomCenter,
        child: CupertinoActionSheet(
          title: Text("Please chose a language"),
          message: Text('the language you use in this application.'),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          actions: <Widget>[
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context), child: Text('Dart')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context), child: Text('Java')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context), child: Text('Kotlin')),
          ],
        ),
      );

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.blue,
        onPressed: () => showDialog(
            context: context,
            builder: (ctx) => _buildCupertinoActionSheet(context)),
        child: Text(
          'Just Show It !',
          style: TextStyle(color: Colors.white),
        ),
      );
}"""
    },
  ],
  "CupertinoActionSheetAction": [
    {
      "widgetId": 132,
      "name": 'CupertinoActionSheet基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【isDefaultAction】 : 是否默认选中  【bool】\n"
          "【onPressed】 : 点击事件  【Function()】",
      "code":
          """class CustomCupertinoActionSheetAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          color: Colors.grey.withAlpha(33),
          child: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => DialogAbout.show(context),
              child: Text('张风捷特烈')),
        ),
        Container(
          color: Colors.grey.withAlpha(33),
          margin: EdgeInsets.all(5),
          child: CupertinoActionSheetAction(
              isDefaultAction: false,
              onPressed: () => DialogAbout.show(context),
              child: Text('百里·巫缨')),
        ),
      ],
    );
  }
}"""
    },
  ],
  "SimpleDialogOption": [
    {
      "widgetId": 133,
      "name": 'SimpleDialogOption基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onPressed】 : 点击事件  【Function()】",
      "code": """class CustomSimpleDialogOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          margin: EdgeInsets.all(5),
          color: Colors.grey.withAlpha(33),
          child: SimpleDialogOption(
              onPressed: () => DialogAbout.show(context),
              child: Text('张风捷特烈')),
        ),
        Container(
          height: 50,
          alignment: Alignment.center,
          width: double.infinity,
          color: Colors.grey.withAlpha(33),
          margin: EdgeInsets.all(5),
          child: SimpleDialogOption(
              onPressed: () => DialogAbout.show(context),
              child: Text('百里·巫缨')),
        ),
      ],
    );
  }
}"""
    },
  ],
  "DayPicker": [
    {
      "widgetId": 134,
      "name": 'DayPicker基本使用',
      "priority": 1,
      "subtitle": "【selectedDate】 : 选中日期   【DateTime】\n"
          "【currentDate】 : 当前日期   【DateTime】\n"
          "【firstDate】 : 最前日期限制   【DateTime】\n"
          "【lastDate】 : 最后日期限制   【DateTime】\n"
          "【displayedMonth】 : 当前展示的月份   【DateTime】\n"
          "【onChanged】 : 点击回调  【Function(DateTime)】",
      "code": """class CustomDayPicker extends StatefulWidget {
  @override
  _CustomDayPickerState createState() => _CustomDayPickerState();
}

class _CustomDayPickerState extends State<CustomDayPicker> {

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: DayPicker(
          selectedDate: _date,
          currentDate: DateTime.now(),
          onChanged: (date){
           setState(() => _date = date);
          },
          firstDate:  DateTime(2018),
          lastDate: DateTime(2030),
          displayedMonth: DateTime.now()
      ),
    );
  }
}"""
    },
  ],
  "MonthPicker": [
    {
      "widgetId": 135,
      "name": 'MonthPicker基本使用',
      "priority": 1,
      "subtitle": "【selectedDate】 : 选中日期   【DateTime】\n"
          "【firstDate】 : 最前日期限制   【DateTime】\n"
          "【lastDate】 : 最后日期限制   【DateTime】\n"
          "【onChanged】 : 点击回调  【Function(DateTime)】",
      "code": """class CustomMonthPicker extends StatefulWidget {
  @override
  _CustomMonthPickerState createState() => _CustomMonthPickerState();
}

class _CustomMonthPickerState extends State<CustomMonthPicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: MonthPicker(
        selectedDate: _date,
        onChanged: (date) => setState(() => _date = date),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
      ),
    );
  }
}"""
    },
  ],
  "YearPicker": [
    {
      "widgetId": 136,
      "name": 'YearPicker基本使用',
      "priority": 1,
      "subtitle": "【selectedDate】 : 选中日期   【DateTime】\n"
          "【firstDate】 : 最前日期限制   【DateTime】\n"
          "【lastDate】 : 最后日期限制   【DateTime】\n"
          "【onChanged】 : 点击回调  【Function(DateTime)】",
      "code": """class CustomYearPicker extends StatefulWidget {
  @override
  _CustomYearPickerState createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height:150,
      child: YearPicker(
        selectedDate: _date,
        onChanged: (date) => setState(() => _date = date),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
      ),
    );
  }
}"""
    },
  ],
  "CupertinoDatePicker": [
    {
      "widgetId": 137,
      "name": 'CupertinoDatePicker基本使用',
      "priority": 1,
      "subtitle": "【initialDateTime】 : 初始日期   【DateTime】\n"
          "【minimumYear】 : 最小年份   【int】\n"
          "【maximumYear】 : 最大年份   【int】\n"
          "【onDateTimeChanged】 : 点击回调  【Function(DateTime)】\n"
          "【minuteInterval】 : 分钟间隔  【int】\n"
          "【use24hFormat】 : 是否是24小时制  【bool】\n"
          "【backgroundColor】 : 背景色  【Color】\n"
          "【mode】 : 模式*3  【CupertinoDatePickerMode】",
      "code": """class CustomCupertinoDatePicker extends StatefulWidget {
  @override
  _CustomCupertinoDatePickerState createState() =>
      _CustomCupertinoDatePickerState();
}

class _CustomCupertinoDatePickerState extends State<CustomCupertinoDatePicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '当前日期:\${_date.toIso8601String()}',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        buildPicker(CupertinoDatePickerMode.dateAndTime),
        buildPicker(CupertinoDatePickerMode.date),
        buildPicker(CupertinoDatePickerMode.time),
      ],
    );
  }

  Container buildPicker(CupertinoDatePickerMode mode) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      child: CupertinoDatePicker(
        mode: mode,
        initialDateTime: DateTime.now(),
//        maximumDate: DateTime(2018,8,8),
//        minimumDate: DateTime(2030,8,8),
        minimumYear: 2018,
        maximumYear: 2030,
        use24hFormat: false,
        minuteInterval: 1,
        backgroundColor: CupertinoColors.white,
        onDateTimeChanged: (date) {
          print(date);
          setState(() => _date = date);
        },
      ),
    );
  }
}"""
    },
  ],
  "CupertinoTimerPicker": [
    {
      "widgetId": 138,
      "name": 'CupertinoTimerPicker基本使用',
      "priority": 1,
      "subtitle": "【initialTimerDuration】 : 初始时间   【Duration】\n"
          "【minuteInterval】 : 分钟间隔数   【double】\n"
          "【secondInterval】 : 秒间隔数   【double】\n"
          "【alignment】 : 对齐方式  【AlignmentGeometry】\n"
          "【backgroundColor】 : 背景色  【Color】\n"
          "【mode】 : 模式*3  【CupertinoTimerPickerMode】",
      "code": """class CustomCupertinoTimerPicker extends StatefulWidget {
  @override
  _CustomCupertinoTimerPickerState createState() =>
      _CustomCupertinoTimerPickerState();
}

class _CustomCupertinoTimerPickerState
    extends State<CustomCupertinoTimerPicker> {
  Duration _date = Duration(seconds: 30);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '当前时间:\${_date.toString()}',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        _buildInfoTitle('CupertinoTimerPickerMode.hms'),
        buildPicker(CupertinoTimerPickerMode.hms),
        _buildInfoTitle('CupertinoTimerPickerMode.hm'),
        buildPicker(CupertinoTimerPickerMode.hm),
        _buildInfoTitle('CupertinoTimerPickerMode.ms'),
        buildPicker(CupertinoTimerPickerMode.ms),
      ],
    );
  }

  Widget _buildInfoTitle(info) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
      child: Text(
        info,
        style: TextStyle(
            color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildPicker(CupertinoTimerPickerMode mode) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 150,
      child: CupertinoTimerPicker(
        mode: mode,
        initialTimerDuration: Duration(seconds: 30),
        onTimerDurationChanged: (date) {
          print(date);
          setState(() => _date = date);
        },
      ),
    );
  }
}"""
    },
  ],
  "CupertinoPicker": [
    {
      "widgetId": 139,
      "name": 'CupertinoPicker基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【offAxisFraction】 : 轴偏移率   【double】\n"
          "【squeeze】 : 挤压率   【double】\n"
          "【diameterRatio】 : 高与圆柱直径比率   【double】\n"
          "【itemExtent】 : 间距   【double】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【onSelectedItemChanged】 : 选中事件  【Function(int)】",
      "code": """class CustomCupertinoPicker extends StatelessWidget {
  final names = [
    'Java',
    'Kotlin',
    'Dart',
    'Swift',
    'C++',
    'Python',
    "JavaScript",
    "PHP",
    "Go",
    "Object-c"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: CupertinoPicker(
          backgroundColor: CupertinoColors.systemGrey.withAlpha(33),
          diameterRatio: 1,
          offAxisFraction: 0.4,
          squeeze: 1.5,
          itemExtent: 40,
          onSelectedItemChanged: (position) {
            print('当前条目  \${names[position]}');
          },
          children: names.map((e) => Center(child: Text(e))).toList()),
    );
  }
}"""
    },
  ],
  "SnackBar": [
    {
      "widgetId": 140,
      "name": 'SnackBar基本使用',
      "priority": 1,
      "subtitle": "【content】 : 中间内容组件   【Widget】\n"
          "【action】 : 右侧按钮   【SnackBarAction】\n"
          "【duration】 : 持续时长   【Widget】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【elevation】 : 影深   【double】\n"
          "【shape】 : 形状   【ShapeBorder】\n"
          "【onVisible】 : 显示时回调  【Function()】",
      "code": """class CustomSnackBar extends StatefulWidget {
  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
            color: Colors.blue,
            onPressed: () =>
                Scaffold.of(context).showSnackBar(_buildSnackBar()),
            child: Text(
              '点我弹出SnackBar',
              style: TextStyle(color: Colors.white),
            )));
  }

  Widget _buildSnackBar() {
    return SnackBar(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: Text('Wellcome to for join Flutter Unit!'),
      duration: Duration(seconds: 3),
      //持续时间
      backgroundColor: Colors.red,
      onVisible: () => print('onVisible'),
      action: SnackBarAction(
          textColor: Colors.white, label: '确定', onPressed: () {}),
    );
  }
}"""
    },
  ],
  "SnackBarAction": [
    {
      "widgetId": 141,
      "name": 'SnackBarAction基本使用',
      "priority": 1,
      "subtitle": "【label】 :  标签  【String】\n"
          "【textColor】 : 文字颜色   【Color】\n"
          "【disabledTextColor】 : 文字失效色   【Color】\n"
          "【onPressed】 : 点击回调  【Function()】",
      "code": """class CustomSnackBarAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SnackBarAction(
            disabledTextColor: Colors.red,
            textColor: Colors.blue,
            label: '确定',
            onPressed: () => print('onPressed')));
  }
"""
    },
  ],
  "BottomSheet": [
    {
      "widgetId": 142,
      "name": 'BottomSheet基本使用',
      "priority": 1,
      "subtitle": "【builder】 : 组件构造器   【WidgetBuilder】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【elevation】 : 影深   【double】\n"
          "【shape】 : 形状   【ShapeBorder】\n"
          "【onClosing】 : 关闭回调  【Function()】",
      "code": """class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
            color: Colors.blue,
            onPressed: () {
              opened = !opened;
              opened
                  ? Scaffold.of(context)
                      .showBottomSheet((_) => _buildBottomSheet())
                  : Navigator.of(context).pop();
            },
            child: Text(
              '点我显隐BottomSheet',
              style: TextStyle(color: Colors.white),
            )));
  }

  Widget _buildBottomSheet() => BottomSheet(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      onClosing: () => print('onClosing'),
      builder: (_) => (Container(
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sabar_bar.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                )),
          )));
}"""
    },
  ],
  "CupertinoContextMenu": [
    {
      "widgetId": 143,
      "name": 'CupertinoContextMenu基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【actions】 : 行为组件集   【List<Widget>】\n"
          "【previewBuilder】 : 动画构造器  【ContextMenuPreviewBuilder】",
      "code": """class CustomCupertinoContextMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildCupertinoContextMenu(context),
    );
  }

  final info= ['保存图片','立刻呼叫','添加到收藏夹'];

  Widget _buildCupertinoContextMenu(context) => Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/sabar_bar.jpg'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(50))),
    width: 100,
    height: 100,
    child: CupertinoContextMenu(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sabar_bar.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          actions: info.map((e)=>CupertinoContextMenuAction(
            child: Center(child: Text(e)),
            onPressed: () => Navigator.pop(context),
          )).toList())
  );
}"""
    },
  ],
  "CupertinoContextMenuAction": [
    {
      "widgetId": 144,
      "name": 'CupertinoContextMenuAction基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【isDefaultAction】 : 是否默认选中  【bool】\n"
          "【trailingIcon】 : 尾部  【bool】\n"
          "【onPressed】 : 点击事件  【Function()】",
      "code":
          """class CustomCupertinoContextMenuAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 200,
          margin: EdgeInsets.all(5),
          child: CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.settings,
              isDefaultAction: true,
              onPressed: () => DialogAbout.show(context),
              child: Text('张风捷特烈')),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.all(5),
          child: CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.home,
              isDefaultAction: false,
              onPressed: () => DialogAbout.show(context),
              child: Text('百里·巫缨')),
        ),
      ],
    );
  }
}"""
    },
  ],
  "LicensePage": [
    {
      "widgetId": 145,
      "name": 'LicensePage基本使用',
      "priority": 1,
      "subtitle": "【applicationIcon】 : 左上图标   【Widget】\n"
          "【applicationVersion】 : 版本号  【String】\n"
          "【applicationName】 : 应用名  【String】\n"
          "【applicationLegalese】 : 应用律术   【String】",
      "code": """class CustomLicensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: LicensePage(
        applicationIcon: FlutterLogo(),
        applicationVersion: 'v0.0.1',
        applicationName: 'Flutter Unit',
        applicationLegalese: 'Copyright© 2018-2020 张风捷特烈',
      ),
    );
  }
}"""
    },
  ],
  "GestureDetector": [
    {
      "widgetId": 146,
      "name": 'GestureDetector基本事件',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onTap】 : 点击事件   【Function()】\n"
          "【onDoubleTap】 : 双击事件   【Function()】\n"
          "【onLongPress】 : 长按事件   【Function()】",
      "code": """class CustomGestureDetector extends StatefulWidget {
  @override
  _CustomGestureDetectorState createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  var _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.618,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 146,
      "name": 'GestureDetector详情信息',
      "priority": 2,
      "subtitle": "【onTapDown】 : 按下回调   【Function(TapDownDetails)】\n"
          "【onTapUp】 : 子组件   【Function(TapUpDetails)】\n"
          "【onTapCancel】 : 点击取消   【Function()】",
      "code": """class TapGestureDetector extends StatefulWidget {
  @override
  _TapGestureDetectorState createState() => _TapGestureDetectorState();
}

class _TapGestureDetectorState extends State<TapGestureDetector> {
  var _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detail) => setState(() => _info =
          'onTapDown:\n相对落点:\${detail.localPosition}\n绝对落点:\${detail.globalPosition}'),
      onTapUp: (detail) => setState(() => _info =
          'onTapUp:\n相对落点:\${detail.localPosition}\n绝对落点:\${detail.globalPosition}'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.618,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 146,
      "name": 'GestureDetector的Pan事件',
      "priority": 3,
      "subtitle": "【onPanDown】 : 按下回调   【Function(DragDownDetails)】\n"
          "【onPanEnd】 : 拖动结束   【Function(DragEndDetails)】\n"
          "【onPanStart】 : 开始拖动   【Function(DragStartDetails)】\n"
          "【onPanUpdate】 : 拖动更新   【Function(TapUpDetails)】\n"
          "【onPanCancel】 : 拖动取消   【Function()】",
      "code": """class PanGestureDetector extends StatefulWidget {
  @override
  _PanGestureDetectorState createState() => _PanGestureDetectorState();
}

class _PanGestureDetectorState extends State<PanGestureDetector> {
  var _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (detail) => setState(() => _info =
          'onPanDown:\n相对落点:\${detail.localPosition}\n绝对落点:\${detail.globalPosition}'),
      onPanEnd: (detail) => setState(() => _info =
          'onPanEnd:\n初速度:\${detail.primaryVelocity}\n最终速度:\${detail.velocity}'),
      onPanUpdate: (detail) => setState(() => _info =
          'onPanUpdate:\n相对落点:\${detail.localPosition}\n绝对落点:\${detail.globalPosition}'),
      onPanStart: (detail) => setState(() => _info =
          'onPanStart:\n相对落点:\${detail.localPosition}\n绝对落点:\${detail.globalPosition}'),
      onPanCancel: () => setState(() => _info = 'onTapCancel'),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: 300,
          height: 300 * 0.618,
          color: Colors.grey.withAlpha(33),
          child: Text(
            _info,
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}"""
    },
  ],
  "Listener": [
    {
      "widgetId": 147,
      "name": 'Listener基本事件',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onPointerDown】 : 按下事件   【Function(PointerDownEvent)】\n"
          "【onPointerMove】 : 移动事件   【Function(PointerMoveEvent)】\n"
          "【onPointerMove】 : 抬起事件   【Function(PointerUpEvent)】\n"
          "【onPointerCancel】 : 取消事件   【Function(PointerUpEvent)】",
      "code": """class CustomListener extends StatefulWidget {
  @override
  _CustomListenerState createState() => _CustomListenerState();
}

class _CustomListenerState extends State<CustomListener> {
  var _info = '';

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (detail) => setState(() => _info = detail.toString()),
      onPointerMove: (detail) => setState(() => _info = detail.toString()),
      onPointerUp: (detail) => setState(() => _info = detail.toString()),
      onPointerCancel: (detail) => setState(() => _info = detail.toString()),

      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.618,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ),
    );
  }
}"""
    },
  ],
  "Tab": [
    {
      "widgetId": 148,
      "name": 'Tab基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【text】 : 文字   【String】\n"
          "【icon】 : 下方组件  【Widgit】\n"
          "    text和child不能同时存在",
      "code": """class CustomTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Tab(
            icon:Icon( Icons.add,color: Colors.blue,),
            child: Text('添加'),
          ),
          Tab(
            icon:Icon( Icons.close,color: Colors.red,),
            text: '删除',
          ),
          Tab(
            icon:Icon( Icons.refresh,color: Colors.green),
            text: '更新',
          ),
        ],
      ),
    );
  }
}"""
    },
  ],
  "InkResponse": [
    {
      "widgetId": 149,
      "name": 'InkResponse基本事件',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onTap】 : 点击事件   【Function()】\n"
          "【onDoubleTap】 : 双击事件   【Function()】\n"
          "【onTapCancel】 : 点击取消   【Function()】\n"
          "【onLongPress】 : 长按事件   【Function()】",
      "code": """class CustomInkResponse extends StatefulWidget {
  @override
  _CustomInkResponseState createState() => _CustomInkResponseState();
}

class _CustomInkResponseState extends State<CustomInkResponse> {
  var _info = 'Push';
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 100,
        child: Text(_info),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 149,
      "name": 'InkResponse其他属性',
      "priority": 2,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】\n"
          "【highlightColor】 : 高亮色   【Color】\n"
          "【splashColor】 : 水波纹色   【Color】\n"
          "【radius】 : 水波半径   【double】",
      "code": """class ColorInkResponse extends StatefulWidget {
  @override
  _ColorInkResponseState createState() => _ColorInkResponseState();
}

class _ColorInkResponseState extends State<ColorInkResponse> {
  var _info = 'Push';
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => {},
      splashColor: Colors.blueAccent,
      highlightColor: Colors.orange,
      onHighlightChanged: (v)=> setState(() => _info = 'onHighlightChanged:\$v'),
      radius: 50,
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 100,
        child: Text(_info),
      ),
    );
  }
}"""
    },
  ],
  "InkWell": [
    {
      "widgetId": 150,
      "name": 'InkWell基本事件',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onTap】 : 点击事件   【Function()】\n"
          "【onDoubleTap】 : 双击事件   【Function()】\n"
          "【onTapCancel】 : 点击取消   【Function()】\n"
          "【onLongPress】 : 长按事件   【Function()】",
      "code": """class CustomInkWell extends StatefulWidget {
  @override
  _CustomInkWellState createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  var _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 50,
        child: Text(_info),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 150,
      "name": 'InkWell其他属性',
      "priority": 2,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】\n"
          "【highlightColor】 : 高亮色   【Color】\n"
          "【splashColor】 : 水波纹色   【Color】\n"
          "【radius】 : 水波半径   【double】",
      "code": """class ColorInkWell extends StatefulWidget {
  @override
  _ColorInkWellState createState() => _ColorInkWellState();
}

class _ColorInkWellState extends State<ColorInkWell> {
  var _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      splashColor: Colors.blueAccent,
      highlightColor: Colors.orange,
      onHighlightChanged: (v) =>
          setState(() => _info = 'onHighlightChanged:\$v'),
      radius: 50,
      child: Container(
        alignment: Alignment.center,
        width: 180,
        height: 50,
        child: Text(_info),
      ),
    );
  }
}"""
    },
  ],
  "TableRowInkWell": [
    {
      "widgetId": 151,
      "name": 'TableRowInkWell基本事件',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onTap】 : 点击事件   【Function()】\n"
          "【onDoubleTap】 : 双击事件   【Function()】\n"
          "【onLongPress】 : 长按事件   【Function()】\n"
          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】",
      "code": """class CustomTableRowInkWell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = _ItemBean("单位称", "量纲", "单位", "单位名称", "单位符号");
    var m = _ItemBean("长度", "L", "1m", "米", "m");
    var kg = _ItemBean("质量", "M", "1Kg", "千克", "Kg");
    var s = _ItemBean("时间", "T", "1s", "秒", "s");
    var a = _ItemBean("安培", "Ι", "1A", "安培", "A");
    var k = _ItemBean("热力学温度", "θ", "1K", "开尔文", "K");
    var mol = _ItemBean("物质的量", "N", "1mol", "摩尔", "mol");
    var cd = _ItemBean("发光强度", "J", "1cd", "坎德拉", "cd");

    var data = <_ItemBean>[title, m, kg, s, a, k, mol, cd];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(80.0),
          1: FixedColumnWidth(80.0),
          2: FixedColumnWidth(80.0),
          3: FixedColumnWidth(80.0),
          4: FixedColumnWidth(80.0),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(
            color: Colors.orangeAccent, width: 1.0, style: BorderStyle.solid),
        children: data
            .map((item) => TableRow(children: <Widget>[
          TableRowInkWell(
            onTap: () => print('onTap'),
            onDoubleTap: () => print('onDoubleTap'),
            onLongPress: () => print('onLongPress'),
            onHighlightChanged: (v) => print('onHighlightChanged:\$v'),
            child: Center(
                child: Text(
                  item.name,
                  style: TextStyle(color: Colors.blue),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.symbol)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.unitSymbol)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.unitName)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(item.unit)),
          ),
        ]))
            .toList(),
      ),
    );
  }
}

class _ItemBean {
  String name;
  String symbol;
  String unit;
  String unitName;
  String unitSymbol;

  _ItemBean(this.name, this.symbol, this.unit, this.unitName, this.unitSymbol);
}"""
    },
  ],
  "Ink": [
    {
      "widgetId": 152,
      "name": 'Ink基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
          "【decoration】 : 装饰   【Decoration】\n"
          "【width】 : 宽   【double】\n"
          "【height】 : 高   【double】\n"
          "【color】 : 颜色   【Color】",
      "code": """class CustomInk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Ink(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),

            width: 200.0,
            height: 100.0,
            child: InkWell(
                onTap: () {
                },
                child: Center(
                  child: Text('Hello'),
                )),
          ),
        ),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 152,
      "name": 'Ink.image图片水波纹',
      "priority": 2,
      "subtitle": "    其中属性与Image组件一致，详见Image组件",
      "code": """class InkImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[800],
      child: Center(
        child: Ink.image(
          image: AssetImage('assets/images/sabar.jpg'),
          fit: BoxFit.cover,
          width: 300.0,
          height: 200.0,
          child: InkWell(
              onTap: () {},
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Chaos',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.black)),
                ),
              )),
        ),
      ),
    );
  }
}"""
    },
  ],
  "RawChip": [
    {
      "widgetId": 153,
      "name": 'RawChip点击效果',
      "priority": 1,
      "subtitle": "【label】: 中间组件   【Widget】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
          "【labelPadding】 : label边距   【EdgeInsetsGeometry】\n"
          "【shadowColor】: 阴影色   【Color】\n"
          "【avatar】: 左侧组件   【Widget】\n"
          "【elevation】: 影深   【double】\n"
          "【pressElevation】: 点击时影深   【double】\n"
          "【onPressed】 : 点击事件  【Function()】",
      "code": """class PressRawChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawChip(
        padding: EdgeInsets.all(5),
        labelPadding: EdgeInsets.all(3),
        label: Text('张风捷特烈'),
        avatar: Image.asset("assets/images/icon_head.png"),
        elevation: 3,
        pressElevation: 5,
        shadowColor: Colors.orangeAccent,
        onPressed: () => DialogAbout.show(context),
      ),
    );
  }
}"""
    },
    {
      "widgetId": 153,
      "name": 'RawChip选中和删除效果',
      "priority": 2,
      "subtitle": "【selected】: 是否选中   【bool】\n"
          "【deleteIconColor】: 尾部图标色   【Color】\n"
          "【selectedColor】: 选中色   【Color】\n"
          "【deleteIcon】: 尾部组件   【Widget】\n"
          "【onSelected】: 选中事件   【Function(bool)】\n"
          "【onDeleted】 : 尾部事件  【Function()】",
      "code": """class SelectRawChip extends StatefulWidget {
  @override
  _SelectRawChipState createState() => _SelectRawChipState();
}

class _SelectRawChipState extends State<SelectRawChip> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawChip(
        selected: _selected,
        padding: EdgeInsets.all(5),
        labelPadding: EdgeInsets.all(3),
        deleteIconColor: Colors.red,
        selectedColor: Colors.orangeAccent.withAlpha(44),
        label: Text('张风捷特烈'),
        avatar: Image.asset("assets/images/icon_head.png"),
        elevation: 3,
        pressElevation: 5,
        shadowColor: Colors.orangeAccent,
        onSelected: (v)=> setState(() => _selected=v),
        onDeleted: () => DialogAbout.show(context),
      ),
    );
  }
}"""
    },
  ],
  "Drawer": [
    {
      "widgetId": 154,
      "name": 'Drawer基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【elevation】 : 影深  【double】",
      "code": """class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Unit'),
        ),
        drawer: Drawer(
          elevation: 3,
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildChild() => ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/caver.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: Text(
              '张风捷特烈',
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
      );
}"""
    },
  ],
  "DrawerHeader": [
    {
      "widgetId": 155,
      "name": 'DrawerHeader基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【decoration】 : 装饰   【Decoration】\n"
          "【margin】 : 外边距   【EdgeInsetsGeometry】\n"
          "【padding】 : 内边距   【EdgeInsetsGeometry】",
      "code": """class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Unit'),
        ),
        drawer: Drawer(
          elevation: 3,
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildChild() => ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      _buildHeader(),
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
  );

  Widget _buildHeader() {
    return DrawerHeader(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20,top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft:Radius.circular(40),
            topRight:Radius.circular(40)
        ),
        image: DecorationImage(
            image: AssetImage('assets/images/caver.jpeg'),
            fit: BoxFit.cover),
      ),
      child: Text(
        '张风捷特烈',
        style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 3)
        ]),
      ),
    );
  }
}"""
    },
  ],
  "CupertinoApp": [
    {
      "widgetId": 156,
      "name": 'CupertinoApp基本用法',
      "priority": 1,
      "subtitle": "【theme】 : 主题   【ThemeData】\n"
          "【title】 : 任务栏标题   【String】\n"
          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
          "【home】 : 主页   【Widget】",
      "code": """class CustomCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.white,
        ),
        home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Icon(
              CupertinoIcons.reply,
              color: CupertinoColors.black,
            ),
            trailing: Icon(
              CupertinoIcons.share,
              color: CupertinoColors.black,
            ),
            middle: Text('Flutter Unit'),
          ),
          backgroundColor: CupertinoColors.systemBackground,
          child: Center(
            child: Text('Hello, World!'),
          ),
        ),
      ),
    );
  }
}"""
    },
  ],
  "CupertinoPageScaffold": [
    {
      "widgetId": 157,
      "name": 'CupertinoPageScaffold基本用法',
      "priority": 1,
      "subtitle": "【child】 : 内容   【Widget】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【navigationBar】 : 头部   【ObstructingPreferredSizeWidget】",
      "code": """class CustomCupertinoPageScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(CupertinoIcons.back),
          trailing: Icon(CupertinoIcons.share),
          middle: Text('Flutter Unit'),
        ),
        backgroundColor: CupertinoColors.white,
        child: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}"""
    },
  ],
  "CupertinoTabScaffold": [
    {
      "widgetId": 158,
      "name": 'CupertinoTabScaffold基本用法',
      "priority": 1,
      "subtitle": "【tabBar】 : 页签条   【CupertinoTabBar】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【controller】 : 控制器   【CupertinoTabController】\n"
          "【tabBuilder】 : 页面构造器   【IndexedWidgetBuilder】",
      "code": """class CustomCupertinoTabScaffold extends StatefulWidget {
  @override
  _CustomCupertinoTabScaffoldState createState() =>
      _CustomCupertinoTabScaffoldState();
}

class _CustomCupertinoTabScaffoldState
    extends State<CustomCupertinoTabScaffold> {
  var _position = 0;
  final iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 300,
      child: CupertinoTabScaffold(
          backgroundColor: Colors.grey.withAlpha(11),
          tabBar: _buildTabBar(),
          tabBuilder: (_, index) => _buildContent(index)),
    );
  }

  CupertinoTabBar _buildTabBar() => CupertinoTabBar(
        currentIndex: _position,
        onTap: (value) => setState(() => _position = value),
        items: iconsMap.keys
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(
                    iconsMap[e],
                  ),
                  title: Text(e),
                ))
            .toList(),
        activeColor: Colors.blue,
        inactiveColor: Color(0xff333333),
        backgroundColor: Color(0xfff1f1f1),
        iconSize: 25.0,
      );

  _buildContent(int index) => Container(
      alignment: Alignment.center,
      child: Text(iconsMap.keys.toList()[index]),
    );
}"""
    },
  ],
  "PositionedDirectional": [
    {
      "widgetId": 159,
      "name": 'PositionedDirectional基本使用',
      "priority": 1,
      "subtitle": "【child】 : 组件   【Widget】\n"
          "【top】 : 到父顶距离   【double】\n"
          "【end】 : 到父右距离   【double】\n"
          "【start】 : 到父左距离   【double】\n"
          "【bottom】 : 到父底距离   【double】",
      "code": """class CustomPositionedDirectional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    var redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    var greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    var cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
        width: 200,
        height: 120,
        color: Colors.grey.withAlpha(33),
        child: Stack(
          children: <Widget>[
            yellowBox,
            redBox,
            PositionedDirectional(top: 20, start: 20, child: greenBox),
            PositionedDirectional(
              child: cyanBox,
              bottom: 10,
              end: 10,
            )
          ],
        ));
  }
}"""
    },
  ],
  "Material": [
    {
      "widgetId": 160,
      "name": 'Material基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【type】 : 类型   【MaterialType】\n"
          "【elevation】 : 影深   【double】\n"
          "【shadowColor】 : 阴影颜色   【Color】\n"
          "【color】 : 颜色   【Color】",
      "code": """class CustomMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: MaterialType.values.map((e) => _buildMaterial(e)).toList());
  }

  Material _buildMaterial(MaterialType type) => Material(
        shadowColor: Colors.blue,
        type: type,
        color: Colors.orange,
        elevation: 3,
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          child: Text(
            type.toString().split('.')[1],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}"""
    },
    {
      "widgetId": 160,
      "name": 'Material的shape属性',
      "priority": 2,
      "subtitle": "【shape】 : 形状   【ShapeBorder】",
      "code": """class ShapeMaterial extends StatelessWidget {
  
  final shapeMap = {
    'BorderDirectional': BorderDirectional(
        top: BorderSide(
          color: Colors.white,
        ),
        start: BorderSide(color: Colors.black, width: 15),
        bottom: BorderSide(
          color: Colors.white,
        )),
    'Border': Border(
      top: BorderSide(width: 5.0, color: Color(0xFFFFDFDFDF)),
      left: BorderSide(width: 5.0, color: Color(0xFFFFDFDFDF)),
      right: BorderSide(width: 5.0, color: Color(0xFFFF7F7F7F)),
      bottom: BorderSide(width: 5.0, color: Color(0xFFFF7F7F7F)),
    ),
    'Circle': CircleBorder(
      side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
    ),
    'RoundedRectangleBorder': RoundedRectangleBorder(
        side: BorderSide(width: 1.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(15))),
    'ContinuousRectangleBorder': ContinuousRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.circular(40.0),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: shapeMap.keys.map((e) => _buildMaterial(e)).toList());
  }

  Material _buildMaterial(String type) => Material(
        shadowColor: Colors.blue,
        shape: shapeMap[type],
        color: Colors.orange,
        elevation: 3,
        textStyle: TextStyle(color: Colors.white),
        child: Container(
          alignment: Alignment.center,
          width: 300,
          height: 60,
          child: Text(
            type,
          ),
        ),
      );
}"""
    },
  ],
  "IndexedStack": [
    {
      "widgetId": 161,
      "name": 'IndexedStack基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【Lis<Widget>】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】\n"
          "【index】 : 当前显示组件  【int】",
      "code": """class CustomIndexedStack extends StatefulWidget {
  @override
  _CustomIndexedStackState createState() => _CustomIndexedStackState();
}

class _CustomIndexedStackState extends State<CustomIndexedStack> {
  var _index = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          width: 200,
          height: 100,
          color: Colors.grey.withAlpha(33),
          child: IndexedStack(
            index: _index,
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 80,
                height: 80,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  color: Colors.blue,
                  width: 80,
                  height: 80,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
        value: _index == 0,
        onChanged: (v) => setState(() => _index = v ? 0 : 1),
      );
}"""
    },
  ],
  "ListView": [
    {
      "widgetId": 162,
      "name": 'ListView基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【padding】 : 点击事件  【EdgeInsetsGeometry】",
      "code": """class CustomListView extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        children: data
            .map((color) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: color,
                  child: Text(
                    colorString(color),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 162,
      "name": 'ListView横向滑动',
      "priority": 2,
      "subtitle": "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【reverse】 : 是否反向滑动   【bool】\n"
          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
      "code": """class HorizontalListView extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        reverse: true,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: data
            .map((color) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: color,
                  child: Text(
                    colorString(color),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 162,
      "name": 'ListView.builder构造',
      "priority": 3,
      "subtitle": "【itemCount】 : 条目个数   【int】\n"
          "【itemBuilder】 : 条目构造器   【IndexedWidgetBuilder】",
      "code": """class BuilderListView extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => _buildItem(data[index]),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _buildItem(Color color) => Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        color: color,
        child: Text(
          colorString(color),
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
          ]),
        ),
      );
}"""
    },
    {
      "widgetId": 162,
      "name": 'ListView.separated构造',
      "priority": 3,
      "subtitle": "【separatorBuilder】 : 条目构造器   【IndexedWidgetBuilder】",
      "code": """class SeparatedListView extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          height: 1,
          color: Colors.orange,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) => _buildItem(data[index]),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _buildItem(Color color) => Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        color: color,
        child: Text(
          colorString(color),
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
          ]),
        ),
      );
}"""
    },
  ],
  "GridView": [
    {
      "widgetId": 163,
      "name": 'GridView.count构造',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【crossAxisCount】 : 主轴一行box数量  【int】\n"
          "【mainAxisSpacing】 : 主轴每行间距  【double】\n"
          "【crossAxisSpacing】 : 交叉轴每行间距  【double】\n"
          "【childAspectRatio】 : box主长/交叉轴长  【double】\n"
          "【crossAxisCount】 : 主轴一行数量  【int】",
      "code": """class CustomGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFFFF00FF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1/0.618,
        children: data
            .map((color) => _buildItem(color))
            .toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
                alignment: Alignment.center,
                width: 100,
                height: 30,
                color: color,
                child: Text(
                  colorString(color),
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(.5, .5),
                        blurRadius: 2)
                  ]),
                ),
              );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 163,
      "name": 'GridView滑动方向',
      "priority": 2,
      "subtitle": "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【reverse】 : 是否反向滑动   【bool】\n"
          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
      "code": """class HorizontalGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF00FFFF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        reverse: true,
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.618,
        children: data
            .map((color) => _buildItem(color))
            .toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: TextStyle(color: Colors.white, shadows: [
        Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2)
      ]),
    ),
  );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 163,
      "name": 'GridView.extent构造',
      "priority": 3,
      "subtitle": "【maxCrossAxisExtent】 : box轴向长度   【double】\n"
          "【reverse】 : 是否反向滑动   【bool】\n"
          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
      "code": """class ExtentGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF00FFFF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.extent(
        scrollDirection: Axis.horizontal,
        maxCrossAxisExtent: 80.0,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.618,
        children: data
            .map((color) => _buildItem(color))
            .toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: TextStyle(color: Colors.white, shadows: [
        Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2)
      ]),
    ),
  );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 163,
      "name": 'GridView.builder构造',
      "priority": 4,
      "subtitle": "【itemCount】 : 条目数量   【int】\n"
          "【gridDelegate】 : 网格代理   【SliverGridDelegate】\n"
          "【itemBuilder】 : 条目构造器  【IndexedWidgetBuilder】",
      "code": """class BuilderGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF33FFF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//网格代理：定交叉轴数目
          crossAxisCount: 4,//条目个数
          mainAxisSpacing: 5,//主轴间距
          crossAxisSpacing: 5,//交叉轴间距
          childAspectRatio:1/0.618),
        itemBuilder: (_, int position)=> _buildItem(data[position])
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: TextStyle(color: Colors.white, shadows: [
        Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2)
      ]),
    ),
  );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "SingleChildScrollView": [
    {
      "widgetId": 164,
      "name": 'SingleChildScrollView基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【padding】 : 点击事件  【EdgeInsetsGeometry】",
      "code": """class CustomSingleChildScrollView extends StatelessWidget {
  final data = <Color>[
    Colors.blue[50],
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.blue[700],
    Colors.blue[800],
    Colors.blue[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: data
              .map((color) => Container(
            alignment: Alignment.center,
            height: 50,
            color: color,
            child: Text(
              colorString(color),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(.5, .5),
                    blurRadius: 2)
              ]),
            ),
          ))
              .toList(),
        ),

      ),
    );
  }
  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 164,
      "name": 'SingleChildScrollView滑动方向',
      "priority": 2,
      "subtitle": "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【reverse】 : 是否反向   【Axis】",
      "code": """class DirectionSingleChildScrollView extends StatelessWidget {
  final data = <Color>[
    Colors.blue[50],
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.blue[700],
    Colors.blue[800],
    Colors.blue[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: data
              .map((color) => Container(
            alignment: Alignment.center,
            width: 90,
            color: color,
            child: Text(
              colorString(color),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(.5, .5),
                    blurRadius: 2)
              ]),
            ),
          ))
              .toList(),
        ),

      ),
    );
  }
  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "PageView": [
    {
      "widgetId": 165,
      "name": 'PageView基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【onPageChanged】 : 点击事件  【ValueChanged<int>】",
      "code": """class CustomPageView extends StatelessWidget {
  final data = <Color>[
    Colors.green[50],
    Colors.green[100],
    Colors.green[200],
    Colors.green[300],
    Colors.green[400],
    Colors.green[500],
    Colors.green[600],
    Colors.green[700],
    Colors.green[800],
    Colors.green[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView(
        onPageChanged: (position){
          print(position);
        },
        children: data
            .map((color) => Container(
          alignment: Alignment.center,
          width: 90,
          color: color,
          child: Text(
            colorString(color),
            style: TextStyle(color: Colors.white,
                fontSize:24,shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ))
            .toList(),
      ),
    );
  }
  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 165,
      "name": 'PageView滑动方向',
      "priority": 2,
      "subtitle": "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【reverse】 : 是否反向  【bool】",
      "code": """class DirectionPageView extends StatelessWidget {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView(
        scrollDirection: Axis.vertical,
        reverse: true,
        onPageChanged: (position) {
          print(position);
        },
        children: data
            .map((color) =>
            Container(
              alignment: Alignment.center,
              width: 90,
              color: color,
              child: Text(
                colorString(color),
                style: TextStyle(color: Colors.white,
                    fontSize: 24, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
              ),
            ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 165,
      "name": 'PageView滑动方向',
      "priority": 3,
      "subtitle": "【controller】 : 页面控制器   【PageController】",
      "code": """class CtrlPageView extends StatefulWidget {
  @override
  _CtrlPageViewState createState() => _CtrlPageViewState();
}

class _CtrlPageViewState extends State<CtrlPageView> {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  PageController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller=PageController(
      viewportFraction: 0.8,
      initialPage: (data.length/2).round()
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: PageView(
        controller: _controller,
        onPageChanged: (position) {
          print(position);
        },
        children: data
            .map((color) =>
            Container(
              alignment: Alignment.center,
              width: 90,
              color: color,
              child: Text(
                colorString(color),
                style: TextStyle(color: Colors.white,
                    fontSize: 24, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
              ),
            ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "CustomPaint": [
    {
      "widgetId": 166,
      "name": 'CustomPaint绘线图形',
      "priority": 1,
      "subtitle": "【painter】 : 绘画器   【CustomPainter】",
      "code": """class ClockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child:CustomPaint(//使用CustomPaint盛放画布
        painter: ClockPainter(),
      ),
    )
    ;
  }
}

class ClockPainter extends CustomPainter {
  Paint _paint;
  var _radius = 3.0; //小球半径
  Path _path = Path(); //画笔对象
  ClockPainter () {
    _paint = Paint()..color= Color(0xff45d0fd)..isAntiAlias=true;
    _path.addOval(Rect.fromCircle(radius: _radius, center: Offset(0, 0))); //小球路径
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width/2-65*2, 0);
    renderDigit(1, canvas);//渲染数字
    canvas.translate(65, 0);//平移画布
    renderDigit(9, canvas);
    canvas.translate(65, 0); renderDigit(9, canvas);
    canvas.translate(65, 0); renderDigit(4, canvas);
  }
  //渲染数字  num  ：要显示的数字   canvas ：画布
  void renderDigit(int num, Canvas canvas) {
    if (num > 10) {  return; }
    for (int i = 0; i < digit[num].length; i++) {
      for (int j = 0; j < digit[num][j].length; j++) {
        if (digit[num][i][j] == 1) {
          canvas.save();
          double rX = j * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心横坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1); //第(i，j)个点圆心纵坐标
          canvas.translate(rX, rY);
          canvas.drawPath(_path, _paint);
          canvas.restore();
        }
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate)=>false;
}"""
    },
    {
      "widgetId": 166,
      "name": 'CustomPaint绘线贝塞尔曲线',
      "priority": 2,
      "subtitle": "    Flutter也支持贝塞尔曲线等复杂绘制。",
      "code": """class PlayBezier3Page extends StatefulWidget {
  @override
  _PlayBezier3PageState createState() => _PlayBezier3PageState();
}

class _PlayBezier3PageState extends State<PlayBezier3Page> {
  List<Offset> _pos = <Offset>[];
  int selectPos;

  @override
  void initState() {
    _initPoints();
    super.initState();
  }

  void _initPoints() {
    _pos = List<Offset>();
    _pos.add(Offset(0, 0));
    _pos.add(Offset(60, -60));
    _pos.add(Offset(-90, -90));
    _pos.add(Offset(-120, -40));
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: BezierPainter(pos: _pos, selectPos: selectPos),
        ),

    );
  }
}

class BezierPainter extends CustomPainter {
  Paint _gridPaint;
  Path _gridPath;

  Paint _mainPaint;
  Path _mainPath;
  int selectPos;
  Paint _helpPaint;

  List<Offset> pos;

  BezierPainter({this.pos, this.selectPos}) {
    _gridPaint = Paint()..style = PaintingStyle.stroke;
    _gridPath = Path();

    _mainPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    _mainPath = Path();

    _helpPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size); //绘制格线
    _drawAxis(canvas, size); //绘制轴线

      _mainPath.moveTo(pos[0].dx, pos[0].dy);
      _mainPath.cubicTo(pos[1].dx, pos[1].dy, pos[2].dx, pos[2].dy, pos[3].dx, pos[3].dy);
      canvas.drawPath(_mainPath, _mainPaint);
      _drawHelp(canvas);
      _drawSelectPos(canvas);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void _drawGrid(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.grey
      ..strokeWidth = 0.5;
    _gridPath = _buildGridPath(_gridPath, size);
    canvas.drawPath(_buildGridPath(_gridPath, size), _gridPaint);

    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    canvas.drawPath(_gridPath, _gridPaint);
    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    canvas.drawPoints(
        PointMode.lines,
        [
          Offset(-size.width / 2, 0),
          Offset(size.width / 2, 0),
          Offset(0, -size.height / 2),
          Offset(0, size.height / 2),
          Offset(0, size.height / 2),
          Offset(0 - 7.0, size.height / 2 - 10),
          Offset(0, size.height / 2),
          Offset(0 + 7.0, size.height / 2 - 10),
          Offset(size.width / 2, 0),
          Offset(size.width / 2 - 10, 7),
          Offset(size.width / 2, 0),
          Offset(size.width / 2 - 10, -7),
        ],
        _gridPaint
          ..color = Colors.blue
          ..strokeWidth = 1.5);
  }

  Path _buildGridPath(Path path, Size size, {step = 20.0}) {
    for (int i = 0; i < size.height / 2 / step; i++) {
      path.moveTo(0, step * i);
      path.relativeLineTo(size.width / 2, 0);
    }
    for (int i = 0; i < size.width / 2 / step; i++) {
      path.moveTo(step * i, 0);
      path.relativeLineTo(
        0,
        size.height / 2,
      );
    }
    return path;
  }

  void _drawHelp(Canvas canvas) {
    canvas.drawPoints(PointMode.lines, pos, _helpPaint..strokeWidth = 1);
    canvas.drawPoints(PointMode.points, pos, _helpPaint..strokeWidth = 8);
  }

  void _drawSelectPos(Canvas canvas) {
    if (selectPos == null) return;
    canvas.drawCircle(
        pos[selectPos],
        10,
        _helpPaint
          ..color = Colors.green
          ..strokeWidth = 2);
  }
}"""
    },
  ],
  "MediaQuery": [
    {
      "widgetId": 167,
      "name": 'MediaQuery获取数据信息',
      "priority": 1,
      "subtitle": "MediaQuery.of(context)可以获取MediaQueryData",
      "code": """class CustomMediaQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var data = {
      "size": queryData.size,
      "devicePixelRatio": queryData.devicePixelRatio.toStringAsFixed(1),
      "textScaleFactor": queryData.textScaleFactor.toStringAsFixed(1),
      "platformBrightness": queryData.platformBrightness,
      "padding": queryData.padding,
      "viewInsets": queryData.viewInsets,
      "systemGestureInsets": queryData.padding,
      "viewPadding": queryData.padding,
      "physicalDepth": queryData.padding,
      "alwaysUse24HourFormat": queryData.padding,
      "accessibleNavigation": queryData.alwaysUse24HourFormat,
      "invertColors": queryData.invertColors,
      "highContrast": queryData.highContrast,
      "disableAnimations": queryData.disableAnimations,
      "boldText": queryData.boldText,
    };

    return Container(
      height: 200,
      child: ListView(
        children: data.keys.map((e) => buildItem(e, data)).toList(),
      ),
    );
  }

  Widget buildItem(String e, Map<String, Object> data) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  e,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  data[e].toString(),
                  style: TextStyle(fontSize: 16, color: Colors.orange),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      );
}"""
    },
  ],
  "Theme": [
    {
      "widgetId": 168,
      "name": '文字样式-ThemeData#TextTheme',
      "priority": 1,
      "subtitle":
      "后代组件可以通过ThemeData.of获取主题的数据进行使用。",
      "code": """class TextThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var queryData = Theme.of(context).textTheme;
    var styles = {
      "headline: ": queryData.headline,
      "title: ": queryData.title,
      "subhead: ": queryData.subhead,
      "subtitle: ": queryData.body1,
      "body2: ": queryData.body2,
      "button: ": queryData.button,
      "overline: ": queryData.overline,
      "subtitle: ": queryData.subtitle,
      "button: ": queryData.caption,
      "display1: ": queryData.display1,
      "display2: ": queryData.display2,
      "display3: ": queryData.display3,
      "display4: ": queryData.display4,
    };

    return Container(
      child: Column(
        children: styles.keys.map((e) => buildItem(e, styles[e])).toList(),
      ),
    );
  }

  Widget buildItem(String e, TextStyle style) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  e,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@toly",
                  style: style,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      );
}"""
    },
    {
      "widgetId": 168,
      "name": 'Theme的用法',
      "priority": 2,
      "subtitle":
      "使用Theme,可以指定非常多的属性作为主题,这些属性将应用于所有的后代组件，如指定字体、滑块、卡片、文字、分割线、按钮等属性。注意如果需要使用主题，不能在当前的context中获取。",
      "code": """class CustomTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            cardTheme: CardTheme(color: Colors.red, elevation: 4),
            dividerTheme: DividerThemeData(
              color: Colors.blue,
              thickness: 2
            ),
            sliderTheme: SliderThemeData(
              thumbColor: Colors.red,
              activeTrackColor: Colors.green,
              inactiveTrackColor: Colors.grey,
            )),
        child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
          Card(
            child: Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
            ),
          ),
          Container(
              width: 150,
              child: Slider(value: 0.8, onChanged: (v) => {})),
              Container(  width: 150,child: Divider())
        ]));
  }
}"""
    },
  ],
  "CupertinoTheme": [
    {
      "widgetId": 169,
      "name": '文字样式-TextTheme',
      "priority": 1,
      "subtitle": "后代组件可以通过CupertinoTheme.of获取主题的数据进行使用。",
      "code": """class TextCupertinoTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var queryData = CupertinoTheme.of(context).textTheme;
    var styles = {
      "tabLabelTextStyle: ": queryData.tabLabelTextStyle,
      "actionTextStyle: ": queryData.actionTextStyle,
      "navActionTextStyle: ": queryData.navActionTextStyle,
      "textStyle: ": queryData.textStyle,
      "navTitleTextStyle: ": queryData.navTitleTextStyle,
      "pickerTextStyle: ": queryData.pickerTextStyle,
      "dateTimePickerTextStyle: ": queryData.dateTimePickerTextStyle,
      "navLargeTitleTextStyle: ": queryData.navLargeTitleTextStyle,
    };

    return Container(
      child: Column(
        children: styles.keys.map((e) => buildItem(e, styles[e])).toList(),
      ),
    );
  }

  Widget buildItem(String e, TextStyle style) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  e,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@toly",
                  style: style,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      );
}"""
    },
    {
      "widgetId": 169,
      "name": 'CupertinoThemeData的使用',
      "priority": 2,
      "subtitle":
      "和Theme一样可以通过指定的属性，让它们在后代中共享，不过属性较少。注意如果需要使用主题，不能在当前的context中获取。",
      "code": """class CustomCupertinoTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
        data: CupertinoThemeData(
           primaryColor: Colors.blue,
               primaryContrastingColor: Colors.green
        ),
          child: _ChildUseTheme());
  }
}

class _ChildUseTheme extends StatelessWidget {
  const _ChildUseTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
        Container(
              width: 50,
              height: 50,
              color: CupertinoTheme.of(context).primaryContrastingColor,
            ),
          Container(
              width: 150,
              child: Slider(value: 0.8, onChanged: (v) => {})),
          Container(  width: 150,child: Divider(color:CupertinoTheme.of(context).primaryContrastingColor,thickness: 1,))
        ]);
  }
}"""
    },
  ],
  "WillPopScope": [
    {
      "widgetId": 170,
      "name": 'WillPopScope使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onWillPop】 : 返回回调  【WillPopCallback】",
      "code": """class CustomWillPopScope extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(child: (BackButton()),
          onWillPop: ()=>_willPop(context)),
    );
  }

  Future<bool> _willPop(context) async{
    return await showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title:  Text('提示'),
        content:  Text('你确定要离开此页吗?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:  Text('确定'),
          ),
           FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text('取消'),
          ),

        ],
      ),
    ) ?? false;

  }
}"""
    },
  ],
  "Hero": [
    {
      "widgetId": 171,
      "name": 'Hero基本使用',
      "priority": 1,
      "subtitle": "【tag】 : 标签   【String】\n",
      "code": """class CustomHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hero = Hero(
      //----定义一个Hero,并添加tag标签,此中组件共享
      tag: 'user-head',
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Image.asset(
          "assets/images/icon_head.png",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );

    var container = Container(
      alignment: Alignment(-0.8, -0.8),
      child: hero,
      width: 250,
      height: 250 * 0.618,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.red.withAlpha(99),
        Colors.yellow.withAlpha(189),
        Colors.green.withAlpha(88),
        Colors.blue.withAlpha(230)
      ])),
    );

    return GestureDetector(
      child: Card(elevation: 5, child: container),
      onTap: () => Navigator.push(
        context,
        Bottom2TopRouter(child: TargetPage(), duration_ms: 1000),
      ),
    );
  }
  
}

class TargetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hero = Hero(
      //----定义一个Hero,为其添加标签，两个标签相同，则可以共享
      tag: 'user-head',
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            "assets/images/icon_head.png",
          ),
        ),
      ),
    );

    var touch = InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: hero,
    );

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[touch],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red.withAlpha(99),
          Colors.yellow.withAlpha(189),
          Colors.green.withAlpha(88),
          Colors.blue.withAlpha(230)
        ])),
      ),
    );
  }
}

//下--->上
class Bottom2TopRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration_ms;
  final Curve curve;

  Bottom2TopRouter(
      {this.child, this.duration_ms = 500, this.curve = Curves.fastOutSlowIn})
      : super(
            transitionDuration: Duration(milliseconds: duration_ms),
            pageBuilder: (ctx, a1, a2) {
              return child;
            },
            transitionsBuilder: (
              ctx,
              a1,
              a2,
              Widget child,
            ) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                  child: child);
            });
}"""
    },
  ],
  "FutureBuilder": [
    {
      "widgetId": 172,
      "name": 'FutureBuilder基本使用',
      "priority": 1,
      "subtitle": "【builder】 : 子组件   【AsyncWidgetBuilder<T>】\n"
          "【initialData】 : 初始数据   【T】\n"
          "【future】 : 异步任务  【Future<T>】",
      "code": """class CustomFutureBuilder extends StatelessWidget {

  final FutureBuilder futureBuilder = FutureBuilder(
    initialData: 'Load',
      future: loadData(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return Text(snap.data);
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snap.hasError) {
          return Text('Error');
        }
        return Container();
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: futureBuilder,
    );
  }

  static Future<String> loadData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'LoadeSuccess';
  }
}"""
    },
  ],
  "StreamBuilder": [
    {
      "widgetId": 173,
      "name": 'StreamBuilder基本使用',
      "priority": 1,
      "subtitle": "【stream】 : 子组件   【Stream<T>】\n"
          "【initialData】 : 初始数据   【T】\n"
          "【builder】 : 点击事件  【AsyncWidgetBuilder<T>】",
      "code": """class CustomStreamBuilder extends StatefulWidget {
  @override
  _CustomStreamBuilderState createState() => _CustomStreamBuilderState();
}

class _CustomStreamBuilderState extends State<CustomStreamBuilder> {
  CountGenerator _generator = CountGenerator()..increment();

  @override
  void dispose() {
    _generator.dispose(); //关闭控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            color: Colors.blue,
            shape: CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              await _generator.increment();
            },
          ),
          _buildStreamBuilder(),
          FlatButton(
            color: Colors.blue,
            shape: CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () async {
              await _generator.minus();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStreamBuilder() => StreamBuilder<int>(
      stream: _generator.state,
      builder: (BuildContext context, AsyncSnapshot snap) {
        print(snap);
        if (snap.connectionState == ConnectionState.done) {
          return Text('Done');
        }
        if (snap.connectionState == ConnectionState.active) {
          return Text(
            snap.data.toString(),
            style: Theme.of(context).textTheme.display1,
          );
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snap.hasError) {
          return Text('Error');
        }
        return Container();
      });
}

class CountGenerator {
  int _count = 0; //计数器数据
  final StreamController<int> _controller = StreamController(); //控制器

  Stream<int> get state => _controller.stream; //获取状态流
  int get count => _count; //获取计数器数据

  void dispose() {//关闭控制器
    _controller.close();
  }

  Future<void> increment() async {//增加记数方法
    _controller.add(++_count);
  }

  Future<void> minus() async {//增加记数方法
    _controller.add(--_count);
  }
}"""
    },
  ],
  "PopupMenuDivider": [
    {
      "widgetId": 174,
      "name": 'PopupMenuDivider基本使用',
      "priority": 1,
      "subtitle":
          "【height】 : 高度  【double】",
      "code": """class CustomPopupMenuDivider extends StatelessWidget {
  final map = {
    "关于": Icons.info_outline,
    "帮助": Icons.help_outline,
    "问题反馈": Icons.add_comment,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildPopupMenuButton(context),
          PopupMenuDivider(),
        ],
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
          itemBuilder: (context) => [
            ...buildItems().sublist(0, 2),
            PopupMenuDivider(),
            ...buildItems().sublist(2, 3)
          ],
          offset: Offset(0, 50),
          color: Color(0xffF4FFFA),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          )),
          onSelected: (e) {
            print(e);
            if (e == '关于') {
              DialogAbout.show(context);
            }
          },
          onCanceled: () => print('onCanceled'),
        );
  }

  List<PopupMenuItem<String>> buildItems() {
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
            value: e,
            child: Wrap(
              spacing: 10,
              children: <Widget>[
                Icon(
                  map[e],
                  color: Colors.blue,
                ),
                Text(e),
              ],
            )))
        .toList();
  }
}"""
    },
  ],
  "RawMaterialButton": [
    {
      "widgetId": 175,
      "name": 'RawMaterialButton基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【elevation】 : 影深   【double】\n"
          "【fillColor】 : 填充色   【Color】\n"
          "【splashColor】 : 水波纹色   【Color】\n"
          "【textStyle】 : 文字样式   【TextStyle】\n"
          "【onLongPress】 : 长按事件   【Function()】\n"
          "【onPressed】 : 点击事件  【Function()】",
      "code": """class CustomRawMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 20,
        children: <Widget>[
          RawMaterialButton(
            elevation: 2,
            fillColor: Colors.green,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            onLongPress: ()=>print('onLongPress'),
            child: Icon(Icons.remove),
            onPressed: ()=>print('onPressed'),
          ),
          RawMaterialButton(
            elevation: 2,
            fillColor: Colors.blue,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            onLongPress: ()=>print('onLongPress'),
            child: Text('Push'),
            onPressed: ()=>print('onPressed'),
          ),
          RawMaterialButton(
            elevation: 2,
            fillColor: Colors.red,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            onLongPress: ()=>print('onLongPress'),
            child: Icon(Icons.add),
            onPressed: ()=>print('onPressed'),
          ),

        ],
      ),
    );
  }
}"""
    },
    {
      "widgetId": 175,
      "name": 'RawMaterialButton基本使用',
      "priority": 2,
      "subtitle": "【highlightElevation】 : 高亮影深   【double】\n"
          "【shape】 : 形状   【ShapeBorder】",
      "code": """class ShapeRawMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 20,
        children: <Widget>[
          RawMaterialButton(
            elevation: 2,
            shape:  CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            fillColor: Colors.green,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            onLongPress: ()=>print('onLongPress'),
            child: Icon(Icons.remove),
            onPressed: ()=>print('onPressed'),
          ),
          RawMaterialButton(
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            elevation: 0,
            highlightElevation: 0,
            fillColor: Colors.blue,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            onLongPress: ()=>print('onLongPress'),
            child: Text('Push'),
            onPressed: ()=>print('onPressed'),
          ),
          RawMaterialButton(
            elevation: 2,
            shape:  CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            fillColor: Colors.red,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            onLongPress: ()=>print('onLongPress'),
            child: Icon(Icons.add),
            onPressed: ()=>print('onPressed'),
          ),

        ],
      ),
    );
  }
}"""
    },
  ],
  "Dismissible": [
    {
      "widgetId": 176,
      "name": 'Dismissible基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【background】 : 左底  【Widget】\n"
          "【secondaryBackground】 : 右底  【Widget】\n"
          "【key】 : 键  【Key】\n"
          "【confirmDismiss】 : 确认回调  【DismissDirectionCallback】\n"
          "【onDismissed】 : 消失回调  【DismissDirectionCallback】\n",
      "code": """class CustomDismissible extends StatefulWidget {
  @override
  _CustomDismissibleState createState() => _CustomDismissibleState();
}

class _CustomDismissibleState extends State<CustomDismissible> {
  var data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  Widget _buildItem(Color color) {
    return Dismissible(
      background: Container(
        color: Colors.green,
        alignment: Alignment(-0.9, 0),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment(0.9, 0),
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
        color: Colors.red,
      ),
      key: ValueKey(color),
      onDismissed: (d) {
        data.remove(color);
      },
      confirmDismiss: (e) async {
        if (e == DismissDirection.endToStart) {
          return true;
        } else {
          return false;
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        color: color,
        child: Text(
          colorString(color),
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
          ]),
        ),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 176,
      "name": 'Dismissible基本使用',
      "priority": 2,
      "subtitle": "【direction】 : 方向   【DismissDirection】\n"
          "【crossAxisEndOffset】 : 偏移  【double】\n",
      "code": """class DirectionDismissible extends StatefulWidget {
  @override
  _CustomDirectionDismissibleState createState() => _CustomDirectionDismissibleState();
}

class _CustomDirectionDismissibleState extends State<DirectionDismissible> {
  var data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  var info = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 5),
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  Widget _buildItem(Color color) {
    return Dismissible(
      direction: DismissDirection.vertical,
      background: Container(
        color: Colors.green,
        alignment: Alignment( 0,-0.9,),
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      crossAxisEndOffset: 0.5,
      secondaryBackground: Container(
        alignment: Alignment( 0,0.9,),
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
        color: Colors.red,
      ),
      key: ValueKey(color),
      onDismissed: (d) {
        data.remove(color);
      },
      confirmDismiss: (e) async {
        print(e);
        if (e == DismissDirection.up) {
          return true;
        } else {
          return false;
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 80,
        color: color,
        child: Text(
          colorString(color),
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
          ]),
        ),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "ReorderableListView": [
    {
      "widgetId": 177,
      "name": 'ReorderableListView基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【header】 : 头部组件   【Widget】\n"
          "【padding】 : 内边距   【EdgeInsets】\n"
          "【onReorder】 : 调换时回调  【ReorderCallback】",
      "code": """class CustomReorderableListView extends StatefulWidget {
  @override
  _CustomReorderableListViewState createState() => _CustomReorderableListViewState();
}

class _CustomReorderableListViewState extends State<CustomReorderableListView> {
  var data = <Color>[
    Colors.yellow[50],
    Colors.yellow[100],
    Colors.yellow[200],
    Colors.yellow[300],
    Colors.yellow[400],
    Colors.yellow[500],
    Colors.yellow[600],
    Colors.yellow[700],
    Colors.yellow[800],
    Colors.yellow[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ReorderableListView(
        padding: EdgeInsets.all(10),
        header: Container(
          color: Colors.blue,
          alignment: Alignment.center,
            height: 50,
            child: Text('长按拖拽进行换位',style: TextStyle(color: Colors.white),)),
        onReorder: _handleReorder,
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    setState(() {
      final element = data.removeAt(oldIndex);
      data.insert(newIndex, element);
    });

  }

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color)  ,
      alignment: Alignment.center,
      height: 50,
      color: color,
      child: Text(
        colorString(color),
        style: TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
    {
      "widgetId": 177,
      "name": 'ReorderableListView滑动方向',
      "priority": 2,
      "subtitle": "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【reverse】 : 是否反向  【bool】",
      "code": """class DirectionReorderableListView extends StatefulWidget {
  @override
  _DirectionReorderableListViewState createState() => _DirectionReorderableListViewState();
}

class _DirectionReorderableListViewState extends State<DirectionReorderableListView> {
  var data = <Color>[
    Colors.yellow[50],
    Colors.yellow[100],
    Colors.yellow[200],
    Colors.yellow[300],
    Colors.yellow[400],
    Colors.yellow[500],
    Colors.yellow[600],
    Colors.yellow[700],
    Colors.yellow[800],
    Colors.yellow[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        reverse: false,
        onReorder: _handleReorder,
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    setState(() {
      final element = data.removeAt(oldIndex);
      data.insert(newIndex, element);
    });

  }

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color)  ,
      alignment: Alignment.center,
      width: 80,
      color: color,
      child: Text(
        colorString(color),
        style: TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "ExpansionPanelList": [
    {
      "widgetId": 178,
      "name": 'ExpansionPanelList基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【animationDuration】 : 动画时长   【Duration】\n"
          "【expansionCallback】 : 展开回调   【List<Widget>】\n"
          "【onPressed】 : 点击事件  【Function()】",
      "code": """class CustomExpansionPanelList extends StatefulWidget {
  @override
  _CustomExpansionPanelListState createState() =>
      _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  var data = <Color>[
    Colors.red[50],
    Colors.red[100],
    Colors.red[200],
    Colors.red[300],
    Colors.red[400],
    Colors.red[500],
    Colors.red[600],
    Colors.red[700],
    Colors.red[800],
    Colors.red[900],
  ];
  int _position = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ExpansionPanelList(
        children: data.map((color) => _buildItem(color)).toList(),
        animationDuration: Duration(milliseconds: 200),
        expansionCallback: (index, open) {
          setState(() => _position=open?-1:index);
        },
      ),
    );
  }

  ExpansionPanel _buildItem(Color color) {
    return ExpansionPanel(
        isExpanded: data.indexOf(color) == _position,
        canTapOnHeader: true,
        headerBuilder: (ctx, index) => Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                  Container(
                    width: 120,
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      colorString(color),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
        body: Container(
          alignment: Alignment.center,
          height: 50,
          color: color,
          child: Text(
            colorString(color),
            style: TextStyle(color: Colors.white, shadows: [
              Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
            ]),
          ),
        ));
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "ListWheelScrollView": [
    {
      "widgetId": 179,
      "name": 'ListWheelScrollView基本使用',
      "priority": 1,
      "subtitle": "【children】 : 子组件列表   【List<Widget>】\n"
          "【perspective】 : 透视度   【double】\n"
          "【itemExtent】 : item高   【EdgeInsets】\n"
          "【onSelectedItemChanged】 : 选中回调  【ValueChanged<int> 】",
      "code": """class CustomListWheelScrollView extends StatefulWidget {
  @override
  _CustomListWheelScrollViewState createState() => _CustomListWheelScrollViewState();
}

class _CustomListWheelScrollViewState extends State<CustomListWheelScrollView> {
  var data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCircle(),
        Container(
          height: 150,
          width: 300,
          child: ListWheelScrollView(
            perspective: 0.006,
            itemExtent: 50,
            onSelectedItemChanged: (index){
              print('onSelectedItemChanged:\$index');
              setState(() => _color=data[index]);
            },
            children: data.map((color) => _buildItem(color)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCircle() => Container(
        margin: EdgeInsets.only(bottom: 5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: _color,
          shape: BoxShape.circle
        ),
      );

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color)  ,
      alignment: Alignment.center,
      height: 50,
      color: color,
      child: Text(
        colorString(color),
        style: TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "ScrollConfiguration": [
    {
      "widgetId": 180,
      "name": 'ScrollConfiguration基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【behavior】 : 滑动行为  【ScrollBehavior】\n"
          "    可以使用ScrollConfiguration让ListView无蓝色阴影",
      "code": """class CustomScrollConfiguration extends StatelessWidget {
  final data = <Color>[
    Colors.cyan[50],
    Colors.cyan[100],
    Colors.cyan[200],
    Colors.cyan[300],
    Colors.cyan[400],
    Colors.cyan[500],
    Colors.cyan[600],
    Colors.cyan[700],
    Colors.cyan[800],
    Colors.cyan[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ScrollConfiguration(
          behavior: NoScrollBehavior(), child: _buildListView()),
    );
  }

  Widget _buildListView() => ListView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        children: data
            .map((color) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: color,
                  child: Text(
                    colorString(color),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ))
            .toList(),
      );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;
}"""
    },
  ],
  "DropdownButtonHideUnderline": [
    {
      "widgetId": 181,
      "name": 'DropDownButtonHideUnderline使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n",
      "code":
          """class CustomDropDownButtonHideUnderline extends StatefulWidget {
  @override
  _CustomDropDownButtonHideUnderlineState createState() =>
      _CustomDropDownButtonHideUnderlineState();
}

class _CustomDropDownButtonHideUnderlineState
    extends State<CustomDropDownButtonHideUnderline> {
  Color _color = Colors.red;
  final _colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  final _info = ["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<Color>(
              value: _color,
              elevation: 1,
              icon: Icon(
                Icons.expand_more,
                size: 20,
                color: _color,
              ),
              items: _buildItems(),
              onChanged: (v) => setState(() => _color = v)),
        ),
      ],
    );
  }

  List<DropdownMenuItem<Color>> _buildItems() => _colors
      .map((e) => DropdownMenuItem<Color>(
          value: e,
          child: Text(
            _info[_colors.indexOf(e)],
            style: TextStyle(color: e),
          )))
      .toList();
}"""
    },
  ],
  "Overlay": [
    {
      "widgetId": 182,
      "name": 'Overlay基本使用',
      "priority": 1,
      "subtitle": "    Overlay.of(context).insert插入全局组件",
      "code": """bool show = false;
Offset offset = Offset(200, 200);

final double radius = 60;
var entry = OverlayEntry(
    builder: (context) => Stack(
          children: <Widget>[
            Positioned(
              left: offset.dx,
              top: offset.dy,
              child: _buildFloating(),
            ),
          ],
        ));

///绘制悬浮控件
_buildFloating() => GestureDetector(
      onPanDown: (details) {
        offset = details.globalPosition - Offset(radius / 2, radius / 2);
        entry.markNeedsBuild();
      },
      onPanUpdate: (DragUpdateDetails details) {
        offset = offset + details.delta;
        entry.markNeedsBuild();
      },
      onLongPress: hideFloating,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: radius,
          width: radius,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/icon_head.png')),
          ),
        ),
      ));

showFloating(BuildContext context) {
  if (!show) {
    Overlay.of(context).insert(entry);
    show = true;
  }
}

hideFloating() {
  if (show) {
    entry.remove();
    show = false;
  }
}

class CustomOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          height: 50,
          child: RawMaterialButton(
            elevation: 2,
            shape: CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            fillColor: Colors.blue,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            child: Icon(Icons.add),
            onPressed: ()=>showFloating(context),
          ),
        ),
        Container(
          height: 50,
          child: RawMaterialButton(
            elevation: 2,
            shape: CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
            ),
            fillColor: Colors.red,
            splashColor: Colors.orange,
            textStyle: TextStyle(color: Colors.white),
            child: Icon(Icons.remove),
            onPressed: hideFloating,
          ),
        ),
      ],
    );
  }
}"""
    },
  ],
  "CustomScrollView": [
    {
      "widgetId": 183,
      "name": 'CustomScrollView基本使用',
      "priority": 1,
      "subtitle": "【slivers】 : 子组件列表   【List<Widget>】\n"
          "【reverse】 : 是否反向   【bool】\n"
          "【scrollDirection】 : 滑动方向   【Axis】\n"
          "【controller】 : 控制器   【ScrollController】",
      "code": """class CustomScrollViewDemo extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        anchor: 0,
        scrollDirection: Axis.vertical,
        reverse: false,
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverFixedExtentList()],
      ),
    );
  }

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
        itemExtent: 60,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: Container(
          margin: EdgeInsets.all(10),
          child: Image.asset('assets/images/icon_head.png')),
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        title: Text(
          '张风捷特烈',
          style: TextStyle(color: Colors.black, //标题
              shadows: [
                Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
              ]),
        ),
        background: Image.asset(
          "assets/images/caver.jpeg", fit: BoxFit.cover,
        ),
      ),
    );
  }
}"""
    },
  ],
  "SliverAppBar": [
    {
      "widgetId": 184,
      "name": 'SliverAppBar基本使用',
      "priority": 1,
      "subtitle": "【leading】 : 左侧组件   【Widget】\n"
          "【title】 : 中间组件   【Widget】\n"
          "【actions】 : 尾部组件列表   【List<Widget>】\n"
          "【floating】 : 是否浮动   【bool】\n"
          "【pinned】 : 是否顶部停留   【bool】\n"
          "【snap】 : 是否半收展   【bool】\n"
          "【bottom】 : 底部组件   【PreferredSizeWidget】\n"
          "【expandedHeight】 : 延展高度   【double】\n"
          "【elevation】 : 影深   【double】\n"
          "【flexibleSpace】 : 延展空间   【FlexibleSpaceBar】\n"
          "【backgroundColor】 : 背景色   【Color】\n"
          "【controller】 : 控制器   【ScrollController】\n"
          "   snap为true时必需floating为true",
      "code": """class SliverAppBarDemo extends StatefulWidget {
  @override
  _SliverAppBarDemoState createState() => _SliverAppBarDemoState();
}

class _SliverAppBarDemoState extends State<SliverAppBarDemo> {
  bool _floating = false;
  bool _pinned = false;
  bool _snap = false;

  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTool(),
        Container(
          height: 300,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildSliverAppBar(),
              _buildSliverFixedExtentList()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    print(_floating);
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      floating: _floating,
      pinned: _pinned,
      snap: _snap,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(//伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
        itemExtent: 60,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _buildTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('floating'),
            Switch(
                value: _floating,
                onChanged: (v) {
                  if(_snap&&!v){
                    _snap =false;
                  }
                  setState(() => _floating = v);
                }),
          ],
        ),
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('pinned'),
            Switch(
                value: _pinned,
                onChanged: (v) => setState(() => _pinned = v)),
          ],
        )       ,Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('snap'),
            Switch(
                value: _snap,
                onChanged: (v) {
                  if(_floating){
                    setState(() => _snap = v);
                  }

                }),
          ],
        )
      ],
    );
  }
}"""
    },
  ],
  "SliverList": [
    {
      "widgetId": 185,
      "name": 'SliverList基本使用',
      "priority": 1,
      "subtitle": "【delegate】 : 孩子代理   【SliverChildDelegate】",
      "code": """class SliverListDemo extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverList()],
      ),
    );
  }

  Widget _buildSliverList() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "SliverFixedExtentList": [
    {
      "widgetId": 186,
      "name": 'SliverFixedExtentList基本使用',
      "priority": 1,
      "subtitle": "【itemExtent】 : 主轴方向强迫长度   【double】\n"
          "【delegate】 : 孩子代理   【SliverChildDelegate】",
      "code": """class SliverFixedExtentListDemo extends StatelessWidget {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverList()],
      ),
    );
  }

  Widget _buildSliverList() => SliverFixedExtentList(
        itemExtent: 50,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "SliverFillViewport": [
    {
      "widgetId": 187,
      "name": 'SliverFillViewport基本使用',
      "priority": 1,
      "subtitle": "【viewportFraction】 : 视口分率   【double】\n"
          "【delegate】 : 孩子代理   【SliverChildDelegate】",
      "code": """class SliverFillViewportDemo extends StatefulWidget {
  @override
  _SliverFillViewportDemoState createState() => _SliverFillViewportDemoState();
}

class _SliverFillViewportDemoState extends State<SliverFillViewportDemo> {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
    Colors.orange[700],
    Colors.orange[800],
    Colors.orange[900],
  ];
  var _viewportFraction = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTool(),
        Container(
          height: 300,
          child: CustomScrollView(
            slivers: <Widget>[_buildSliverAppBar(), _buildSliverList()],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverList() => SliverFillViewport(
        viewportFraction: _viewportFraction,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  _buildTool() {
    return Slider(
        value: _viewportFraction,
        min: 0.01,
        divisions: 20,
        label: _viewportFraction.toStringAsFixed(1),
        max: 2.0,
        onChanged: (v) => setState(() => _viewportFraction = v));
  }
}"""
    },
  ],
  "SliverGird": [
    {
      "widgetId": 188,
      "name": 'SliverList基本使用',
      "priority": 1,
      "subtitle": "SliverGrid.count 指定轴向数量构造\n"
          "SliverGrid.extent 指定轴向长度构造\n"
          "属性特征同GridView,可详见之\n",
      "code": """class SliverGirdDemo extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF6600FF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverList()],
      ),
    );
  }

  Widget _buildSliverList() =>
      SliverGrid.extent(
        childAspectRatio: 1 / 0.618,
        maxCrossAxisExtent: 180,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: data
            .map((e) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          color: e,
          child: Text(
            colorString(e),
            style: TextStyle(color: Colors.white, shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ))
            .toList(),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "SliverToBoxAdapter": [
    {
      "widgetId": 189,
      "name": 'SliverToBoxAdapter基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】",
      "code": """class SliverToBoxAdapterDemo extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildCommonWidget(),
          _buildSliverList()
        ],
      ),
    );
  }

  Widget _buildCommonWidget() => SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey.withAlpha(22),
          child: ListTile(
            leading: Image.asset("assets/images/icon_head.png"),
            title: Text("以梦为马"),
            subtitle: Text("海子"),
            selected: true,
            contentPadding: EdgeInsets.all(5),
            trailing: Icon(Icons.more_vert),
          ),
        ),
      );

  Widget _buildSliverList() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 2,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "SliverPersistentHeader": [
    {
      "widgetId": 190,
      "name": 'SliverPersistentHeader基本使用',
      "priority": 1,
      "subtitle": "【delegate】 : 代理   【SliverPersistentHeaderDelegate】\n"
          "【floating】 : 是否浮动   【bool】\n"
          "【pinned】 : 是否顶部停留   【bool】",
      "code": """class SliverPersistentHeaderDemo extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildPersistentHeader('袅缈岁月，青丝银发',Color(0xffe7fcc9)),
          _buildCommonWidget(),
          _buildPersistentHeader('以梦为马，不负韶华',Color(0xffcca4ff)),
          _buildSliverList()
        ],
      ),
    );
  }

  Widget _buildCommonWidget() => SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.png"),
        title: Text("以梦为马"),
        subtitle: Text("海子"),
        selected: true,
        contentPadding: EdgeInsets.all(5),
        trailing: Icon(Icons.more_vert),
      ),
    ),
  );
  Widget _buildPersistentHeader(String text,Color color) => SliverPersistentHeader(
    pinned: true,
    delegate: _SliverDelegate(
        minHeight: 40.0,
        maxHeight: 100.0,
        child: Container(
          color: color,
          child: Center(
            child: Text(text, style: TextStyle(
                fontSize: 18,
                shadows: [Shadow(color: Colors.white, offset: Offset(1, 1))]),
          ),
        )),
  ));

  Widget _buildSliverList() => SliverList(
    delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          color: data[index],
          child: Text(
            colorString(data[index]),
            style: TextStyle(color: Colors.white, shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ),
        childCount: data.length),
  );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 2,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.star_border,
        color: Colors.white,
      ),
    )
  ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}


class _SliverDelegate extends SliverPersistentHeaderDelegate {
  _SliverDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child; //孩子

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override //是否需要重建
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}"""
    },
  ],
  "SliverPadding": [
    {
      "widgetId": 191,
      "name": 'SliverPadding基本使用',
      "priority": 1,
      "subtitle": "【sliver】 : 子组件   【Widget】\n"
          "【padding】 : 内边距  【EdgeInsetsGeometry】",
      "code": """class SliverPaddingDemo extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF6600FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), SliverPadding(
            padding: EdgeInsets.only(top: 10),
            sliver
            : _buildSliverGrid())],
      ),
    );
  }

  Widget _buildSliverGrid() => SliverGrid.extent(
    childAspectRatio: 1 / 0.618,
    maxCrossAxisExtent: 180,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    children: data
        .map((e) => Container(
      alignment: Alignment.center,
      width: 100,
      height: 60,
      color: e,
      child: Text(
        colorString(e),
        style: TextStyle(color: Colors.white, shadows: [
          Shadow(
              color: Colors.black,
              offset: Offset(.5, .5),
              blurRadius: 2)
        ]),
      ),
    ))
        .toList(),
  );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.star_border,
        color: Colors.white,
      ),
    )
  ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "SliverOpacity": [
    {
      "widgetId": 192,
      "name": 'SliverOpacity基本使用',
      "priority": 1,
      "subtitle": "【opacity】 : 透明度   【double】\n"
          "【sliver】 : 子组件  【Function()】",
      "code": """class SliverOpacityDemo extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF6600FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          SliverPadding(
              padding: EdgeInsets.only(top: 10),
              sliver: SliverOpacity(opacity: 0.2, sliver: _buildSliverGrid()))
        ],
      ),
    );
  }

  Widget _buildSliverGrid() => SliverGrid.extent(
        childAspectRatio: 1 / 0.618,
        maxCrossAxisExtent: 180,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: data
            .map((e) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: e,
                  child: Text(
                    colorString(e),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ))
            .toList(),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "AboutListTile": [
    {
      "widgetId": 193,
      "name": 'AboutListTile基本使用',
      "priority": 1,
      "subtitle": "【icon】 : 左图标   【Widget】\n"
          "【applicationIcon】 : 左上图标   【Widget】\n"
          "【applicationVersion】 : 版本号  【String】\n"
          "【applicationName】 : 应用名  【String】\n"
          "【applicationLegalese】 : 应用律术   【String】\n"
          "【aboutBoxChildren】 : 弹框内容组件   【List<Widget>】",
      "code": """class AboutListTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      icon: Icon(Icons.info),
      applicationIcon: FlutterLogo(),
      applicationName: 'Flutter Unit',
      applicationVersion: 'v0.0.1',
      applicationLegalese: 'Copyright© 2018-2020 张风捷特烈',
      aboutBoxChildren: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '      FlutterUnit是【张风捷特烈】的开源项目，'
            '收录Flutter的200+组件，并附加详细介绍以及操作交互，'
            '希望帮助广大编程爱好者入门Flutter。'
            '更多知识可以关注掘金账号、公众号【编程之王】。',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}"""
    },
  ],
  "Scrollbar": [
    {
      "widgetId": 194,
      "name": 'Scrollbar基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【controller】 : 控制器  【ScrollController】",
      "code": """class CustomScrollbar extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Scrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          children: data
              .map((color) => Container(
            alignment: Alignment.center,
            width: 100,
            height: 50,
            color: color,
            child: Text(
              colorString(color),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(.5, .5),
                    blurRadius: 2)
              ]),
            ),
          ))
              .toList(),
        ),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "CupertinoScrollbar": [
    {
      "widgetId": 195,
      "name": 'CupertinoScrollbar基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【controller】 : 控制器  【ScrollController】",
      "code": """class CustomCupertinoScrollbar extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoScrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          children: data
              .map((color) => Container(
            alignment: Alignment.center,
            width: 100,
            height: 50,
            color: color,
            child: Text(
              colorString(color),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(.5, .5),
                    blurRadius: 2)
              ]),
            ),
          ))
              .toList(),
        ),
      ),
    );
  }

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "FlexibleSpaceBar": [
    {
      "widgetId": 196,
      "name": 'SliverAppBar基本使用',
      "priority": 1,
      "subtitle": "【title】 : 标题组件   【Widget】\n"
          "【titlePadding】 : 标题间距   【EdgeInsetsGeometry】\n"
          "【collapseMode】 : 折叠模式   【CollapseMode】\n"
          "【stretchModes】 : 延伸模式   【List<StretchMode>】\n"
          "【background】 : 背景组件   【Widget】\n"
          "【centerTitle】 : 是否居中   【bool】",
      "code": """class FlexibleSpaceBarDemo extends StatelessWidget {

  final data = <Color>[
    Colors.blue[50],
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.blue[700],
    Colors.blue[800],
    Colors.blue[900],
  ];

  @override
  Widget build(BuildContext context) {
    return
        Container(
          height: 300,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildSliverAppBar(),
              _buildSliverFixedExtentList()
            ],
          ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      actions: _buildActions(),
      pinned: true,
      backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(//伸展处布局
        centerTitle: false,
        title: Text('张风捷特烈',style: TextStyle(shadows: [
          Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
        ]),),
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        stretchModes: [StretchMode.blurBackground,StretchMode.zoomBackground],
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
    IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.star_border,
        color: Colors.white,
      ),
    )
  ];

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
    itemExtent: 60,
    delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 50,
          color: data[index],
          child: Text(
            colorString(data[index]),
            style: TextStyle(color: Colors.white, shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ),
        childCount: data.length),
  );

  String colorString(Color color) =>
      "#\${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}"""
    },
  ],
  "ErrorWidget": [
    {
      "widgetId": 197,
      "name": 'ErrorWidget基本使用',
      "priority": 1,
      "subtitle": "入参 : 显示信息   【Object】",
      "code": """class ErrorWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ErrorWidget(
          'I am Error ErrorWidget\n'
              'But now, there has no error.'
      ),
    );
  }
}"""
    },
  ],
  "Form": [
    {
      "widgetId": 198,
      "name": 'Form基本使用',
      "priority": 1,
      "subtitle": "【child】 : 子组件   【Widget】\n"
          "【onChanged】 : 表单变化回调   【VoidCallback】\n"
          "【onWillPop】 : 返回回调  【WillPopCallback】",
      "code": """class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        onWillPop: () => _willPop(context),
        key: _formKey,
        onChanged: () {
          print('Form---onChanged');
        },
        child:
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
                  width: 350,
                  child: UnconstrainedBox(
                    child: Container(
                      width: 200,
                      height: 70,
                      child: TextFormField(
                        style: TextStyle(textBaseline: TextBaseline.alphabetic),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                        ),
                        validator: _validateUsername,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0, right: 0, child: _buildSubmitButton(context)),
              ],
        ),
      ),
    );
  }

  String _validateUsername(value) {
    if (value.isEmpty) {
      return '用户名不能为空';
    }
    return null;
  }

  RaisedButton _buildSubmitButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      shape: CircleBorder(
        side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
      ),
      onPressed: _onSubmit,
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  _onSubmit(){
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pop();
    }
  }

  Future<bool> _willPop(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Text('提示'),
            content: Text('你确定要离开此页吗?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('确定'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消'),
              ),
            ],
          ),
        ) ??
        false;
  }
}"""
    },
  ],
  "TextFormField": [
    {
      "widgetId": 199,
      "name": 'TextFormField基本使用',
      "priority": 1,
      "subtitle": "    基本属性和TextField一致，详见之\n"
          "【validator】 : 验证函数   【FormFieldValidator<String> 】\n"
          "【onFieldSubmitted】 : 提交回调   【ValueChanged<String>】\n"
          "【onSaved】 : 表单save时回调  【FormFieldSetter<String>】",
      "code": """class CustomTextFormField extends StatefulWidget {
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child:
        Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            Container(
              width: 350,
              child: UnconstrainedBox(
                child: Container(
                  width: 200,
                  height: 70,
                  child: TextFormField(
                    style: TextStyle(textBaseline: TextBaseline.alphabetic),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'username',
                    ),
                    validator: _validateUsername,
                    onFieldSubmitted: _onFieldSubmitted,
                    onSaved: _onSaved,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0, right: 0, child: _buildSubmitButton(context)),
          ],
        ),
      ),
    );
  }

  String _validateUsername(value) {
    if (value.isEmpty) {
      return '用户名不能为空';
    }
    return null;
  }
  _onSaved(value){
    print('onSaved:'+value);
  }

  void _onFieldSubmitted(value) {
    print('onFieldSubmitted:'+value);
  }

  RaisedButton _buildSubmitButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      shape: CircleBorder(
        side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
      ),
      onPressed: _onSubmit,
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  _onSubmit(){
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}"""
    },
  ],
  "Stepper": [
    {
      "widgetId": 200,
      "name": 'Stepper基本使用',
      "priority": 1,
      "subtitle": "【steps】 : 步骤列表   【List<Step>】\n"
          "【currentStep】 : 当前步骤   【double】\n"
          "【onStepTapped】 : 点击回调   【ValueChanged<int>】\n"
          "【onStepCancel】 : 上一步回调  【VoidCallback】\n"
          "【controlsBuilder】 : 控制器构造  【ControlsWidgetBuilder】",
      "code": """class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _position = 0;

  final stepsData = {
    "填写表单":'请按表单填写个人信息。',
    "邮箱校验":'已将邮件发送至您的邮箱，请按照相关指示对您的账号进行邮箱校验。',
    "注册完成":'恭喜您，注册完成！',
  };

  final steps = [
    Step(
      title: Text("填写表单"),
      content: Container(height: 60, child: Text("请按表单填写个人信息")),
    ),
    Step(title: Text("邮箱校验"), content: Text("请对您的账号进行邮箱校验")),
    Step(title: Text("注册完成"), content: Text("恭喜您，注册完成")),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stepper(
          type:StepperType.horizontal,
          currentStep: _position,
          onStepTapped: (index) {
            setState(() {
              _position = index;
            });
          },
          onStepContinue: () {
            setState(() {
              if (_position < 2) {
                _position++;
              }
            });
          },
          onStepCancel: () {
            if (_position > 0) {
              setState(() {
                _position--;
              });
            }
          },
          controlsBuilder: (_,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: CircleBorder(
                    side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  onPressed: onStepContinue,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: CircleBorder(
                    side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  onPressed: onStepCancel,
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
          steps: stepsData.keys.map((e){
            bool isActive = stepsData.keys.toList().indexOf(e) ==_position;
            return Step(
            title: Text(e,style: TextStyle(color: isActive?Colors.blue:Colors.black),),
            isActive: isActive,
            state: _getState(stepsData.keys.toList().indexOf(e)),
            content: Container(height: 60, child: Text(stepsData[e])),
          );
          }).toList()),
    );
  }
  _getState(index){
    if(_position==index) return StepState.editing;
    if(_position>index) return StepState.complete;
    return StepState.indexed;
  }
}"""
    },
    {
      "widgetId": 200,
      "name": 'Stepper的方向',
      "priority": 2,
      "subtitle": "【type】 : 方向   【StepperType】",
      "code": """class VerticalStepper extends StatefulWidget {
  @override
  _VerticalStepperState createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  int _position = 0;

  final stepsData = {
    "填写表单":'请按表单填写个人信息。',
    "邮箱校验":'已将邮件发送至您的邮箱，请按照相关指示对您的账号进行邮箱校验。',
    "注册完成":'恭喜您，注册完成！',
  };

  final steps = [
    Step(
      title: Text("填写表单"),
      content: Container(height: 60, child: Text("请按表单填写个人信息")),
    ),
    Step(title: Text("邮箱校验"), content: Text("请对您的账号进行邮箱校验")),
    Step(title: Text("注册完成"), content: Text("恭喜您，注册完成")),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
          type:StepperType.vertical,
          currentStep: _position,
          onStepTapped: (index) {
            setState(() {
              _position = index;
            });
          },
          onStepContinue: () {
            setState(() {
              if (_position < 2) {
                _position++;
              }
            });
          },
          onStepCancel: () {
            if (_position > 0) {
              setState(() {
                _position--;
              });
            }
          },
          controlsBuilder: (_,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: CircleBorder(
                    side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  onPressed: onStepContinue,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: CircleBorder(
                    side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  onPressed: onStepCancel,
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
          steps: stepsData.keys.map((e){
            bool isActive = stepsData.keys.toList().indexOf(e) ==_position;
            return Step(
              title: Text(e,style: TextStyle(color: isActive?Colors.blue:Colors.black),),
              isActive: isActive,
              state: _getState(stepsData.keys.toList().indexOf(e)),
              content: Container(height: 60, child: Text(stepsData[e])),
            );
          }).toList()),
    );
  }
  _getState(index){
    if(_position==index) return StepState.editing;
    if(_position>index) return StepState.complete;
    return StepState.indexed;
  }
}"""
    },
  ],
  "AnimatedSize": [
    {"widgetId": 201,
      "name": 'AnimatedAlign基本使用',
      "priority": 1,
      "subtitle":
      "【child】 : 孩子组件   【Widget】\n"
          "【duration】 : 动画时长   【Duration】\n"
          "【alignment】 : 对齐方式   【AlignmentGeometry】\n"
          "【curve】 : 动画曲线   【Duration】\n"
          "【vsync】 : vsync   【TickerProvider】",
      "code": """class CustomAnimatedSize extends StatefulWidget {
  @override
  _CustomAnimatedSizeState createState() => _CustomAnimatedSizeState();
}

class _CustomAnimatedSizeState extends State<CustomAnimatedSize>
    with SingleTickerProviderStateMixin {
  final double start = 100;
  final double end = 200;

  double _width;

  @override
  void initState() {
    _width = start;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          alignment: Alignment.center,
          child: AnimatedSize(
            vsync: this,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: Alignment(0, 0),
            child: Container(
              height: 40,
              width: _width,
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
      value: _width == end,
      onChanged: (v) {
        setState(() {
          _width = v ? end : start;
        });
      });
}"""},
  ],
};
