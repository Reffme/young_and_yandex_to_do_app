import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/data/source/models/task_model.dart';
import '../../../../core/data/source/repositories/task_repository.dart';
import '../../../../core/logs/logger/base_logger.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(final TaskModel initialTask)
      : super(TaskInitial(task: initialTask));

  void editTask({
    final String? text,
    final DateTime? date,
    final bool? status,
    final String? importance,
    final int? index,
  }) {
    final currentState = state;
    if (currentState is TaskInitial) {
      final updatedTask = currentState.task.copyWith(
        text: text ?? currentState.task.text,
        date: date ?? currentState.task.date,
        status: status ?? currentState.task.status,
        importance: importance ?? currentState.task.importance,
      );

      BaseLogger.log('Updated Task: $updatedTask');
      emit(TaskInitial(
        task: updatedTask,
        index: index ?? currentState.index,
      ));
    }
  }

  void clearTask() {
    final currentState = state;
    if (currentState is TaskInitial) {
      final clearedTask = currentState.task.copyWith(
        text: '',
        date: null,
        status: false,
        importance: '',
      );

      BaseLogger.log('Cleared Task: $clearedTask');
      emit(TaskInitial(task: clearedTask, index: -1));
    }
  }

  void updateTaskInRepository() {
    final currentState = state;
    if (currentState is TaskInitial) {
      final taskRepository = TaskRepository(Hive.box<TaskModel>('tasks'));
      taskRepository.updateTask(currentState.task);
    }
  }
}
