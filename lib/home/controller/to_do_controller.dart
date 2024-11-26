import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/constants/string_contants.dart';
import 'package:to_do_app/home/controller/to_do_state.dart';
import 'package:to_do_app/home/models/todo_model.dart';
import 'package:to_do_app/utils/shared_prefs_utils.dart';

final todoNotifierProvider = StateNotifierProvider.autoDispose<TODONotifier, ToDoState>((ref) {
  return TODONotifier();
});

class TODONotifier extends StateNotifier<ToDoState> {
  TODONotifier() : super(ToDoState.init()) {
    getAllTODOs();
  }

  Future<bool> addTaskToList({required String text, required bool isCompleted}) async {
    final tasksList = Prefs.getString(ConstantHelpers.LISTOFTASKS);
    if (tasksList.isNotEmpty) {
      try {
        List<dynamic> decodedTodosList = jsonDecode(tasksList);
        decodedTodosList.add({"task": text, "status": isCompleted});
        final encodedListOfTodos = jsonEncode(decodedTodosList);
        Prefs.setString(ConstantHelpers.LISTOFTASKS, encodedListOfTodos);
        getAllTODOs();
        return true;
      } catch (e) {
        return false;
      }
    } else {
      try {
        List<Map<String, dynamic>> tasks = [];
        tasks.add({"task": text, "status": isCompleted});
        final savableTasksList = jsonEncode(tasks);
        Prefs.setString(ConstantHelpers.LISTOFTASKS, savableTasksList);
        getAllTODOs();
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  void getAllTODOs() {
    final todos = Prefs.getString(ConstantHelpers.LISTOFTASKS);
    if (todos.isNotEmpty) {
      final decodedTodos = jsonDecode(todos);
      List<TodoModel> listOfTodos = [];

      for (var todo in decodedTodos) {
        TodoModel todoModel = TodoModel.fromJson(todo);
        listOfTodos.add(todoModel);
      } 
      state = state.copyWith(allTODOsList: listOfTodos);
    }
  }

  void isTaskCompleted(bool value) {
    state = state.copyWith(isTaskCompleted: value);
  }

  void todoText(String text) {
    state = state.copyWith(task: text);
  }

  void updateTODOCompleteStatus({required TodoModel todoTask, required int index, required bool status}) {
    state = state.copyWith(isTaskCompleted: status);
    final tasksList = Prefs.getString(ConstantHelpers.LISTOFTASKS);
    List<dynamic> decodedTodosList = jsonDecode(tasksList);
    Map<String, dynamic> updatedTodo = {};
    for (var todo in decodedTodosList) {
      if (todo["task"].toString().toLowerCase() == todoTask.task.toLowerCase()) {
        todo["status"] = status;
        updatedTodo = todo;
        break;
      }
    }
    decodedTodosList.removeAt(index);

    decodedTodosList.insert(index, updatedTodo);
    final encodedTodoTaskList = jsonEncode(decodedTodosList);
    Prefs.setString(ConstantHelpers.LISTOFTASKS, encodedTodoTaskList);
    getAllTODOs();
  }
}
