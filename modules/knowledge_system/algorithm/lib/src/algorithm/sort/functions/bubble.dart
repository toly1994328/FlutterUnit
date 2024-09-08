import '../functions.dart';

///冒泡排序
Future<void> bubbleSort(List<int> src, SortCallback callback ) async{
  //控制需要进行排序的次数。每一轮循环都会确定一个数字的最终位置。
  for (int i = 0; i < src.length; ++i) {
    //遍历当前未排序的元素，通过相邻的元素比较并交换位置来完成排序。
    for (int j = 0; j < src.length - i - 1; ++j) {
      //如果 _numbers[j] 大于 _numbers[j + 1]，则交换它们的位置，确保较大的元素移到右边。
      if (src[j] > src[j + 1]) {
        int temp = src[j];
        src[j] = src[j + 1];
        src[j + 1] = temp;
      }
      //实现一个延迟，以便在ui上展示排序的动画效果
     await callback(src);
    }
  }
}