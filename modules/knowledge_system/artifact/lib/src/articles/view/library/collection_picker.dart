import 'package:flutter/material.dart';
import '../../data/exp.dart';

/// 全部专栏入口，直接选择专栏进入其文章列表。
class CollectionPicker extends StatelessWidget {
  /// 当前在线目录中的全部专栏。
  final List<Columnize> items;
  const CollectionPicker({super.key, required this.items});
  @override
  Widget build(BuildContext context) => Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620, maxHeight: 600),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 8, 8),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Text('全部专栏（${items.length}）',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700))),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: '关闭全部专栏',
                      icon: const Icon(Icons.close)),
                ])),
            Flexible(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: _item,
                    separatorBuilder: _divider)),
          ])));

  Widget _divider(BuildContext context, int index) =>
      const Divider(height: 1, indent: 20, endIndent: 20);
  Widget _item(BuildContext context, int index) {
    final Columnize item = items[index];
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        onTap: () => Navigator.of(context).pop(item),
        title: Text(item.title,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle:
            Text(item.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text('${item.count} 篇',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)));
  }
}
