import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/main_screen.dart';
import 'Screens/task_screen.dart';
import 'blocs/task_cubit/task_cubit.dart';
import 'blocs/todo_cubit/todo_cubit.dart';
import 'models/TaskModel.dart';
import 'observers/route_logger.dart';
import 'repositories/TaskRepository.dart';
import 'themes/light_theme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TaskCubit _taskCubit =
      TaskCubit(TaskModel(text: '', status: false, importance: 'Нет'));
  final RouteLogger routeLogger = RouteLogger();

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(
          create: (final context) =>
              TodoCubit(TaskRepository().getAllTasks()),
        ),
        BlocProvider<TaskCubit>(
          create: (final context) => _taskCubit,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TO-DO',
        theme: lightTheme,
        initialRoute: '/',
        routes: {
          '/': (final context) => const MainScreen(),
          '/task': (final context) => TaskScreen(),
        },
        navigatorObservers: [routeLogger],
      ),
    );
}
