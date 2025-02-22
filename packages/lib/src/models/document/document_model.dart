// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'document_model.g.dart';

@JsonSerializable()
class DocumentModel {
  String? id;
  final String title;
  final String content;
  final DateTime update_at;
  final String created_by;
  final int synced;

  DocumentModel({
    this.id,
    required this.title,
    required this.content,
    required this.update_at,
    required this.created_by,
    required this.synced,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  String? getInfo() => '$id, $title $content, $created_by, $update_at, $synced';

  DocumentModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? update_at,
    String? created_by,
    int? synced,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      update_at: update_at ?? this.update_at,
      created_by: created_by ?? this.created_by,
      synced: synced ?? this.synced,
    );
  }
}
