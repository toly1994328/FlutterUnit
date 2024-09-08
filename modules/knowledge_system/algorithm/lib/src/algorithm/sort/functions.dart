import 'functions/bubble.dart';
import 'functions/cocktail.dart';
import 'functions/comb.dart';
import 'functions/cycle.dart';
import 'functions/gnome.dart';
import 'functions/heap.dart';
import 'functions/insertion.dart';
import 'functions/merge.dart';
import 'functions/pigeonHole.dart';
import 'functions/quick.dart';
import 'functions/selection.dart';
import 'functions/shell.dart';

typedef SortFunction = Future<void> Function(List<int> src, SortCallback callback);
typedef SortCallback = Future<void> Function(List<int> dist);

Map<String, SortFunction> sortFunctionMap = {
  'insertion': insertionSort,
  'bubble': bubbleSort,
  'cocktail': cocktailSort,
  'comb': combSort,
  'pigeonHole': pigeonHoleSort,
  'shell': shellSort,
  'selection': selectionSort,
  'gnome': gnomeSort,
  'cycle': cycleSort,
  'heap': heapSort,
  'quick': quickSort,
  'merge': mergeSort,
};

Map<String, String> sortNameMap = {
  'insertion': '插入排序',
  'bubble': '冒泡排序',
  'cocktail': '鸡尾酒排序(双向冒泡排序)',
  'comb': '梳排序',
  'pigeonHole': '鸽巢排序',
  'shell': '希尔排序',
  'selection': '选择排序',
  'gnome': '侏儒排序',
  'cycle': '循环排序',
  'heap': '堆排序',
  'quick': '快速排序',
  'merge': '归并排序',
};

