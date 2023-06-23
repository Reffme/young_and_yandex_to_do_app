import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/source/models/task_model.dart';
import '../../../../core/data/source/repositories/task_repository.dart';


part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TaskRepository _taskRepository;

  TodoCubit(this._taskRepository) : super(TodoInitial(status: true, allTasks: [])) {
    initializeTasks();
  }

  void initializeTasks() {
    final currentState = state as TodoInitial;
    final List<TaskModel> tasks = _taskRepository.getAllTasks();
    emit(currentState.copyWith(allTasks: tasks));
  }

  void switchStatus() {
    final currentState = state as TodoInitial;
    final newStatus = !currentState.status;
    emit(currentState.copyWith(status: newStatus));
  }

  void delete(int index) {
    final currentState = state as TodoInitial;
    final List<TaskModel> updatedTasks =
    List<TaskModel>.from(currentState.allTasks);
    _taskRepository.deleteTask(index); // Delete task from the repository
    updatedTasks.removeAt(index);
    emit(
      currentState.copyWith(allTasks: updatedTasks),
    );
  }

  void switchTaskStatus(int index) {
    final currentState = state as TodoInitial;
    final updatedTasks = List<TaskModel>.from(currentState.allTasks);
    final task = updatedTasks[index];
    final newStatus = !task.status;
    final updatedTask = task.copyWith(status: newStatus);
    _taskRepository.updateTask(updatedTask); // Update task in the repository
    updatedTasks[index] = updatedTask;
    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  void add(TaskModel task) {
    final currentState = state as TodoInitial;
    _taskRepository.addTask(task); // Add task to the repository
    final updatedTasks = List<TaskModel>.from(currentState.allTasks);
    updatedTasks.add(task);
    emit(
      currentState.copyWith(
        allTasks: updatedTasks,
      ),
    );
  }

  void editing(int index, TaskModel task) {
    final currentState = state as TodoInitial;
    _taskRepository.updateTask(task); // Update task in the repository
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
    return currentState.allTasks.where((task) => task.status).length;
  }
}
