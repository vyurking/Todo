import 'package:flutter/material.dart';
import 'package:todo_with_bloc/page/recycle_bin.dart';
import 'package:todo_with_bloc/page/pending_tasks.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              color: Colors.grey,
              child: Text(
                'Тут задачки',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(PendingTaskPage.id),
                  leading: const Icon(Icons.folder_special_outlined),
                  title: const Text('Мои задачи'),
                  trailing: Text('${state.pendingTasks.length}'),
                );
              },
            ),
            const Divider(),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushReplacementNamed(RecycleBinPage.id),
                  leading: const Icon(Icons.folder_delete_outlined),
                  title: const Text('Корзина'),
                  trailing: Text('${state.removedTasks.length}'),
                );
              },
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                  value: state.switchValue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwithcOnEvent())
                        : context.read<SwitchBloc>().add(SwithcOffEvent());
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
