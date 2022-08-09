import 'package:flutter/material.dart';
import 'package:todo_with_bloc/page/recycle_bin.dart';
import 'package:todo_with_bloc/page/tabs.dart';
import 'package:todo_with_bloc/page/pending_tasks.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBinPage.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinPage());
      case TabPage.id:
        return MaterialPageRoute(builder: (_) => TabPage());
      default:
        null;
    }
  }
}
