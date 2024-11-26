class TodoModel {
  String task;
  bool status;

  TodoModel({
    required this.task,
    required this.status,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        task: json["task"],
        status: json["status"],
      ); 
}
