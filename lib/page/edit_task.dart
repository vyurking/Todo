import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../service/guid_get.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({
    required this.oldTask,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController(text: oldTask.title);
    TextEditingController description = TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Редактировать задачу',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            autofocus: true,
            decoration: const InputDecoration(
              label: Text('Название задачи'),
              border: OutlineInputBorder(),
            ),
            controller: title,
          ),
          const SizedBox(height: 24),
          TextField(
            autofocus: true,
            minLines: 1,
            maxLines: null,
            decoration: const InputDecoration(
              label: Text('Описание задачи'),
              border: OutlineInputBorder(),
            ),
            controller: description,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  var editedTask = Task(
                    title: title.text,
                    description: description.text,
                    id: oldTask.id,
                    isDone: false,
                    isFavorite: oldTask.isFavorite,
                    date: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now()),
                  );
                  context.read<TaskBloc>().add(EditTask(oldTask: oldTask, newTask: editedTask));
                  Navigator.pop(context);
                },
                child: const Text('Сохранить'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
