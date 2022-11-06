import 'dart:math';

class RandomProvider{
  RandomProvider._();//私有化构造
  static final _random= Random();
  static Random get random =>_random;
}