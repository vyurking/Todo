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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            children: taskList
                .map(
                  (task) => ExpansionPanelRadio(
                    value: task.id,
                    headerBuilder: (context, isOpen) => TaskTile(task: task),
                    body: ListTile(
                      title: SelectableText.rich(
                        TextSpan(children: [
                          const TextSpan(
                            text: 'Название\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: task.title),
                          const TextSpan(
                            text: '\n\nОписание\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: task.description),
                        ]),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}

