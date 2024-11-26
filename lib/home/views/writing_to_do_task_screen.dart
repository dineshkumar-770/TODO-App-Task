import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/home/controller/to_do_controller.dart';

class WritingToDoTaskScreen extends StatelessWidget {
  const WritingToDoTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        actions: [
          Consumer(builder: (context, ref02, _) {
            final taskDataState = ref02.watch(todoNotifierProvider);
            return TextButton(
                onPressed: () async {
                  final status = await ref02
                      .read(todoNotifierProvider.notifier)
                      .addTaskToList(isCompleted: taskDataState.isTaskCompleted, text: taskDataState.task);
                  if (status) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("New TODO added to your list")));
                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  }
                },
                child: const Text("Save"));
          })
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Consumer(builder: (context, ref01, _) {
                final taskCompletionState = ref01.watch(todoNotifierProvider);
                return Checkbox(
                  value: taskCompletionState.isTaskCompleted,
                  onChanged: (value) {
                    ref01.read(todoNotifierProvider.notifier).isTaskCompleted(value ?? false);
                  },
                );
              }),
              const Text("Task Completed")
            ],
          ),
          Consumer(builder: (context, ref04, _) {
            return TextFormField(
              maxLines: null,
              autofocus: true,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                ref04.read(todoNotifierProvider.notifier).todoText(value);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type here...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            );
          }),
        ],
      ),
    );
  }
}
