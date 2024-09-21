import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com

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
