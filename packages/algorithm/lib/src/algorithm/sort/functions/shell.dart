import '../functions.dart';

///希尔排序
Future<void> shellSort(List<int> src, SortCallback callback) async{
  //定义变量 gap 并初始化为数组长度的一半。每次循环完成后将 gap 减半直到等于 0。
  for (int gap = src.length ~/ 2; gap > 0; gap ~/= 2) {
    //遍历每个子序列并进行插入排序。初始时从第一个子序列的第二个元素开始，即 i = gap，以 gap 为步长逐个遍历每个子序列。
    for (int i = gap; i < src.length; i += 1) {
      //将当前遍历到的元素赋值给它
      int temp = src[i];
      //内部使用一个 for 循环来实现插入排序。
      //循环开始时定义变量 j 并将其初始化为当前遍历到的元素的下标。通过不断比较前后相隔 gap 的元素大小并交换位置，将当前元素插入到正确的位置。
      int j;
      for (j = i; j >= gap && src[j - gap] > temp; j -= gap) {
        src[j] = src[j - gap];
      }
      src[j] = temp;
      await callback(src);
    }
  }
}