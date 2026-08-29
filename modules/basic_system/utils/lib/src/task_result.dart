/// 表示一次异步任务的结果。
class TaskResult<T> {
  /// 成功时携带的数据。
  final T? data;

  /// 任务是否执行成功。
  final bool success;

  /// 面向调用方的结果说明。
  final String msg;

  /// 结果包含的数据总量。
  final int count;

  const TaskResult({
    this.data,
    this.success = false,
    this.msg = '',
    this.count = 0,
  });

  const TaskResult.error({required this.msg})
      : success = false,
        data = null,
        count = 0;

  const TaskResult.success({
    this.data,
    this.msg = '',
    this.count = 0,
  }) : success = true;

  @override
  String toString() {
    return 'TaskResult{data: $data, success: $success, msg: $msg}';
  }
}
