import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/home/controller/to_do_controller.dart';
import 'package:to_do_app/home/views/writing_to_do_task_screen.dart';

class ToDosHomeScreen extends StatelessWidget {
  const ToDosHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref00, _) {
        final taskState = ref00.watch(todoNotifierProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            taskState.allTODOsList.isEmpty
                ? const Center(
                    child: Text("No TODOs Available!"),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: taskState.allTODOsList.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(taskState.allTODOsList[index].task),
                      leading: Checkbox(
                        value: taskState.allTODOsList[index].status,
                        onChanged: (value) {
                          ref00.read(todoNotifierProvider.notifier).updateTODOCompleteStatus(
                              index: index, status: value ?? false, todoTask: taskState.allTODOsList[index]);
                        },
                      ),
                    ),
                  ))
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WritingToDoTaskScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
