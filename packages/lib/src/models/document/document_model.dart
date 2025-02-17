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
}
