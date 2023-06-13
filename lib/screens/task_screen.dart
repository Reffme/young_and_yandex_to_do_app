import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, bool>?;
    final arg1 = arguments?['isEditing'];
    return const Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  PopAndSaveRowWidget(),
                  ToDoTextWidget(),
                  SizedBox(
                    height: 28,
                  ),
                  ImportantButtonWidget(),
                  SizedBox(height: 5),
                  Divider(thickness: 1),
                  TodoCalendarWidget(),
                ],
              ),
            ),
            SizedBox(height: 12),
            Divider(thickness: 1),
            DeleteButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.red,
            ),
            Text(
              'Удалить',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.red),
            )
          ],
        ));
  }
}

class TodoCalendarWidget extends StatelessWidget {
  const TodoCalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldTextWidget(text: 'Сделать до'),
            Text(
              textAlign: TextAlign.left,
              'data',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.blue),
            ),
          ],
        ),
        Expanded(
          child: SwitchListTile(
            dense: true,
            value: false,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}

class ToDoTextWidget extends StatelessWidget {
  const ToDoTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const TextField(
          minLines: 4,
          maxLines: null,
          decoration: InputDecoration(
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close_outlined, color: Colors.black),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'СОХРАНИТЬ',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class ImportantButtonWidget extends StatelessWidget {
  const ImportantButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          const BoldTextWidget(text: 'Важность'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PopupMenuButton(
            child: Text(
              'Нет',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Нет'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('Низкий'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('Высокий'),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}

class BoldTextWidget extends StatelessWidget {
  const BoldTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
