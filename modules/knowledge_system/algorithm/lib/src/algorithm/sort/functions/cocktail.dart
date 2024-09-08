import '../functions.dart';

///鸡尾酒排序(双向冒泡排序)
Future<void> cocktailSort(List<int> src, SortCallback callback ) async {
  bool swapped = true; // 表示是否进行了交换
  int start = 0; // 当前未排序部分的起始位置
  int end = src.length; // 当前未排序部分的结束位置

  // 开始排序循环，只有当没有进行交换时才会退出循环
  while (swapped == true) {
    swapped = false;

    // 从左往右遍历需要排序的部分
    for (int i = start; i < end - 1; ++i) {
      // 对每两个相邻元素进行比较
      if (src[i] > src[i + 1]) {
        // 如果前面的元素大于后面的元素，则交换它们的位置
        int temp = src[i];
        src[i] = src[i + 1];
        src[i + 1] = temp;
        swapped = true; // 进行了交换
      }

      // 实现动画效果，延迟一段时间后更新数组状态
      await callback(src);
    }

    // 如果没有进行交换，则说明已经排好序，退出循环
    if (swapped == false) break;
    // 重设为false，准备进行下一轮排序
    swapped = false;
    // 将end设置为上一轮排序的最后一个元素的位置
    end = end - 1;

    // 从右往左遍历需要排序的部分
    for (int i = end - 1; i >= start; i--) {
      // 对每两个相邻元素进行比较
      if (src[i] > src[i + 1]) {
        // 如果前面的元素大于后面的元素，则交换它们的位置
        int temp = src[i];
        src[i] = src[i + 1];
        src[i + 1] = temp;
        swapped = true; // 进行了交换
      }

      // 实现动画效果，延迟一段时间后更新数组状态
      await callback(src);
    }
    // 将start向右移一位，准备下一轮排序
    start = start + 1;
  }
}