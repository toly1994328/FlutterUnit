class TaskResult<T> {
  final T? data;
  final bool success;
  final String msg;

  TaskResult({this.data, this.success=false, this.msg=''});

  @override
  String toString() {
    return 'RepResult{data: $data, status: $success, msg:$msg}';
  }

  const TaskResult.error({required this.msg})
      : success = false,
        data = null;

  const TaskResult.success({
    this.data,
    this.msg = '',
  }) : success = true;
}
