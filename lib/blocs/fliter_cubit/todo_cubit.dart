import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';
import 'package:young_and_yandex_to_do_app/repositories/TaskRepository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final List<TaskModel> allTasks;

  TodoCubit(this.allTasks)
      : super(
          TodoInitial(status: true, allTasks: allTasks),
        );

  void switchStatus() {
    final currentState = state as TodoInitial;
    final newStatus = !currentState.status;
    emit(currentState.copyWith(status: newStatus));
  }

  void delete(int index) {
    final currentState = state as TodoInitial;
    final List<TaskModel> updatedTasks =
        List<TaskModel>.from(currentState.allTasks); // Копирование списка
    updatedTasks.removeAt(index); // Удаление элемента по индексу
    emit(
      currentState.copyWith(allTasks: updatedTasks),
    );
  }

  void switchTaskStatus(int index) {
    final currentState = state as TodoInitial;
    final updatedTasks =
        List<TaskModel>.from(currentState.allTasks); // Копирование списка
    final task = updatedTasks[index]; // Получение задачи по индексу

    // Изменение статуса задачи
    final newStatus = !task.status;
    final updatedTask = task.copyWith(status: newStatus);

    // Обновление списка задач
    updatedTasks[index] = updatedTask;

    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  void add(TaskModel task) {
    final currentState = state as TodoInitial;
    final updatedTasks =
        List<TaskModel>.from(currentState.allTasks); // Копирование списка
    updatedTasks.add(task); // Добавление новой задачи

    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  void editing(int index, TaskModel task) {
    final currentState = state as TodoInitial;
    final updatedTasks =
        List<TaskModel>.from(currentState.allTasks); // Копирование списка
    updatedTasks[index] = task; // Замена задачи в скопированном списке

    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }
}
