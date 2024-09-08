import '../functions.dart';

///插入排序
Future<void> insertionSort(List<int> src, SortCallback callback) async {
  for (int i = 1; i < src.length; i++) {
    int temp = src[i]; // 将当前元素存储到临时变量 temp 中
    int j = i - 1; // j 表示已排序部分的最后一个元素的索引

    // 在已排序部分从后往前查找，找到合适位置插入当前元素
    while (j >= 0 && temp < src[j]) {
      src[j + 1] = src[j]; // 当前元素比已排序部分的元素小，将元素后移一位
      --j; // 向前遍历
      // 更新排序结果回调
      await callback(src);
    }
    src[j + 1] = temp; // 插入当前元素到已排序部分的正确位置
    await callback(src);
  }
}
