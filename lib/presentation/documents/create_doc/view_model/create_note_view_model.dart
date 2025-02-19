import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/presentation/documents/create_doc/model/create_note_state_model.dart';

class CreateNoteViewModel extends StateNotifier<CreateNoteStateModel> {
  CreateNoteViewModel(this._documentService, this._userId)
      : super(CreateNoteStateModel.init());

  final DocumentService _documentService;
  final String _userId;
  Timer? _debounceTimer;

  void updateTitle(String title) {
    state = state.copyWith(title: title);
    _debounceSave();
  }

  void updateContent(String content) {
    state = state.copyWith(content: content);
    _debounceSave();
  }

  void _debounceSave() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), _saveNote);
  }

  Future<void> _saveNote() async {
    if (state.title.isEmpty || state.content.isEmpty) return;
    if (state.isSaving) return;

    state = state.copyWith(isSaving: true);

    final document = DocumentModel(
      id: '',
      title: state.title,
      content: state.content,
      update_at: DateTime.now(),
      created_by: _userId,
      synced: 0,
    );

    try {
      _documentService.addNote(document);
      state = state.copyWith(isSaving: false, isSaved: true);
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
