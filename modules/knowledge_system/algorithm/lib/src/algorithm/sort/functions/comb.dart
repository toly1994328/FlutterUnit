import '../functions.dart';

///梳排序（Comb Sort）
Future<void> combSort(List<int> src, SortCallback callback) async{
  int gap = src.length;

  bool swapped = true;

  // 当间隔不为1或存在交换时执行循环
  while (gap != 1 || swapped == true) {
    // 通过缩小间隔来逐步将元素归位
    gap = getNextGap(gap);
    swapped = false;
    for (int i = 0; i < src.length - gap; i++) {
      // 如果当前元素大于间隔位置上的元素，则交换它们的位置
      if (src[i] > src[i + gap]) {
        int temp = src[i];
        src[i] = src[i + gap];
        src[i + gap] = temp;
        swapped = true;
      }

      // 实现一个延迟，以便在 UI 上展示排序的动画效果。
      await callback(src);
    }
  }
}

int getNextGap(int gap) {
  // 根据当前间隔值计算下一个间隔值
  gap = (gap * 10) ~/ 13;
  if (gap < 1) return 1;
  return gap;
}