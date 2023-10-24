import '../functions.dart';

//快速排序
Future<void> mergeSort(List<int> src, SortCallback callback) async {
  await _mergeSort(src,callback,0,src.length-1);
}

///归并排序
Future<void> _mergeSort(List<int> src, SortCallback callback,int leftIndex, int rightIndex) async {
  // 定义一个名为 merge 的异步函数，用于合并两个有序子数组
  Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
    // 计算左侧子数组和右侧子数组的大小
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    // 创建左侧子数组和右侧子数组
    List leftList = List.generate(leftSize, (index) => 0);
    List rightList = List.generate(rightSize, (index) => 0);

    // 将原始数组中的元素分别复制到左侧子数组和右侧子数组中
    for (int i = 0; i < leftSize; i++) {
      leftList[i] = src[leftIndex + i];
    }
    for (int j = 0; j < rightSize; j++) {
      rightList[j] = src[middleIndex + j + 1];
    }

    // 初始化游标和索引
    int i = 0, j = 0;
    int k = leftIndex;

    // 比较左侧子数组和右侧子数组的元素，并按顺序将较小的元素放入原始数组中
    while (i < leftSize && j < rightSize) {
      if (leftList[i] <= rightList[j]) {
        src[k] = leftList[i];
        i++;
      } else {
        src[k] = rightList[j];
        j++;
      }

      await callback(src);

      k++;
    }

    // 将左侧子数组或右侧子数组中剩余的元素放入原始数组中
    while (i < leftSize) {
      src[k] = leftList[i];
      i++;
      k++;

      await callback(src);
    }

    while (j < rightSize) {
      src[k] = rightList[j];
      j++;
      k++;

      await callback(src);
    }
  }

  // 如果左索引小于右索引，则递归地对数组进行归并排序
  if (leftIndex < rightIndex) {
    // 计算中间索引位置
    int middleIndex = (rightIndex + leftIndex) ~/ 2;

    // 分别对左侧子数组和右侧子数组进行归并排序
    await _mergeSort(src,callback,leftIndex, middleIndex);
    await _mergeSort(src,callback,middleIndex + 1, rightIndex);

    await callback(src);

    // 合并两个有序子数组
    await merge(leftIndex, middleIndex, rightIndex);
  }
}