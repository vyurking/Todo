import 'package:flutter/material.dart';
import 'package:todo_with_bloc/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelorDelete;
  final VoidCallback likeOrDislike;
  final VoidCallback editTask;
  final VoidCallback restoreTask;
  final VoidCallback deleteAllTask;

  const PopupMenu({
    required this.task,
    required this.cancelorDelete,
    required this.likeOrDislike,
    required this.editTask,
    required this.restoreTask,
    required this.deleteAllTask,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? (context) => [
                PopupMenuItem(
                  onTap: null,
                  child: TextButton.icon(
                    onPressed: editTask,
                    icon: const Icon(Icons.edit),
                    label: const Text('Редактировать'),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrDislike,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove_outlined),
                    label: task.isFavorite == false
                        ? const Text('Добавить в избранное')
                        : const Text('Удалить из израбнного'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelorDelete,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.edit),
                    label: const Text('Удалить'),
                  ),
                ),
              ]
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTask,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text('Восстановить'),
                  ),
                ),
                PopupMenuItem(
                  onTap: deleteAllTask,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Удалить все'),
                  ),
                ),
              ],
    );
  }
}
