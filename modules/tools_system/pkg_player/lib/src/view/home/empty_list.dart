import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  final RefreshCallback onRefresh;

  const EmptyListView({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: Center(child: Text('暂无数据')),
        ),
      ),
    );
  }
}
