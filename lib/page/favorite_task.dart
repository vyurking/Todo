import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../components/tasks_list.dart';
import '../models/task.dart';

class FavoriteTaskPage extends StatelessWidget {
  const FavoriteTaskPage({Key? key}) : super(key: key);
  static const id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> taskList = state.favoriteTasks;
        return Column(
          children: [
            Center(
              child: Chip(
                label: Text('Количество задач: ${taskList.length}'),
              ),
            ),
            TasksList(taskList: taskList),
          ],
        );
      },
    );
  }
}
