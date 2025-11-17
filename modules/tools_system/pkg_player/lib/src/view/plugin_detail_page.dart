import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

import 'detail/detail_flexible_bar.dart';

class PluginDetailPage extends StatefulWidget {
  final PluginModel plugin;

  const PluginDetailPage({Key? key, required this.plugin}) : super(key: key);

  @override
  _PluginDetailPageState createState() => _PluginDetailPageState();
}

class _PluginDetailPageState extends State<PluginDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: getDetailGradientColors(widget.plugin.name)[0],
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 16, top: 8),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: GestureDetector(
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PluginCardPage(plugin: widget.plugin),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0.0, 1.0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            )),
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 400),
                      ),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: DetailFlexibleBar(
              desc: widget.plugin.desc??'',
              name: widget.plugin.name,
              version: widget.plugin.lastVersion,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildInfo(context),

                  SizedBox(height: 16),
                  _buildDependencies(context),
                  SizedBox(height: 16),
                  _buildTags(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(widget.plugin.desc?.trim() ?? '暂无描述',
        style: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: Color(0xff999999)
        ));
  }

  Widget _buildStatistics(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
              child: _buildStatItem('喜欢人数', widget.plugin.statistics.likes,
                  Icons.favorite, Colors.red)),
          Expanded(
              child: _buildStatItem('插件分数', widget.plugin.statistics.points,
                  Icons.bar_chart, Colors.orange)),
          Expanded(
              child: _buildStatItem(
                  '30 日下载量',
                  widget.plugin.statistics.downloads,
                  Icons.download,
                  Colors.green)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 6),
        Text(
          _formatNumber(value),
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 2),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildTags(BuildContext context) {
    if (widget.plugin.tags.isEmpty) return SizedBox.shrink();

    final categorizedTags = _categorizeTags(widget.plugin.tags);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.label, color: Theme.of(context).primaryColor, size: 20),
            SizedBox(width: 8),
            Text('标签',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categorizedTags.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: entry.key == categorizedTags.keys.last ? 0 : 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getCategoryDisplayName(entry.key),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: entry.value
                          .map((tag) => Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(entry.key)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _getCategoryColor(entry.key)
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  _removeTagPrefix(tag),
                                  style: TextStyle(
                                    height: 1,
                                    color: _getCategoryColor(entry.key),
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Map<String, List<String>> _categorizeTags(List<String> tags) {
    final Map<String, List<String>> categorized = {};

    for (String tag in tags) {
      String category = 'other';

      if (tag.startsWith('platform:')) {
        category = 'platform';
      } else if (tag.startsWith('sdk:')) {
        category = 'sdk';
      } else if (tag.startsWith('is:')) {
        category = 'is';
      } else if (tag.startsWith('topic:')) {
        category = 'topic';
      } else if (tag.startsWith('license:')) {
        category = 'license';
      }

      categorized.putIfAbsent(category, () => []);
      categorized[category]!.add(tag);
    }

    // Return ordered map
    final orderedCategories = [
      'sdk',
      'platform',
      'is',
      'license',
      'topic',
      'other'
    ];
    final Map<String, List<String>> orderedMap = {};

    for (String category in orderedCategories) {
      if (categorized.containsKey(category)) {
        orderedMap[category] = categorized[category]!;
      }
    }

    return orderedMap;
  }

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'platform':
        return '平台';
      case 'sdk':
        return 'SDK';
      case 'is':
        return '类型';
      case 'topic':
        return '主题';
      case 'license':
        return '许可证';
      case 'other':
        return '其他';
      default:
        return category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'platform':
        return Colors.blue;
      case 'sdk':
        return Colors.green;
      case 'is':
        return Colors.orange;
      case 'topic':
        return Colors.purple;
      case 'license':
        return Colors.teal;
      case 'other':
        return Colors.grey;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  String _removeTagPrefix(String tag) {
    if (tag.contains(':')) {
      return tag.split(':').last;
    }
    return tag;
  }

  Widget _buildDependencies(BuildContext context) {
    if (widget.plugin.dependencies == null ||
        widget.plugin.dependencies!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree,
                color: Theme.of(context).primaryColor, size: 20),
            SizedBox(width: 8),
            Text('依赖关系',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.plugin.dependencies!.entries.map((entry) {
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade50, Colors.blue.shade100],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.2),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    entry.value.toString(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.plugin.publisher?.isNotEmpty == true)
                _buildInfoRow(Icons.person, '发布者', widget.plugin.publisher!),
              if (widget.plugin.homepage?.isNotEmpty == true)
                _buildInfoRow(Icons.home, '主页', widget.plugin.homepage!),
              if (widget.plugin.repository?.isNotEmpty == true)
                _buildInfoRow(Icons.code, '仓库', widget.plugin.repository!),
              _buildInfoRow(Icons.schedule, '最后发布',
                  _formatDate(widget.plugin.lastPublish)),
              SizedBox(height: 4),
Divider(),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: _buildStatItem('喜欢人数', widget.plugin.statistics.likes,
                          Icons.favorite, Colors.red)),
                  Expanded(
                      child: _buildStatItem('插件分数', widget.plugin.statistics.points,
                          Icons.bar_chart, Colors.orange)),
                  Expanded(
                      child: _buildStatItem(
                          '30 日下载量',
                          widget.plugin.statistics.downloads,
                          Icons.download,
                          Colors.green)),
                ],
              )
            ],
          ),
        ),

      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Text('$label:',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey[700])),
          SizedBox(width: 8),
          Expanded(
              child: Text(value, style: TextStyle(color: Colors.grey[800]))),
        ],
      ),
    );
  }

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
}
