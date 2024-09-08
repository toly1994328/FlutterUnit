import '../functions.dart';

///循环排序
Future<void> cycleSort(List<int> src, SortCallback callback) async {
  int writes = 0;
  for (int cycleStart = 0; cycleStart <= src.length - 2; cycleStart++) {
    int item = src[cycleStart];
    int pos = cycleStart;

    // 在未排序部分中寻找比当前元素小的元素个数
    for (int i = cycleStart + 1; i < src.length; i++) {
      if (src[i] < item) pos++;
    }

    // 如果当前元素已经在正确位置上，则跳过此次迭代
    if (pos == cycleStart) {
      continue;
    }

    // 将当前元素放置到正确的位置上，并记录写操作次数
    while (item == src[pos]) {
      pos += 1;
    }
    if (pos != cycleStart) {
      int temp = item;
      item = src[pos];
      src[pos] = temp;
      writes++;
    }

    // 循环将位于当前位置的元素放置到正确的位置上
    while (pos != cycleStart) {
      pos = cycleStart;
      // 继续在未排序部分中寻找比当前元素小的元素个数
      for (int i = cycleStart + 1; i < src.length; i++) {
        if (src[i] < item) pos += 1;
      }

      // 将当前元素放置到正确的位置上，并记录写操作次数
      while (item == src[pos]) {
        pos += 1;
      }
      if (item != src[pos]) {
        int temp = item;
        item = src[pos];
        src[pos] = temp;
        writes++;
      }

      // 添加延迟操作以展示排序过程
      await callback(src);
    }
  }
}