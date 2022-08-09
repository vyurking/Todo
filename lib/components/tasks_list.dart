import 'package:flutter/material.dart';
import 'package:todo_with_bloc/components/task_tile.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          var task = taskList[index];
          return TaskTile(task: task);
        },
      ),
    );
  }
}

