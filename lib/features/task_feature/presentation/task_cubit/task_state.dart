part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {

  const TaskInitial({required this.task, this.index = -1});
  final TaskModel task;
  final int index;

  @override
  List<Object> get props => [task];
}
