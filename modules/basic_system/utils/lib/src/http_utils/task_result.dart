class TaskResult<T> {
  final T? data;
  final bool success;
  final String msg;
  final int count;

  TaskResult({this.data, this.success=false, this.msg='',this.count=0});

  @override
  String toString() {
    return 'RepResult{data: $data, status: $success, msg:$msg}';
  }

  const TaskResult.error({required this.msg})
      : success = false,
        data = null,
        count = 0
  ;

  const TaskResult.success({
    this.data,
    this.msg = '',
    this.count = 0,
  }) : success = true;
}
