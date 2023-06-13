import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:young_and_yandex_to_do_app/blocs/fliter_cubit/todo_cubit.dart';

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
          Navigator.of(context).pushNamed('/task');
        },
        child: const Icon(
          CupertinoIcons.plus,
          color: Colors.white,
        ),
        elevation: 20,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar.medium(
          // title: Text('fhdfhfdh'),
          // ),
          //
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
              title: SizedBox(
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Мои дела",
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: [
                              TextSpan(
                                  text: "\nВыполнено - 5",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.grey))
                            ]),
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
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white, // Белый фон
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Цвет тени
                      blurRadius: 4, // Радиус размытия
                      offset: Offset(0, 2), // Смещение тени
                    ),
                  ],
                ),
                child: BlocBuilder<TodoCubit, TodoState>(
                  builder: (context, state) {
                    if (state is TodoInitial) {
                      return ListView.builder(
                        itemCount: state.allTasks.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (state.status == false) {
                            if (state.allTasks[index].status == false) {
                              return TaskTileWidget(
                                text: state.allTasks[index].text,
                                date: state.allTasks[index].date,
                                index: index,
                                status: state.allTasks[index].status,
                              );
                            } else {
                              return Container();
                            }
                          }
                          if (state.status == true) {
                            return TaskTileWidget(
                                text: state.allTasks[index].text,
                                date: state.allTasks[index].date,
                                index: index,
                                status: state.allTasks[index].status);
                          }
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
  const TaskTileWidget({
    super.key,
    required this.text,
    this.date,
    required this.index,
    required this.status,
  });

  final String text;
  final int index;
  final DateTime? date;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      background: Container(
        color: Colors.green,
        child: Align(
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
        child: Align(
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
          Navigator.of(context).pushNamed('/task',arguments: {'isEditing' : true});
        },
        leading: Checkbox(
          activeColor: Colors.green,
          value: status ? true : false,
          onChanged: (value) {},
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: date == null
            ? Container()
            : Text(DateFormat('dd MMM yyyy').format(date!)),
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
