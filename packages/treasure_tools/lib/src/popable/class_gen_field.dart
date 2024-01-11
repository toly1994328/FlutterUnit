import 'package:flutter/material.dart';

import '../code_gen_page.dart';
import '../model/class.dart';
import '../model/field.dart';
import 'toly_select.dart';

class ClassGenField extends StatelessWidget {

  final Class clazz;

  const ClassGenField({Key? key,required this.clazz}) : super(key: key);

  final List<String> selectData = const [
    "final",
    "static",
    'static const',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GenInput(
              label: '类名',
              // controller: clazz.nameCtrl,
              hintText: '输入类名',
            ),
            const SizedBox(
              width: 20,
            ),
            Wrap(
              spacing: 20,
              children: [
                GenCheckBox(
                  label: 'toJson', checked: true,onChanged: (v){},
                ),
                GenCheckBox(
                  label: 'fromJson', checked: true,onChanged: (v){},
                ),
                GenCheckBox(
                  label: 'copyWith', checked: true,onChanged: (v){},
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
              itemCount: clazz.fields.length,
              separatorBuilder: (_,__)=> const SizedBox(height: 10,),
              itemBuilder: (_,index) {
                Field field = clazz.fields[index];
                return Row(
            children: [
              GenInput(
                label: '类型',
                // controller: field.typeCtrl,
                hintText: '输入字段类型名',
              ),
              const SizedBox(
                width: 20,
              ),
              GenInput(
                label: '变量名',
                // controller: field.nameCtrl,
                hintText: '输入字段变量名',
              ),
              const SizedBox(
                width: 20,
              ),
              Wrap(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: const Text('修饰',style: TextStyle(fontSize: 12),),
                  ),
                  TolySelect(
                    height: 30,
                    width: 120,
                    change: (int index){
                      // field.typeCtrl.text = selectData[index];
                      },
                    activeIndex: selectData.indexOf(field.modifier)==-1?0:selectData.indexOf(field.modifier),
                    data: selectData,
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),

              GenCheckBox(
                label: 'nullable', checked: field.nullable,onChanged: (v){},
              ),

            ],
          );
              }),
        )
       ,
      ],
    );
  }
}
