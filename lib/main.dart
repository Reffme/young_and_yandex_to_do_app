import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/data/remote/network_service.dart';
import 'core/data/source/models/task_model.dart';
import 'core/data/source/repositories/task_repository.dart';
import 'core/logs/observers/logging_cubit_observer.dart';
import 'core/data/remote/repositories/list_repository.dart';
import 'to_do_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  Bloc.observer = LoggingCubitObserver();

  // Initialize network service
  final networkService = NetworkService();

  // Create list repository
  final listRepository = ListRepository(networkService);

  // //тестирую
  // try {
  //   final list = await listRepository.getList();
  //   // Process the list as needed
  // } catch (error) {}

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  final taskBox = await Hive.openBox<TaskModel>('tasks');
  final taskRepository = TaskRepository(taskBox);
  runApp(MyApp(
    taskRepository: taskRepository,
  ));
}
