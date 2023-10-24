import '../functions.dart';

///地精排序 (侏儒排序)
Future<void> gnomeSort(List<int> src, SortCallback callback) async {
  int index = 0;
  while (index < src.length) {
    // 当 index 小于数组长度时执行循环
    if (index == 0) index++;
    if (src[index] >= src[index - 1]) {
      // 如果当前元素大于等于前面的元素，则将 index 加1
      index++;
    } else {
      // 否则，交换这两个元素，并将 index 减1（使得元素可以沉到正确位置）
      int temp = src[index];
      src[index] = src[index - 1];
      src[index - 1] = temp;
      index--;
    }
    await callback(src);
  }
  return;
}