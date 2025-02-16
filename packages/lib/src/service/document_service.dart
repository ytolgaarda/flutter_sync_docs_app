import 'dart:developer';

import 'package:packages/packages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final PowerSyncService _syncService = PowerSyncService.instance;

  void addNote(DocumentModel document) async {
    try {
      await _syncService.db.execute(
        'INSERT INTO documents (id, title, content, update_at, created_by) VALUES (uuid(),?, ?, ?, ?)',
        [
          document.title,
          document.content,
          document.update_at.toIso8601String(),
          document.created_by
        ],
      );
      log("Not başarıyla eklendi: $document");
    } catch (e, stackTrace) {
      log("Hata oluştu: $e", name: "addNote", stackTrace: stackTrace);
    }
  }

  Future<void> saveDocumentToSupabase(DocumentModel document) async {
    try {
      await _supabaseClient.from('documents').upsert({
        'title': document.title,
        'content': document.content,
        'update_at': document.update_at.toIso8601String(),
        'created_by': document.created_by,
      });

      print('Document saved successfully!');
    } catch (e) {
      print('Error saving document: $e');
    }
  }

  Future<List<DocumentModel>> getAllDocumentsFromLocalDb() async {
    try {
      final result = await _syncService.db.getAll('SELECT * FROM documents');

      if (result.isEmpty) {
        return [];
      }

      List<DocumentModel> documents = [];
      for (var row in result) {
        DocumentModel document = DocumentModel.fromJson(row);
        print(document.id);
        documents.add(document);
      }

      return documents;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }
}
