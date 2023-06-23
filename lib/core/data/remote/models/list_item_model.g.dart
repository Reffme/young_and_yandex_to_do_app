// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListItemModel _$ListItemModelFromJson(Map<String, dynamic> json) =>
    ListItemModel(
      id: json['id'] as String,
      text: json['text'] as String,
      importance: json['importance'] as String,
      deadline: json['deadline'] as int?,
      done: json['done'] as bool,
      color: json['color'] as String?,
      createdAt: json['createdAt'] as int,
      changedAt: json['changedAt'] as int,
      lastUpdatedBy: json['lastUpdatedBy'] as String,
    );

Map<String, dynamic> _$ListItemModelToJson(ListItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'importance': instance.importance,
      'deadline': instance.deadline,
      'done': instance.done,
      'color': instance.color,
      'createdAt': instance.createdAt,
      'changedAt': instance.changedAt,
      'lastUpdatedBy': instance.lastUpdatedBy,
    };

ListResponseModel _$ListResponseModelFromJson(Map<String, dynamic> json) =>
    ListResponseModel(
      status: json['status'] as String,
      list: (json['list'] as List<dynamic>)
          .map((e) => ListItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$ListResponseModelToJson(ListResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'list': instance.list,
      'revision': instance.revision,
    };

ElementResponseModel _$ElementResponseModelFromJson(
        Map<String, dynamic> json) =>
    ElementResponseModel(
      status: json['status'] as String,
      element: ListItemModel.fromJson(json['element'] as Map<String, dynamic>),
      revision: json['revision'] as int,
    );

Map<String, dynamic> _$ElementResponseModelToJson(
        ElementResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'element': instance.element,
      'revision': instance.revision,
    };

ErrorResponseModel _$ErrorResponseModelFromJson(Map<String, dynamic> json) =>
    ErrorResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorResponseModelToJson(ErrorResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
