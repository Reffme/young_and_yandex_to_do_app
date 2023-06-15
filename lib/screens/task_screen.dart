import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/task_cubit/task_cubit.dart';
import '../blocs/todo_cubit/todo_cubit.dart';
import '../models/TaskModel.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
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
                    const PopAndSaveRowWidget(),
                    ToDoTextWidget(),
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
              const DeleteButtonWidget(),
            ],
          ),
        ),
      );
}

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () {
          final taskCubit = context.read<TaskCubit>();
          final initialState = taskCubit.state as TaskInitial;
          final index = initialState.index;
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
                  .titleMedium
                  ?.copyWith(color: Colors.red, fontSize: 18),
            ),
          ],
        ),
      );
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
    final currentState = context.read<TaskCubit>().state;
    if (currentState is TaskInitial && currentState.index != -1) {
      _selectedDate = currentState.task.date;
      _openDatePicker = _selectedDate != null;
    }
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _openDatePickerDialog(context);
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
                    .bodyLarge
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
                if (_openDatePicker) {
                  _openDatePickerDialog(context);
                } else {
                  // false switch
                  context.read<TaskCubit>().editTask(date: DateTime(9999));
                  _selectedDate = null;
                }
              });
            },
            activeColor: Colors.blue,
            activeTrackColor: Colors.lightBlue,
          ),
        ),
      ],
    );
  }

  Future<void> _openDatePickerDialog(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
      builder: (BuildContext context, Widget? child) => Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          hintColor: Colors.blue,
        ),
        child: child!,
      ),
    );

    if (selectedDate != null) {
      setState(() {
        context.read<TaskCubit>().editTask(date: selectedDate);
        _selectedDate = selectedDate;
        _openDatePicker = true;
      });
    } else {
      // Отмена DatePicker
      setState(() {
        _openDatePicker = false;
      });
      context.read<TaskCubit>().editTask(date: DateTime(9999));
      _selectedDate = null;
    }
  }
}

class ToDoTextWidget extends StatelessWidget {
  ToDoTextWidget({
    Key? key,
  }) : super(key: key);

  final TextEditingController _todoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentState = context.read<TaskCubit>().state;
    if (currentState is TaskInitial && currentState.index != -1) {
      _todoTextController.text = currentState.task.text;
    }
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          constraints: const BoxConstraints(minHeight: 150),
          child: TextField(
            maxLines: null,
            controller: _todoTextController,
            onChanged: (value) => context
                .read<TaskCubit>()
                .editTask(text: _todoTextController.text),
            decoration: const InputDecoration(
              labelText: 'Что надо сделать?',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

class PopAndSaveRowWidget extends StatelessWidget {
  const PopAndSaveRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_outlined,
            ),
          ),
          TextButton(
            onPressed: () {
              final taskCubit = context.read<TaskCubit>();
              final initialState = taskCubit.state as TaskInitial;
              final task = initialState.task;
              final index = initialState.index;
              if (index == -1) {
                final currentState = taskCubit.state;
                if (currentState is TaskInitial) {
                  final updatedTask = currentState.task;

                  context.read<TodoCubit>().add(updatedTask);
                  Navigator.of(context).pop();
                }
              } else {
                context.read<TodoCubit>().editing(index, task);
                Navigator.of(context).pop();
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

class ImportantButtonWidget extends StatefulWidget {
  const ImportantButtonWidget({Key? key}) : super(key: key);

  @override
  _ImportantButtonWidgetState createState() => _ImportantButtonWidgetState();
}

class _ImportantButtonWidgetState extends State<ImportantButtonWidget> {
  String selectedImportance = 'Нет';

  @override
  Widget build(final BuildContext context) {
    final currentState = context.read<TaskCubit>().state;
    if (currentState is TaskInitial && currentState.index != -1) {
      selectedImportance = currentState.task.importance;
    }
    return Column(
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
                  child: Text(
                    'Нет',
                  ),
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
              // color: Colors.white,
              child: Text(
                selectedImportance,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }
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
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      );
}
