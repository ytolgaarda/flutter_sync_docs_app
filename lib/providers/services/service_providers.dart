import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/presentation/documents/create_doc/view_model/create_note_view_model.dart';

import '../../presentation/documents/create_doc/model/create_note_state_model.dart';
import '../../presentation/documents/list/model/document_state.dart';
import '../../presentation/documents/list/view_model/document_view_model.dart';

final documentServiceProvider = Provider((ref) => DocumentService());
//
final documentViewModelProvider =
    StateNotifierProvider<DocumentListViewModel, DocumentState>(
  (ref) => DocumentListViewModel(ref.read(documentServiceProvider)),
);

final createNoteProvider = StateNotifierProvider.family<CreateNoteViewModel,
    CreateNoteStateModel, String>((ref, uid) {
  final service = ref.watch(documentServiceProvider);
  return CreateNoteViewModel(service, uid);
});
