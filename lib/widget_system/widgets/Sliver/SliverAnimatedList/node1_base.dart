
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 301 SliverAnimatedList Sliver动画列表 在插入或删除项目时使其有动画效果的sliver组件。
//    {
//      "widgetId": 301,
//      "name": 'SliverAnimatedList基本使用',
//      "priority": 1,
//      "subtitle": "【itemBuilder】 : item构造器   【AnimatedListItemBuilder】\n"
//          "【initialItemCount】 : 初始item个数   【int】",
//    }
class SliverAnimatedListDemo extends StatefulWidget {
  const SliverAnimatedListDemo({Key? key}) : super(key: key);

  @override
  _SliverAnimatedListDemoState createState() =>
      _SliverAnimatedListDemoState();
}

class _SliverAnimatedListDemoState extends State<SliverAnimatedListDemo> {

  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  late ListModel<int> _list;
  int? _selectedItem;
  int _nextItem=0;

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
  }

  void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    } else {
      if(_list.length>0){
        _list.removeAt(0);
        setState(() {
          _selectedItem = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 300,
      child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: const Text(
                  'SliverAnimatedList',
                  style: TextStyle(fontSize: 20),
                ),
                expandedHeight: 60,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: _insert,
                  tooltip: '插入一个item',
                  iconSize: 32,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: _remove,
                    tooltip: '删除选中的item',
                    iconSize: 32,
                  ),
                ],
              ),
              SliverAnimatedList(
                key: _listKey,
                initialItemCount: _list.length,
                itemBuilder: _buildItem,
              ),
            ],
      ),
    );
  }


}

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    required Iterable<E>? initialItems,
  }) : assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);
  final GlobalKey<SliverAnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;
  SliverAnimatedListState? get _animatedList => listKey.currentState;
  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList?.insertItem(index);
  }
  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList?.removeItem(
        index,
            (BuildContext context, Animation<double> animation) => removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }
  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}


class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.animation,
    required this.item,
    this.onTap,
    this.selected = false,
  }) :super(key: key);
  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 2.0,
        bottom: 0.0,
      ),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 60.0,
            child: Card(
              color: selected
                  ? Colors.black12
                  : Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Item $item',
                  style: const TextStyle(color: Colors.white,fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}