class TaskResult {
   int cost;
   String taskName;
   int count;
   String taskCode;
   String taskInfo;

  TaskResult({
    required this.cost,
    required this.taskName,
    required this.count,
    required this.taskCode,
    required this.taskInfo,
  });

  TaskResult copyWith({
    int? cost,
    String? taskName,
    int? count,
    String? taskCode,
    String? taskInfo,
  }) =>
      TaskResult(
        cost: cost ?? this.cost,
        taskName: taskName ?? this.taskName,
        count: count ?? this.count,
        taskCode: taskCode ?? this.taskCode,
        taskInfo: taskInfo ?? this.taskInfo,
      );
      
      static TaskResult fromJson(Map<String, dynamic> map) => TaskResult(
        cost: map["cost"] ,
        taskName: map["taskName"] ,
        count: map["count"] ,
        taskCode: map["taskCode"] ,
        taskInfo: map["taskInfo"] ,
      );

  Map<String,dynamic> toJson()=>{
        "cost": cost,
        "taskName": taskName,
        "count": count,
        "taskCode": taskCode,
        "taskInfo": taskInfo,
  };
}
