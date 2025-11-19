import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PluginTags extends StatelessWidget {
  final List<String> tags;
  const PluginTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    final categorizedTags = _categorizeTags(tags);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('标签一览',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 12,
            ),
            ...categorizedTags.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: entry.key == categorizedTags.keys.last ? 0 : 10),
                child: Wrap(spacing: 4, runSpacing: 4, children: [
                  Text(
                    _getCategoryDisplayName(entry.key) + ": ",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  ...entry.value
                      .map((tag) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color:
                                  _getCategoryColor(entry.key).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
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
                ]),
              );
            }).toList(),
          ]),
        ),
      ],
    );
  }

  Map<String, List<String>> _categorizeTags(List<String> tags) {
    final Map<String, List<String>> categorized = {};

    for (String tag in tags) {
      String category = '';

      if (tag.startsWith('platform:')) {
        category = 'platform';
      } else if (tag.startsWith('sdk:')) {
        category = 'sdk';
      } else if (tag.startsWith('is:')) {
        category = 'is';
        continue;
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
        return Colors.blue;
    }
  }

  String _removeTagPrefix(String tag) {
    if (tag.contains(':')) {
      return tag.split(':').last;
    }
    return tag;
  }
}
