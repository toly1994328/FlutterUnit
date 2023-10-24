import '../functions.dart';

///堆排序
Future<void> heapSort(List<int> src, SortCallback callback) async {
  // 从最后一个非叶子节点开始，构建最大堆
  for (int i = src.length ~/ 2; i >= 0; i--) {
    await heapify(src,callback, src.length, i);
  }

  // 依次取出最大堆的根节点（最大值），并进行堆化
  for (int i = src.length - 1; i >= 0; i--) {
    int temp = src[0];
    src[0] = src[i];
    src[i] = temp;
    await heapify(src, callback,i, 0);
  }
}

Future<void> heapify(List<int> src, SortCallback callback, int n, int i)  async{
  int largest = i;
  int l = 2 * i + 1; // 左子节点索引
  int r = 2 * i + 2; // 右子节点索引

  // 如果左子节点存在并且大于父节点，则更新最大值索引
  if (l < n && src[l] > src[largest]) largest = l;

  // 如果右子节点存在并且大于父节点或左子节点，则更新最大值索引
  if (r < n && src[r] > src[largest]) largest = r;

  // 如果最大值索引不等于当前节点索引，则交换节点值，并递归进行堆化
  if (largest != i) {
    int temp = src[i];
    src[i] = src[largest];
    src[largest] = temp;
    heapify(src,callback, n, largest);
  }
  await callback(src);
}