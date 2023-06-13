import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';

class TaskRepository {
  List<TaskModel> getFilteredProducts() {
    final List<TaskModel> products = [
      TaskModel(
          text: 'Создайте вашу первую задачу!',
          date: DateTime.now().toUtc(),
          status: false,
          importance: 'Нет'),
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
    return products;
  }
}
