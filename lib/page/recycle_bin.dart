import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../components/tasks_list.dart';
import 'my_drawer.dart';

class RecycleBinPage extends StatelessWidget {
  const RecycleBinPage({Key? key}) : super(key: key);

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Корзина'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            drawer: const MyDrawer(),
            body: Column(
              children: [
                Center(
                  child: Chip(
                    label: Text('Количество удаленных задач: ${state.removedTasks.length}'),
                  ),
                ),
                TasksList(taskList: state.removedTasks),
              ],
            ));
      },
    );
  }
}
