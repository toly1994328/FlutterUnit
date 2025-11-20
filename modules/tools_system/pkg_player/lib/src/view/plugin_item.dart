import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';

import '../bloc/comments/comments_cubit.dart';

class PluginItem extends StatelessWidget {
  final PluginModel plugin;

  const PluginItem({Key? key, required this.plugin}) : super(key: key);

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final diff = now.difference(date).inDays;

      if (diff == 0) return '今天';
      if (diff == 1) return '昨天';
      if (diff < 30) return '${diff}天前';
      if (diff < 365) return '${(diff / 30).floor()}个月前';
      return '${(diff / 365).floor()}年前';
    } catch (e) {
      return dateStr;
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 12);
    Color subColor = Color(0xff6d7278);
    TextStyle subStyle = TextStyle(fontSize: 10, color: subColor);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    CommentsCubit(PackageRequest(), plugin.id!)..loadComments(),
                child: PluginDetailPage(plugin: plugin)),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Stack(
          children: [
            if (plugin.isFavorite)
              Positioned(
                top: 40,
                right: 0,
                width: 50,
                height: 50,
                child: Image.asset(
                  width: 50,
                  height: 50,
                  'assets/images/flutter_favorite.webp',
                  package: 'pkg_player',
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plugin.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text: 'v ', style: TextStyle(fontSize: 10)),
                                TextSpan(
                                    text: plugin.lastVersion,
                                    style: TextStyle(
                                        color: Colors.blue[700], fontSize: 12)),
                                TextSpan(
                                    text:
                                        ' (${_formatDate(plugin.lastPublish)})',
                                    style: TextStyle(
                                        fontSize: 12, color: subColor)),
                              ])),
                              SizedBox(width: 4),
                              Icon(Icons.verified_outlined,
                                  size: 14, color: Colors.grey[500]),
                              SizedBox(width: 4),
                              Text(
                                plugin.publisher ?? '',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text('${_formatNumber(plugin.statistics.likes)}',
                            style: style),
                        Text(
                          '喜欢',
                          style: subStyle,
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                    Column(
                      children: [
                        Text('${_formatNumber(plugin.statistics.points)}',
                            style: style),
                        Text(
                          '分数',
                          style: subStyle,
                        ),
                      ],
                    ),
                    SizedBox(width: 8),
                    Column(
                      children: [
                        Text('${_formatNumber(plugin.statistics.downloads)}',
                            style: style),
                        Text(
                          '下载量',
                          style: subStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
                if (plugin.tags.isNotEmpty) ...[
                  PackageTagsView(
                    type: 'Platform',
                    platforms: plugin.platforms
                        .map((e) => e.replaceAll('platform:', ''))
                        .toList(),
                  ),
                  SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: [
                      PackageTagsView(
                        type: 'sdk',
                        platforms: plugin.sdks
                            .map((e) => e.replaceAll('sdk:', ''))
                            .toList(),
                      ),
                      PackageTagsView(
                        type: 'license',
                        platforms: plugin.license
                            .map((e) => e.replaceAll('license:', ''))
                            .toList(),
                      ),
                    ],
                  )
                ],
                SizedBox(height: 6),
                Text(
                  plugin.desc ?? '',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PackageTagsView extends StatelessWidget {
  final List<String> platforms;
  final String type;

  const PackageTagsView({
    super.key,
    required this.platforms,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    return Container(
      color: themeColor.withValues(alpha: 0.1),
      padding: EdgeInsets.only(right: 4),
      child: Wrap(
        spacing: 6,
        children: [
          Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    // color: themeColor.withValues(alpha: 0.1),
                    border: Border(
                        right: BorderSide(
                            color: themeColor.withValues(alpha: 0.5)))),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Text(
                  type.toUpperCase(),
                  style: TextStyle(fontSize: 10, height: 1),
                ),
              ),
            ],
          ),
          ...platforms.map(
            (e) => Container(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              child: Text(
                e.toLowerCase(),
                style: TextStyle(fontSize: 10, height: 1, color: themeColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
