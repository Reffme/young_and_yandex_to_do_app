import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String text;
  final DateTime? date;
  final bool status;
  final String importance;

  TaskModel({
    required this.text,
    this.date,
    required this.status,
    required this.importance,
  });

  @override
  List<Object?> get props => [text, date, status, importance];

  TaskModel copyWith({
    String? text,
    DateTime? date,
    bool? status,
    String? importance,
  }) {
    return TaskModel(
      text: text ?? this.text,
      date: date ?? this.date,
      status: status ?? this.status,
      importance: importance ?? this.importance,
    );
  }
}