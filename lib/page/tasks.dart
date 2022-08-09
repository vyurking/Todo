import 'package:flutter/material.dart';
import 'package:todo_with_bloc/page/add_task.dart';
import 'package:todo_with_bloc/page/my_drawer.dart';

import '../blocs/bloc_exports.dart';
import '../components/tasks_list.dart';
import '../models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  static const id = '/tasks_screen';

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> taskList = state.allTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Задачи'),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          drawer: const MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              Center(
                child: Chip(
                  label: Text('Количество задач: ${state.allTasks.length}'),
                ),
              ),
              TasksList(taskList: taskList),
            ],
          ),
        );
      },
    );
  }
}
