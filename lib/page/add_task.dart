import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../service/guid_get.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Добавь задачу',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  var task = Task(
                    title: title.text,
                    id: GUIDGen.generate(),
                  );
                  context.read<TaskBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Добавить'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
