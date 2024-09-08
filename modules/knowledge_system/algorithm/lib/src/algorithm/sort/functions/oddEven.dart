import '../functions.dart';

///奇偶排序(Odd-Even Sort)
Future<void> oddEvenSort(List<int> src, SortCallback callback) async {
  bool isSorted = false;

  while (!isSorted) {
    // 当 isSorted 为 false 时执行循环
    isSorted = true; // 先假设数组已经排好序

    for (int i = 1; i <= src.length - 2; i = i + 2) {
      // 对奇数索引位置进行比较
      if (src[i] > src[i + 1]) {
        // 如果当前元素大于后面的元素，则交换它们的值
        int temp = src[i];
        src[i] = src[i + 1];
        src[i + 1] = temp;
        isSorted = false; // 若发生了交换，则说明数组仍未完全排序，将 isSorted 设为 false
        await callback(src);
      }
    }

    for (int i = 0; i <= src.length - 2; i = i + 2) {
      // 对偶数索引位置进行比较
      if (src[i] > src[i + 1]) {
        // 如果当前元素大于后面的元素，则交换它们的值
        int temp = src[i];
        src[i] = src[i + 1];
        src[i + 1] = temp;
        isSorted = false;
        await callback(src);
      }
    }
  }

  return;
}