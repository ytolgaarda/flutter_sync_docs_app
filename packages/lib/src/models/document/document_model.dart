import 'package:json_annotation/json_annotation.dart';

part 'document_model.g.dart';

@JsonSerializable()
class DocumentModel {
  final String id;
  final String title;
  final String content;
  final DateTime updateAt;

  DocumentModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.updateAt});

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);
}
