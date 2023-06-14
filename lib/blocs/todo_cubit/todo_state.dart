part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  final List<TaskModel> allTasks;
  final bool status;


  TodoInitial({required this.allTasks, required this.status});

  @override
  List<Object> get props => [allTasks, status];

  TodoInitial copyWith({
    List<TaskModel>? allTasks,
    bool? status,
  }) {
    return TodoInitial(
      allTasks: allTasks ?? this.allTasks,
      status: status ?? this.status,
    );
  }
}
