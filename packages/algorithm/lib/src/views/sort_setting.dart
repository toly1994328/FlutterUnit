import 'package:flutter/material.dart';

import '../../algorithm.dart';
class SortSettings extends StatefulWidget {

  const SortSettings({super.key,});

  @override
  State<SortSettings> createState() => _SortSettingsState();
}

class _SortSettingsState extends State<SortSettings> {
  late TextEditingController _count =
      TextEditingController();
  late TextEditingController _duration = TextEditingController();
  late TextEditingController _seed =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SortState state = SortStateScope.of(context);
    _count.text = state.config.count.toString();
    _duration.text = state.config.duration.inMicroseconds.toString();
    _seed.text = state.config.seed.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(),
        actions: [
          IconButton(onPressed: (){
            SortState state = SortStateScope.of(context);
            state.config =state.config.copyWith(
                count:  int.parse(_count.text),
                duration: Duration(
                  microseconds: int.parse(_duration.text),
                ),
                seed: int.parse(_seed.text)
            );
            Navigator.of(context).pop();
          }, icon: Icon(Icons.check))],
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        title: Text('排序算法配置'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('数据数量(个数):'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                  controller: _count,
                )),
              ],
            ),
            Row(
              children: [
                Text('时间间隔(微秒):'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                  controller: _duration,
                )),
              ],
            ),
            Row(
              children: [
                Text('随机种子:'),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextField(
                  controller: _seed,
                )),
              ],
            ),
            Spacer(),
            // ElevatedButton(
            //     onPressed: () {
            //       SortState state = SortStateScope.of(context);
            //       state.config =state.config.copyWith(
            //         count:  int.parse(_count.text),
            //         duration: Duration(
            //           microseconds: int.parse(_duration.text),
            //         ),
            //         seed: int.parse(_seed.text)
            //       );
            //       Navigator.of(context).pop();
            //     },
            //     child: Text('确定设置'))
          ],
        ),
      ),
    );
  }
}
