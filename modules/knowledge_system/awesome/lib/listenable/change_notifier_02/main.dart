
import 'package:flutter/material.dart';

import 'notifier/download_data_scope.dart';
import 'notifier/progress_value_notifier.dart';
import 'page/home/home_page.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DownloadDataScope(
      notifier: ProgressValueNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ChangeNotifierHome02(),
      ),
    );
  }
}







