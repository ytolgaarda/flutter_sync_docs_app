import 'package:packages/packages.dart';

class DocumentState {
  final bool isLoading;
  final bool isConnected;
  final List<DocumentModel> allDocs;
  final String? error;

  DocumentState({
    required this.isLoading,
    required this.isConnected,
    required this.allDocs,
    this.error,
  });

  factory DocumentState.initial() {
    return DocumentState(
      isLoading: false,
      isConnected: false,
      allDocs: [],
      error: null,
    );
  }

  DocumentState copyWith({
    bool? isLoading,
    bool? isConnected,
    List<DocumentModel>? allDocs,
    String? error,
  }) {
    return DocumentState(
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      allDocs: allDocs ?? this.allDocs,
      error: error ?? this.error,
    );
  }
}
