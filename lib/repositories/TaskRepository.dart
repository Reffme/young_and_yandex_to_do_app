import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';

class TaskRepository {
  List<TaskModel> getAllTasks() {
    final List<TaskModel> value = [
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Высокий'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          status: true,
          date: null,
          importance: 'Нет'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Низкий'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          status: false,
          importance: 'Высокий'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          status: true,
          importance: 'Нет'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Нет'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Высокий'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          status: true,
          date: null,
          importance: 'Нет'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Низкий'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          status: false,
          importance: 'Высокий'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          status: true,
          importance: 'Нет'),
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Нет'),
    ];
    return value;
  }
  int getCountSucessTasks() {
    final int value = 4;
    return value;
  }

}
