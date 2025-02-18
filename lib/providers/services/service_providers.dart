import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';

import '../../presentation/documents/list/model/document_state.dart';
import '../../presentation/documents/list/view_model/document_view_model.dart';

final documentServiceProvider = Provider((ref) => DocumentService());
final documentViewModelProvider =
    StateNotifierProvider<DocumentListViewModel, DocumentState>(
  (ref) => DocumentListViewModel(ref.read(documentServiceProvider)),
);
