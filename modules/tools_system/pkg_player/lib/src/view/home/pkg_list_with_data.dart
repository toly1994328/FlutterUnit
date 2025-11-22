import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart';

import '../../../pkg_player.dart';
import 'plugin_item.dart';

bool kIsDeskTop =
    kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;

class PkgListWithData extends StatelessWidget {
  final List<PluginModel> packages;
  final RefreshController controller;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final bool hasMore;

  const PkgListWithData({
    super.key,
    required this.packages,
    required this.controller,
    this.onRefresh,
    this.hasMore = true,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    Color? tiledColor = Theme.of(context).listTileTheme.tileColor;
    PkgL10n l10n = context.pkgL10n;
    return TolyRefresh(
      onRefresh: onRefresh,
      enablePullUp: hasMore,
      onLoading: onLoading,
      controller: controller,
      footer: kIsDeskTop
          ? SliverToBoxAdapter(
              child: GestureDetector(
                onTap: onLoading,
                child: Center(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text(
                    '加载更多(10)',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                )),
              ),
            )
          : null,
      child: ListView.separated(
        separatorBuilder: (_, __) => Divider(),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          return PluginItem(
            l10n: l10n,
            plugin: packages[index],
            tiledColor: tiledColor,
          );
        },
      ),
    );
  }
}
