// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:to_do_app/home/models/todo_model.dart';

class ToDoState extends Equatable {
  final List<TodoModel> allTODOsList;
  final String task;
  final bool isTaskCompleted;
  final int selectedIndex;

  const ToDoState({
    required this.allTODOsList,
    required this.task,
    required this.isTaskCompleted,
    required this.selectedIndex,
  });
  factory ToDoState.init() {
    return const ToDoState(allTODOsList: [],isTaskCompleted: false,task: "",selectedIndex: 0);
  }
  @override
  List<Object> get props => [allTODOsList, task, isTaskCompleted, selectedIndex];

  ToDoState copyWith({
    List<TodoModel>? allTODOsList,
    String? task,
    bool? isTaskCompleted,
    int? selectedIndex,
  }) {
    return ToDoState(
      allTODOsList: allTODOsList ?? this.allTODOsList,
      task: task ?? this.task,
      isTaskCompleted: isTaskCompleted ?? this.isTaskCompleted,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
