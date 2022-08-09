import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_with_bloc/page/tasks.dart';
import 'package:todo_with_bloc/service/app_router.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
      () => runApp(MyApp(
            appRouter: AppRouter(),
          )),
      storage: storage);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TaskPage(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
