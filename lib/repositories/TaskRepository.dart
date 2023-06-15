import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';

class TaskRepository {
  List<TaskModel> getAllTasks() {
    final List<TaskModel> value = [
      TaskModel(
        text: 'Начать путешествие',
        date: DateTime.now().toUtc(),
        status: false,
        importance: 'Высокий',
      ),
      TaskModel(
        text: 'Исследовать океан',
        status: true,
        date: null,
        importance: 'Нет',
      ),
      TaskModel(
        text: 'Завершить проект',
        date: DateTime.now().toUtc(),
        status: false,
        importance: 'Низкий',
      ),
      TaskModel(
        text: 'Учиться программированию',
        status: false,
        importance: 'Высокий',
      ),
      TaskModel(
        text: 'Сделать подарок',
        status: true,
        importance: 'Нет',
      ),
      TaskModel(
        text: 'Познать мудрость',
        date: DateTime.now().toUtc(),
        status: false,
        importance: 'Нет',
      ),
      TaskModel(
        text: 'Написать книгу',
        date: DateTime.now().toUtc(),
        status: false,
        importance: 'Высокий',
      ),
      TaskModel(
        text: 'Организовать праздник',
        status: true,
        date: null,
        importance: 'Нет',
      ),
      TaskModel(
        text: 'Путешествовать вместе',
        date: DateTime.now().toUtc(),
        status: false,
        importance: 'Низкий',
      ),
      TaskModel(
        text: 'Прокачать навыки',
        status: false,
        importance: 'Высокий',
      ),
      TaskModel(
        text: 'Достичь успеха',
        status: true,
        importance: 'Нет',
      ),
      TaskModel(
        text: 'Создать искусство',
        date: DateTime.now().toUtc(),
        status: false,
        importance: 'Нет',
      ),
    ];
    return value;
  }

  int getCountSuccessTasks() {
    final int value = 8;
    return value;
  }
}
