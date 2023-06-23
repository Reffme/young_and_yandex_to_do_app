import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {

  TaskModel({
    required this.id,
    required this.text,
    required this.date,
    required this.status,
    required this.importance,
  });
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String text;

  @HiveField(2)
  late DateTime? date;

  @HiveField(3)
  late bool status;

  @HiveField(4)
  late String importance;

  TaskModel copyWith({
    String? id,
    String? text,
    DateTime? date,
    bool? status,
    String? importance,
  }) {
    return TaskModel(
      id: id ?? this.id,
      text: text ?? this.text,
      date: date ?? this.date,
      status: status ?? this.status,
      importance: importance ?? this.importance,
    );
  }
}
// class TaskModel extends Equatable {
//   final String text;
//   final DateTime? date;
//   final bool status;
//   final String importance;
//
//   TaskModel({
//     required this.text,
//     this.date,
//     required this.status,
//     required this.importance,
//   });
//
//   @override
//   List<Object?> get props => [text, date, status, importance];
//
//   TaskModel copyWith({
//     String? text,
//     DateTime? date,
//     bool? status,
//     String? importance,
//   }) =>
//       TaskModel(
//         text: text ?? this.text,
//         date: date ?? this.date,
//         status: status ?? this.status,
//         importance: importance ?? this.importance,
//       );
// }
