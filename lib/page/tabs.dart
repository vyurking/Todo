import 'package:flutter/material.dart';
import 'package:todo_with_bloc/page/add_task.dart';
import 'package:todo_with_bloc/page/completed_task.dart';
import 'package:todo_with_bloc/page/favorite_task.dart';
import 'package:todo_with_bloc/page/my_drawer.dart';
import 'package:todo_with_bloc/page/pending_tasks.dart';

class TabPage extends StatefulWidget {
  TabPage({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final List<Map<String, dynamic>> _pageDetails = [
    {
      'pageName': const PendingTaskPage(),
      'title': 'В работе',
    },
    {
      'pageName': const CompletedTaskPage(),
      'title': 'Выполненные',
    },
    {
      'pageName': const FavoriteTaskPage(),
      'title': 'Избранные',
    },
  ];

  int _selectedIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedIndex]['pageName'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        ],
      ),
    );
  }
}
