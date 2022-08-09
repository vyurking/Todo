import 'package:flutter/material.dart';
import 'package:todo_with_bloc/page/recycle_bin.dart';
import 'package:todo_with_bloc/page/tasks.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBinPage.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinPage());
      case TaskPage.id:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      default:
        null;
    }
  }
}
