// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    DocumentModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      update_at: DateTime.parse(json['update_at'] as String),
      created_by: json['created_by'] as String,
      synced: (json['synced'] as num).toInt(),
    );

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'update_at': instance.update_at.toIso8601String(),
      'created_by': instance.created_by,
      'synced': instance.synced,
    };
