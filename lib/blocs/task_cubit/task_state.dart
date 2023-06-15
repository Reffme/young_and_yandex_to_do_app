part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  final TaskModel task;
  final int index;

  TaskInitial({required this.task, this.index = -1});

  @override
  List<Object> get props => [task];
}
