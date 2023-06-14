import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:young_and_yandex_to_do_app/blocs/task_cubit/task_cubit.dart';
import 'package:young_and_yandex_to_do_app/blocs/todo_cubit/todo_cubit.dart';
import 'package:young_and_yandex_to_do_app/models/TaskModel.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);

  final TextEditingController _todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  PopAndSaveRowWidget(
                    todoTextController: _todoTextController,
                  ),
                  ToDoTextWidget(controller: _todoTextController),
                  const SizedBox(height: 28),
                  const ImportantButtonWidget(),
                  const SizedBox(height: 5),
                  const Divider(thickness: 1),
                  const TodoCalendarWidget(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(thickness: 1),
            const DeleteButtonWidget(
              index: -1,
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    Key? key,
    this.index = -1,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (index == -1) {
          Navigator.of(context).pop();
        } else {
          context.read<TodoCubit>().delete(index);
          Navigator.of(context).pop();
        }
      },
      child: Row(
        children: [
          const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          Text(
            'Удалить',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class TodoCalendarWidget extends StatefulWidget {
  const TodoCalendarWidget({Key? key}) : super(key: key);

  @override
  State<TodoCalendarWidget> createState() => _TodoCalendarWidgetState();
}

class _TodoCalendarWidgetState extends State<TodoCalendarWidget> {
  bool _openDatePicker = false;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2024),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.blue, // Цвет выбора даты
                    hintColor: Colors.blue, // Цвет кнопки "Выбрать"
                  ),
                  child: child!,
                );
              },
            ).then((selectedDate) {
              if (selectedDate != null) {
                setState(() {
                  context.read<TaskCubit>().editTask(date: selectedDate);
                  _selectedDate = selectedDate;
                  _openDatePicker = true;
                });
              } else {
                setState(() {
                  context.read<TaskCubit>().editTask(date: null);
                  _selectedDate = null;
                  _openDatePicker = false;
                });
              }
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BoldTextWidget(text: 'Сделать до'),
              Text(
                _selectedDate != null
                    ? DateFormat('dd.MM.yyyy').format(_selectedDate!)
                    : 'Не выбрано',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
        Expanded(
          child: SwitchListTile(
            dense: true,
            value: _openDatePicker,
            onChanged: (value) {
              setState(() {
                _openDatePicker = value;
                if (!value) {
                  _selectedDate = null;
                }
              });
            },
            activeColor: Colors.blue, // Цвет активного состояния
            activeTrackColor: Colors.lightBlue, // Цвет активного трека
          ),
        ),
      ],
    );
  }
}

class ToDoTextWidget extends StatelessWidget {
  const ToDoTextWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: TextField(
          minLines: 1,
          maxLines: 10,
          controller: controller,
          onSubmitted: (value) {},
          decoration: const InputDecoration(
            labelText: 'Что надо сделать?',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class PopAndSaveRowWidget extends StatelessWidget {
  const PopAndSaveRowWidget({
    Key? key,
    required this.todoTextController,
  }) : super(key: key);

  final TextEditingController todoTextController;

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    final initialState = taskCubit.state as TaskInitial;
    final task = initialState.task;
    final index = initialState.index;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close_outlined, color: Colors.black),
        ),
        TextButton(
          onPressed: () {
            if (index == -1) {
              context.read<TaskCubit>().editTask(text: todoTextController.text);
              context.read<TodoCubit>().add(task);
              Navigator.of(context).pop();
            } else {
              context.read<TodoCubit>().editing(index, task);
            }
          },
          child: const Text(
            'СОХРАНИТЬ',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class ImportantButtonWidget extends StatefulWidget {
  const ImportantButtonWidget({Key? key}) : super(key: key);

  @override
  _ImportantButtonWidgetState createState() => _ImportantButtonWidgetState();
}

class _ImportantButtonWidgetState extends State<ImportantButtonWidget> {
  String selectedImportance = 'Нет';

  @override
  Widget build(final BuildContext context) => Column(
      children: [
        const Row(
          children: [
            BoldTextWidget(text: 'Важность'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Нет',
                  child: Text('Нет'),
                ),
                const PopupMenuItem(
                  value: 'Низкий',
                  child: Text('Низкий'),
                ),
                const PopupMenuItem(
                  value: 'Высокий',
                  child: Text('Высокий'),
                ),
              ],
              onSelected: (value) {
                setState(() {
                  context.read<TaskCubit>().editTask(importance: value);
                  selectedImportance = value;
                });
              },
              color: Colors.white,
              child: Text(
                selectedImportance,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.grey),
              ), // Цвет фона меню
            ),
          ],
        ),
      ],
    );
}

class BoldTextWidget extends StatelessWidget {
  const BoldTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(final BuildContext context) => Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.bold),
    );
}
