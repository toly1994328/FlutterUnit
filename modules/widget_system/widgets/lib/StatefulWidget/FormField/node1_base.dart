import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com

class FormFieldDemo extends StatelessWidget {
  const FormFieldDemo({Key? key}) : super(key: key);

  final String info =
      'FormField 代表表单中的一个字段，对于字符串类型的字段，框架中封装了 TextFormField 以便使用；下拉选择的字段，用 DropdownButtonFormField。'
      '目前框架中 FormField 的子类也只有这两个。既然是表单字段，必然是要和 Form 组件一起使用。通过对 Form 添加 GlobalKey ，来获取 FormState 对象。'
      '当 FormState 调用 save 方法时，所有的 FormField 都会触发 onSave 方法，当 FormState 调用 validate 方法时，所有的 FormField 都会触发 validate 方法。';


  @override
  Widget build(BuildContext context) {

    
    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }
}
