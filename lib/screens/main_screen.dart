import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:young_and_yandex_to_do_app/blocs/task_cubit/task_cubit.dart';
import 'package:young_and_yandex_to_do_app/blocs/todo_cubit/todo_cubit.dart';
import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQWidh = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TaskCubit>().clearTask();
          Navigator.of(context).pushNamed('/task');
        },
        elevation: 20,
        child: const Icon(
          CupertinoIcons.plus,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                top: 15,
                bottom: 5,
                left: mediaQWidh / 5,
                right: 15,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<TodoCubit, TodoState>(
                    builder: (context, state) {
                      return RichText(
                        text: TextSpan(
                          text: "Мои дела",
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: [
                            TextSpan(
                              text:
                              "\nВыполнено - ${context.read<TodoCubit>().countTasksWithStatusTrue()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  BlocBuilder<TodoCubit, TodoState>(
                    builder: (context, state) {
                      if (state is TodoInitial) {
                        return IconButton(
                          onPressed: () {
                            context.read<TodoCubit>().switchStatus();
                          },
                          icon: Icon(
                            state.status
                                ? CupertinoIcons.eye_solid
                                : CupertinoIcons.eye_slash,
                            color: Colors.blue,
                            size: 20,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: BlocBuilder<TodoCubit, TodoState>(
                  builder: (context, state) {
                    if (state is TodoInitial) {
                      return ListView.builder(
                        itemCount: state.allTasks.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (state.status == false) {
                            if (state.allTasks[index].status == false) {
                              return TaskTileWidget(
                                index: index,
                                task: state.allTasks[index],
                              );
                            } else {
                              return Container();
                            }
                          }
                          if (state.status == true) {
                            return TaskTileWidget(
                                index: index, task: state.allTasks[index]);
                          }
                          return Container();
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TaskTileWidget extends StatelessWidget {
  TaskTileWidget({
    Key? key,
    required this.index,
    required this.task,
  }) : super(key: key);

  final TaskModel task;
  final int index;
  String _titleText = '';

  @override
  Widget build(BuildContext context) {
    if (task.importance.contains('Высокий')) {
      _titleText += '!! ${task.text}';
    } else if (task.importance.contains('Низкий')) {
      _titleText += '↓ ${task.text}';
    } else {
      _titleText += task.text;
    }

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.green,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
      secondaryBackground: Container(
        height: 100,
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          context.read<TodoCubit>().delete(index);
        } else if (direction == DismissDirection.startToEnd) {
          context.read<TodoCubit>().switchTaskStatus(index);
        }
      },
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/task');
        },
        leading: Checkbox(
          activeColor: Colors.green,
          value: task.status,
          onChanged: (value) {},
        ),
        title: RichText(
          text: TextSpan(
            text: _titleText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                decoration: task.status == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color:
                    task.status == false && task.importance.contains('Высокий')
                        ? Colors.red
                        : Colors.black),
          ),
        ),
        subtitle: task.date != null
            ? Text(DateFormat('dd MM yyyy').format(task.date!))
            : Container(),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.info_outline,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
