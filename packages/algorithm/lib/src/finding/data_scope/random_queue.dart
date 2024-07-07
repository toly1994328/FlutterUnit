import 'dart:collection';
import 'dart:math';

import 'position.dart';

///借助LinkedList链表实现随机队列
class RandomQueue {
  LinkedList<Position> _queue = LinkedList<Position>();

  RandomQueue() {
    _queue = LinkedList<Position>();
  }

  void addRandomQueue(Position position) {
    if (Random().nextInt(100) < 50) {
      _queue.addFirst(position);// 插入到队列头部
    } else {
      _queue.add(position);// 插入到队列尾部
    }
  }

  ///返回随机队列中的一个元素
  Position removeRandomQueue() {
    if (_queue.isEmpty) {
      throw "数组为空";
    } else {
      if (Random().nextInt(100) < 50) {
        Position position = _queue.first;
        _queue.remove(position);
        return position;
      } else {
        Position position = _queue.last;
        _queue.remove(position);
        return position;
      }
    }
  }

  //返回随机队列元素数量
  int getSize() {
    return _queue.length;
  }

  //判断随机队列是否为空
  bool isEmpty() {
    return _queue.isEmpty;
  }
}
