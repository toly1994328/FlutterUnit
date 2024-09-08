import '../functions.dart';

///选择排序
Future<void> selectionSort(List<int> src, SortCallback callback ) async {
  for (int i = 0; i < src.length; i++) {
    for (int j = i + 1; j < src.length; j++) {
      // 遍历未排序部分，内层循环控制变量 j
      if (src[i] > src[j]) {
        // 判断当前元素是否比后续元素小
        int temp = src[j];
        // 交换当前元素和后续较小的元素
        src[j] = src[i];
        src[i] = temp;
      }
      await callback(src);
    }
  }
}