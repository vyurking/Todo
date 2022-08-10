import 'package:flutter/material.dart';
import 'package:todo_with_bloc/components/popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../page/edit_task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleleTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TaskBloc>().add(DeleteTask(task: task))
        : context.read<TaskBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            oldTask: task,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<TaskBloc>().add(FavoriteTask(task: task)),
                  icon: task.isFavorite == false
                      ? const Icon(Icons.star_outline)
                      : const Icon(Icons.star),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(task.date),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              PopupMenu(
                task: task,
                cancelorDelete: () => _removeOrDeleleTask(context, task),
                likeOrDislike: () =>
                    context.read<TaskBloc>().add(FavoriteTask(task: task)),
                editTask: () {
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                restoreTask: () => context.read<TaskBloc>().add(RestoreTask(task: task)),
                deleteAllTask: () => context.read<TaskBloc>().add(DeleteAllTask()),
              ),
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TaskBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
