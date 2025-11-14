import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

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
        color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold);
    TextStyle subStyle = TextStyle(fontSize: 12, color: Color(0xff6d7278));
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  plugin.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              SizedBox(width: 12),
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
              SizedBox(width: 12),
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
          SizedBox(height: 8),
          Text(
            plugin.desc ?? '',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(text: 'v ', style: TextStyle(fontSize: 10)),
                TextSpan(
                    text: plugin.lastVersion,
                    style: TextStyle(color: Colors.blue[700], fontSize: 12)),
                TextSpan(
                    text: ' (${_formatDate(plugin.lastPublish)})',
                    style: TextStyle(fontSize: 12)),
              ])),
              SizedBox(width: 4),
              Icon(Icons.person, size: 14, color: Colors.grey[500]),
              SizedBox(width: 4),
              Text(
                plugin.publisher ?? '',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              Spacer(),
              if (plugin.lastPublish.isNotEmpty) ...[
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey[400]),
                    SizedBox(width: 4),
                    Text(
                      '更新: ${_formatDate(plugin.lastPublish)}',
                      style: TextStyle(color: Colors.grey[400], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ],
          ),
          if (plugin.tags.isNotEmpty) ...[
            SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: plugin.tags
                  .take(3)
                  .map((tag) => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[700]),
                        ),
                      ))
                  .toList(),
            ),
          ]
        ],
      ),
    );
  }
}
