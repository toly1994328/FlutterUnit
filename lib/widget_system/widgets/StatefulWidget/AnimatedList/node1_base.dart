import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 117,
//      "name": 'AnimatedList基本使用',
//      "priority": 1,
//      "subtitle": "【itemBuilder】 : 组件构造器   【AnimatedListItemBuilder】\n"
//          "【initialItemCount】 : 子组件数量   【int】\n"
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【controller】 : 滑动控制器   【ScrollController】\n"
//          "【reverse】 : 数据是否反向   【bool】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】",
//    }
class CustomAnimatedList extends StatefulWidget {
  const CustomAnimatedList({Key? key}) : super(key: key);

  @override
  _CustomAnimatedListState createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<int> _list;
  int? _selectedItem;
  int _nextItem = 0;

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: [0, 1, 2, 3],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 4;
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
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

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
    );
  }

  void _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withAlpha(33),
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          children: <Widget>[
            _buildBtn(),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: 300,
              child: AnimatedList(
                padding: const EdgeInsets.all(10.0),
                key: _listKey,
                initialItemCount: _list.length,
                itemBuilder: _buildItem,
              ),
            )
          ],
        ));
  }

  Widget _buildBtn() => Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Colors.blue,
            ),
            onPressed: _insert,
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.blue),
            onPressed: _remove,
          ),
        ],
      );
}

class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    required Iterable<E> initialItems,
  })  : assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems);
  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList?.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList?.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key? key,
      required this.animation,
      this.onTap,
      required this.item,
      this.selected = false})
      : assert(item >= 0),
        super(key: key);
  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: Card(
        child: Container(
          color: Colors.primaries[item % Colors.primaries.length],
          child: CheckboxListTile(
              dense: true,
              title: Text(
                'Item $item',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              value: selected,
              onChanged: (v) {
                onTap?.call();
              }),
        ),
      ),
    );
  }
}
