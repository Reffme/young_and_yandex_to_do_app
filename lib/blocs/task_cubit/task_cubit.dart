import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/TaskModel.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(final TaskModel initialTask) : super(TaskInitial(task: initialTask,));

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
      emit(TaskInitial(task: updatedTask, index: index ?? currentState.index));
    }
  }
  void clearTask() {
    final currentState = state;
    if (currentState is TaskInitial) {
      emit(TaskInitial(
        task: currentState.task.copyWith(
          text: '',
          date: null,
          status: false,
          importance: '',
        ),
        index: -1,
      ));
    }
  }
}
