import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com
/// 说明:  320 DefaultAssetBundle 默认资源包
/// 一个 InheritedWidget，设置 AssetBundle 对象后，该节点后的节点上下文可以通过 DefaultAssetBundle.of(context) 获取 AssetBundle 对象用于访问资源文件。
//    {
//      "widgetId": 320,
//      "name": 'DefaultAssetBundle 介绍',
//      "priority": 1,
//      "subtitle": "【bundle】 : *资源包   【AssetBundle】\n"
//          "【child】 : *子组件  【Widget】\n"
//          "我们可以定义自己的 DefaultAssetBundle 来供后续节点使用，也可以直接使用默认的。该案例演示通过框架提供的 DefaultAssetBundle 加载一张资源图片进行显示。",
//    }
class DefaultAssetBundleDemo extends StatefulWidget {
  const DefaultAssetBundleDemo({Key? key}) : super(key: key);

  @override
  _DefaultAssetBundleDemoState createState() => _DefaultAssetBundleDemoState();
}

class _DefaultAssetBundleDemoState extends State<DefaultAssetBundleDemo> {
 ui.Image? _image;
  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 150,
      height: 150,
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: _image==null?Container():RawImage(image: _image,fit: BoxFit.cover,),
    );
  }

  void _load() async{
    AssetBundle info = DefaultAssetBundle.of(context);
    ByteData data = await info.load('assets/images/sabar.webp');
    _image = await decodeImageFromList(data.buffer.asUint8List());
    setState(() {

    });
  }
}
