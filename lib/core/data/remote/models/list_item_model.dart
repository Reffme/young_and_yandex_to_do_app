import 'package:json_annotation/json_annotation.dart';

part 'list_item_model.g.dart';

@JsonSerializable()
class ListItemModel {

  ListItemModel({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  factory ListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ListItemModelFromJson(json);
  final String id;
  final String text;
  final String importance;
  final int? deadline;
  final bool done;
  final String? color;
  final int createdAt;
  final int changedAt;
  final String lastUpdatedBy;

  Map<String, dynamic> toJson() => _$ListItemModelToJson(this);
}

@JsonSerializable()
class ListResponseModel {

  ListResponseModel({
    required this.status,
    required this.list,
    required this.revision,
  });

  factory ListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ListResponseModelFromJson(json);
  final String status;
  final List<ListItemModel> list;
  final int revision;

  Map<String, dynamic> toJson() => _$ListResponseModelToJson(this);
}

@JsonSerializable()
class ElementResponseModel {

  ElementResponseModel({
    required this.status,
    required this.element,
    required this.revision,
  });

  factory ElementResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ElementResponseModelFromJson(json);
  final String status;
  final ListItemModel element;
  final int revision;

  Map<String, dynamic> toJson() => _$ElementResponseModelToJson(this);
}

@JsonSerializable()
class ErrorResponseModel {

  ErrorResponseModel({
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);
  final int statusCode;
  final String message;

  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}
