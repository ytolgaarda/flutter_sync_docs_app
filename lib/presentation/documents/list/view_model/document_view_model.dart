import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';

import '../model/document_state.dart';

class DocumentListViewModel extends StateNotifier<DocumentState> {
  final DocumentService _documentService;
  final Connectivity _connectivity = Connectivity();

  DocumentListViewModel(this._documentService) : super(DocumentState.initial());

  Future<void> fetchDocuments() async {
    try {
      state = state.copyWith(isLoading: true);

      final localDocs = await _documentService.getAllDocumentsFromLocalDb();
      final remoteDocs =
          await _documentService.getAllDocumentsFromRemoteDatabase();

      final allDocs = _mergeDocuments(localDocs, remoteDocs);

      state = state.copyWith(
        isLoading: false,
        allDocs: allDocs,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  List<DocumentModel> _mergeDocuments(
      List<DocumentModel> localDocs, List<DocumentModel> remoteDocs) {
    final allDocs = <DocumentModel>[];

    for (var remoteDoc in remoteDocs) {
      final matchingLocalDoc = localDocs.firstWhere(
        (localDoc) => localDoc.id == remoteDoc.id,
        orElse: () => DocumentModel(
            id: '',
            title: '',
            content: '',
            update_at: DateTime(0),
            created_by: '',
            synced: 0),
      );

      final isLocalDocNewer =
          matchingLocalDoc.update_at.isAfter(remoteDoc.update_at);
      allDocs.add(isLocalDocNewer ? matchingLocalDoc : remoteDoc);
    }
    for (var localDoc in localDocs) {
      if (!allDocs.any((doc) => doc.id == localDoc.id)) {
        allDocs.add(localDoc);
      }
    }
    return allDocs;
  }

  Future<void> listenToConnectivity() async {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      final isConnected = result.any((res) => res != ConnectivityResult.none);
      if (isConnected) {
        fetchDocuments();
      }
      state = state.copyWith(isConnected: isConnected);
    });
  }
}
