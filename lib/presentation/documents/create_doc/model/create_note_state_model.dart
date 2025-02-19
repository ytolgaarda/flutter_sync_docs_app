class CreateNoteStateModel {
  final String title;
  final String content;
  final bool isSaving;
  final bool isSaved;
  final String? error;

  CreateNoteStateModel({
    required this.title,
    required this.content,
    required this.isSaving,
    required this.isSaved,
    required this.error,
  });

  factory CreateNoteStateModel.init() {
    return CreateNoteStateModel(
      title: '',
      content: '',
      isSaving: false,
      isSaved: false,
      error: null,
    );
  }

  CreateNoteStateModel copyWith({
    String? title,
    String? content,
    bool? isSaving,
    bool? isSaved,
    String? error,
  }) {
    return CreateNoteStateModel(
      title: title ?? this.title,
      content: content ?? this.content,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      error: error ?? this.error,
    );
  }
}
