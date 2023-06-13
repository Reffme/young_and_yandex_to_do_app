import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:young_and_yandex_to_do_app/Screens/main_screen.dart';
import 'package:young_and_yandex_to_do_app/Screens/task_screen.dart';
import 'package:young_and_yandex_to_do_app/blocs/fliter_cubit/todo_cubit.dart';
import 'package:young_and_yandex_to_do_app/repositories/TaskRepository.dart';
import 'package:young_and_yandex_to_do_app/screens/main_screen_test.dart';
import 'package:young_and_yandex_to_do_app/themes/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO-DO',
      theme: lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            BlocProvider(
              create: (context) => TodoCubit(TaskRepository().getFilteredProducts()),
              child: MainScreen(),
            ),
        '/task': (context) => const TaskScreen(),
        '/test': (context) => const MainTestScreen(),

      },
    );
  }
}

