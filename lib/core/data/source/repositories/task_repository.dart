import '../models/task_model.dart';

import 'package:hive/hive.dart';

class TaskRepository {
  final Box<TaskModel> _taskBox;

  TaskRepository(this._taskBox);

  Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  Future<void> updateTask(TaskModel task) async {
    final box =
        await Hive.openBox<TaskModel>('tasks'); // Открываем коробку 'tasks'

    if (!box.containsKey(task.id)) {
      throw Exception(
          'Task does not exist in the box.'); // Проверяем, что задача существует в коробке
    }

    await box.put(task.id, task); // Сохраняем задачу в коробку
  }

  Future<void> deleteTask(int index) async {
    await _taskBox.deleteAt(index);
  }

  List<TaskModel> getAllTasks() {
    return _taskBox.values.toList();
  }
}

// class TaskRepository {
//   List<TaskModel> getAllTasks() {
//     final List<TaskModel> value = [
//       TaskModel(
//         text: 'Начать путешествие',
//         date: DateTime.now().toUtc(),
//         status: false,
//         importance: 'Высокий',
//       ),
//       TaskModel(
//         text: 'Исследовать океан',
//         status: true,
//         date: null,
//         importance: 'Нет',
//       ),
//       TaskModel(
//         text: 'Завершить проект',
//         date: DateTime.now().toUtc(),
//         status: false,
//         importance: 'Низкий',
//       ),
//       TaskModel(
//         text: 'Учиться программированию',
//         status: false,
//         importance: 'Высокий',
//       ),
//       TaskModel(
//         text: 'Сделать подарок',
//         status: true,
//         importance: 'Нет',
//       ),
//       TaskModel(
//         text: 'Познать мудрость',
//         date: DateTime.now().toUtc(),
//         status: false,
//         importance: 'Нет',
//       ),
//       TaskModel(
//         text: 'Написать книгу',
//         date: DateTime.now().toUtc(),
//         status: false,
//         importance: 'Высокий',
//       ),
//       TaskModel(
//         text: 'Организовать праздник',
//         status: true,
//         date: null,
//         importance: 'Нет',
//       ),
//       TaskModel(
//         text: 'Путешествовать вместе',
//         date: DateTime.now().toUtc(),
//         status: false,
//         importance: 'Низкий',
//       ),
//       TaskModel(
//         text: 'Прокачать навыки',
//         status: false,
//         importance: 'Высокий',
//       ),
//       TaskModel(
//         text: 'Достичь успеха',
//         status: true,
//         importance: 'Нет',
//       ),
//       TaskModel(
//         text: 'Создать искусство',
//         date: DateTime.now().toUtc(),
//         status: false,
//         importance: 'Нет',
//       ),
//     ];
//     return value;
//   }
//
//   int getCountSuccessTasks() {
//     const  int value = 8;
//     return value;
//   }
// }
