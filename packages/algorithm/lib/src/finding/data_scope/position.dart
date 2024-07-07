import 'dart:collection';

base class Position extends LinkedListEntry<Position> {
  int? x, y;
  Position? prePosition;

  Position(int x, int y, {this.prePosition}) {
    this.x = x;
    this.y = y;
  }
}
