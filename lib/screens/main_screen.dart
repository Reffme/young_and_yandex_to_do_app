  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:intl/intl.dart';
  import '../blocs/task_cubit/task_cubit.dart';
  import '../blocs/todo_cubit/todo_cubit.dart';
  import '../models/TaskModel.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  import '../blocs/theme_cubit/theme_cubit.dart';

  class MainScreen extends StatefulWidget {
    const MainScreen({Key? key}) : super(key: key);

    @override
    State<MainScreen> createState() => _MainScreenState();
  }

  class _MainScreenState extends State<MainScreen> {
    @override
    Widget build(BuildContext context) {
      final mediaWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
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
              leading: Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    context.read<ThemeCubit>().switchTheme();
                  },
                  icon: Icon(
                    context.watch<ThemeCubit>().state.themeData == lightTheme
                        ? Icons.brightness_7
                        : Icons.brightness_2_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              pinned: true,
              expandedHeight: 160,
              flexibleSpace: buildFlexibleSpace(mediaWidth),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              sliver: buildTaskList(),
            ),
          ],
        ),
      );
    }

    Widget buildFlexibleSpace(double mediaWidth) => FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(
            top: 15,
            bottom: 5,
            left: mediaWidth / 5,
            right: 15,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) => RichText(
                  text: TextSpan(
                    text: "Мои дела",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 32,
                        ),
                    children: [
                      TextSpan(
                        text:
                            '\nВыполнено - ${context.read<TodoCubit>().countTasksWithStatusTrue()}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                      ),
                    ],
                  ),
                ),
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
        );

    Widget buildTaskList() => SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state is TodoInitial) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: state.allTasks.length + 1,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return TextButton(
                            onPressed: () {
                              context.read<TaskCubit>().clearTask();
                              Navigator.of(context).pushNamed('/task');
                            },
                            child: Text(
                              'Новое',
                              style: Theme.of(context).textTheme.titleMedium,
                            ));
                      } else if (state.status == false) {
                        if (state.allTasks[index - 1].status == false) {
                          return TaskTileWidget(
                            index: index - 1,
                            task: state.allTasks[index - 1],
                          );
                        } else {
                          return Container();
                        }
                      } else if (state.status == true) {
                        return TaskTileWidget(
                            index: index - 1, task: state.allTasks[index - 1]);
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
        );
  }

  class TaskTileWidget extends StatelessWidget {
    TaskTileWidget({
      Key? key,
      required this.index,
      required this.task,
    }) : super(key: key);

    final TaskModel task;
    final int index;

    Widget getImportanceIcon() {
      if (task.importance.contains('Высокий')) {
        return const FaIcon(
          FontAwesomeIcons.exclamation,
          color: Colors.red,
          size: 18,
        );
      } else if (task.importance.contains('Низкий')) {
        return const Icon(
          Icons.arrow_downward,
          color: Colors.grey,
          size: 18,
        );
      } else {
        return Container();
      }
    }

    @override
    Widget build(BuildContext context) => Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          background: buildLeftBackground(),
          secondaryBackground: buildRightBackground(),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              context.read<TodoCubit>().delete(index);
            } else if (direction == DismissDirection.startToEnd) {
              context.read<TodoCubit>().switchTaskStatus(index);
            }
          },
          child: ListTile(
            onTap: () {
              context.read<TaskCubit>().editTask(
                    text: task.text,
                    status: task.status,
                    date: task.date,
                    importance: task.importance,
                    index: index,
                  );
              Navigator.of(context).pushNamed('/task');
            },
            leading: Checkbox(
              activeColor: Colors.green,
              value: task.status,
              onChanged: (value) {
                context.read<TodoCubit>().switchTaskStatus(index);
              },
            ),
            title: Row(
              children: [
                getImportanceIcon(),
                SizedBox(width: 6),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: task.text,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: task.status == true
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.status == false &&
                                    task.importance.contains('Высокий')
                                ? Colors.red
                                : Theme.of(context).textTheme.titleMedium?.color,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            subtitle: task.date != null
                ? Row(
                    children: [
                      SizedBox(width: 6),
                      Text(DateFormat('dd.MM.yyyy').format(task.date!)),
                    ],
                  )
                : Container(),
            trailing: const Icon(
              Icons.info_outline,
              color: Colors.grey,
            ),
          ),
        );

    Container buildLeftBackground() => Container(
          color: task.status ? Colors.grey : Colors.green,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: task.status
                  ? const Icon(
                      Icons.settings_backup_restore,
                    )
                  : const Icon(
                      Icons.check,
                    ),
            ),
          ),
        );

    Container buildRightBackground() => Container(
          height: 100,
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        );
  }
