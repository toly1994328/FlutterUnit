sealed class TaskStatus {
  const TaskStatus();
}

class TaskNone extends TaskStatus {
  const TaskNone();
}

class TaskLoading extends TaskStatus {
  const TaskLoading();
}

class TaskSuccess extends TaskStatus {
  const TaskSuccess();
}

class TaskFailed extends TaskStatus {
  final Object? error;
  final StackTrace? trace;
  const TaskFailed(this.error, [this.trace]);
}
