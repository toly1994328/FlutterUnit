import 'package:flutter/material.dart';

class ListViewDemo01 extends StatelessWidget {
  const ListViewDemo01({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: 100,
          itemBuilder: (_, index) {
            return Card(
                child: ListTile(
              tileColor: Colors.transparent,
              title: Text('Test index:$index'),
            ));
          }),
    );
  }
}
