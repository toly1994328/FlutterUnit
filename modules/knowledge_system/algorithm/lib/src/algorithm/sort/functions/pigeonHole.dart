import '../functions.dart';

///鸽巢排序
Future<void> pigeonHoleSort(List<int> src, SortCallback callback ) async{
  int min = src[0];
  int max = src[0];
  int range, i, j, index;

  // 找到数组中的最大值和最小值
  for (int a = 0; a < src.length; a++) {
    if (src[a] > max) max = src[a];
    if (src[a] < min) min = src[a];
  }

  // 计算鸽巢的个数
  range = max - min + 1;
  List<int> p = List.generate(range, (i) => 0);

  // 将数字分配到各个鸽巢中
  for (i = 0; i < src.length; i++) {
    p[src[i] - min]++;
  }

  index = 0;

  // 将鸽巢中的数字取出，重新放回到数组中
  for (j = 0; j < range; j++) {
    while (p[j]-- > 0) {
      src[index++] = j + min;
      await callback(src);
    }
  }
}