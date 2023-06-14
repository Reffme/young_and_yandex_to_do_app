import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:young_and_yandex_to_do_app/Screens/main_screen.dart';
import 'package:young_and_yandex_to_do_app/Screens/task_screen.dart';
import 'package:young_and_yandex_to_do_app/blocs/task_cubit/task_cubit.dart';
import 'package:young_and_yandex_to_do_app/blocs/todo_cubit/todo_cubit.dart';
import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';
import 'package:young_and_yandex_to_do_app/observers/route_logger.dart';
import 'package:young_and_yandex_to_do_app/repositories/TaskRepository.dart';
import 'package:young_and_yandex_to_do_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TaskCubit _taskCubit =
      TaskCubit(TaskModel(text: '', status: false, importance: "Нет"));
  final RouteLogger routeLogger = RouteLogger();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(
          create: (BuildContext context) =>
              TodoCubit(TaskRepository().getAllTasks()),
        ),
        BlocProvider<TaskCubit>(
          create: (BuildContext context) => _taskCubit,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TO-DO',
        theme: lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/task': (context) => TaskScreen(),
        },
        navigatorObservers: [routeLogger],
      ),
    );
  }
}
