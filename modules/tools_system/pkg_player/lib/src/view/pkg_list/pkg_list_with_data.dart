import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart';

import '../../../pkg_player.dart';
import '../plugin_item.dart';

class PkgListWithData extends StatelessWidget {
  final List<PluginModel> packages;
  final RefreshController controller;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;

  const PkgListWithData({
    super.key,
    required this.packages,
    required this.controller,
    this.onRefresh,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return TolyRefresh(
      onRefresh: onRefresh,
      enablePullUp: true,
      onLoading: onLoading,
      controller: controller,
      child: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          return PluginItem(plugin: packages[index]);
        },
      ),
    );
  }
}
