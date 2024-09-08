import '../functions.dart';

//快速排序
Future<void> quickSort(List<int> src, SortCallback callback) async {
  await _quickSort(src,callback,0,src.length-1);
}

///快速排序
Future<void> _quickSort(List<int> src, SortCallback callback,int leftIndex,int rightIndex) async {
  // 定义一个名为 _partition 的异步函数，用于划分数组，并返回划分后的基准元素的索引位置
  Future<int> _partition(int left, int right) async {
    // 选择中间位置的元素作为基准元素
    int p = (left + (right - left) / 2).toInt();

    // 交换基准元素和最右边的元素
    var temp = src[p];
    src[p] = src[right];
    src[right] = temp;
    await callback(src);

    // 初始化游标 cursor
    int cursor = left;

    // 遍历数组并根据基准元素将元素交换到左侧或右侧
    for (int i = left; i < right; i++) {
      if (cf(src[i], src[right]) <= 0) {
        // 如果当前元素小于等于基准元素，则交换它和游标位置的元素
        var temp = src[i];
        src[i] = src[cursor];
        src[cursor] = temp;
        cursor++;
        await callback(src);
      }
    }

    // 将基准元素放置在游标位置
    temp = src[right];
    src[right] = src[cursor];
    src[cursor] = temp;

    await callback(src);

    return cursor; // 返回基准元素的索引位置
  }

  // 如果左索引小于右索引，则递归地对数组进行快速排序
  if (leftIndex < rightIndex) {
    int p = await _partition(leftIndex, rightIndex);

    await _quickSort(src,callback,leftIndex, p - 1); // 对基准元素左侧的子数组进行快速排序

    await _quickSort(src,callback, p + 1, rightIndex); // 对基准元素右侧的子数组进行快速排序
  }
}

// 比较函数，用于判断两个元素的大小关系
cf(int a, int b) {
  if (a < b) {
    return -1; // 若 a 小于 b，则返回 -1
  } else if (a > b) {
    return 1; // 若 a 大于 b，则返回 1
  } else {
    return 0; // 若 a 等于 b，则返回 0
  }
}