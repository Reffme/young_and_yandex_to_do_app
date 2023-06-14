import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/TaskModel.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.allTasks)
      : super(
          TodoInitial(status: true, allTasks: allTasks),
        );
  final List<TaskModel> allTasks;

  void switchStatus() {
    debugPrint('switchStatus() called');

    final currentState = state as TodoInitial;
    final newStatus = !currentState.status;
    emit(currentState.copyWith(status: newStatus));
  }

  void delete(final int index) {
    debugPrint('delete() called with index: $index');

    final currentState = state as TodoInitial;
    final List<TaskModel> updatedTasks =
        List<TaskModel>.from(currentState.allTasks);
    updatedTasks.removeAt(index);
    emit(
      currentState.copyWith(allTasks: updatedTasks),
    );
  }

  void switchTaskStatus(final int index) {
    debugPrint('switchTaskStatus() called with index: $index');

    final currentState = state as TodoInitial;
    final updatedTasks = List<TaskModel>.from(currentState.allTasks);
    final task = updatedTasks[index];

    final newStatus = !task.status;
    final updatedTask = task.copyWith(status: newStatus);

    updatedTasks[index] = updatedTask;

    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  void add(final TaskModel task) {
    debugPrint('add() called with task: $task');

    final currentState = state as TodoInitial;
    final updatedTasks = List<TaskModel>.from(currentState.allTasks);
    updatedTasks.add(task);

    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  void editing(final int index, final TaskModel task) {
    debugPrint('editing() called with index: $index, task: $task');

    final currentState = state as TodoInitial;
    final updatedTasks = List<TaskModel>.from(currentState.allTasks);
    updatedTasks[index] = task;

    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  int countTasksWithStatusTrue() {
    final currentState = state as TodoInitial;
    return currentState.allTasks.where((final task) => task.status).length;
  }
}
