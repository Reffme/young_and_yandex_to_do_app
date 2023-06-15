import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../logger/base_logger.dart';
import '../../models/TaskModel.dart';
import '../../repositories/TaskRepository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial(status: true, allTasks: [])) {
    initializeTasks();
  }

  void initializeTasks() {
    BaseLogger.log('initializeTasks() called');

    final currentState = state as TodoInitial;
    final List<TaskModel> tasks = TaskRepository().getAllTasks();
    emit(currentState.copyWith(allTasks: tasks));
  }

  void switchStatus() {
    BaseLogger.log('switchStatus() called');

    final currentState = state as TodoInitial;
    final newStatus = !currentState.status;
    emit(currentState.copyWith(status: newStatus));
  }

  void delete(final int index) {
    BaseLogger.log('delete() called with index: $index');

    final currentState = state as TodoInitial;
    final List<TaskModel> updatedTasks =
        List<TaskModel>.from(currentState.allTasks);
    updatedTasks.removeAt(index);
    emit(
      currentState.copyWith(allTasks: updatedTasks),
    );
  }

  void switchTaskStatus(final int index) {
    BaseLogger.log('switchTaskStatus() called with index: $index'); //

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
    BaseLogger.log('add() called with task: $task');

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
    BaseLogger.log('editing() called with index: $index, task: $task');

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
