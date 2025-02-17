import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:packages/packages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DocumentService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final PowerSyncService _syncService = PowerSyncService.instance;

  void addNote(DocumentModel document) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none)) {
        await _syncService.db.execute(
          'INSERT INTO documents (id, title, content, update_at, created_by, synced) VALUES (uuid(),?, ?, ?, ?, ?)',
          [
            document.title,
            document.content,
            document.update_at.toIso8601String(),
            document.created_by,
            0,
          ],
        );
        log("Doküman başarıyla yerel veritabanına kaydedildi: $document");
      } else {
        await saveDocumentToSupabase(document);
        await _syncService.db.execute(
            'UPDATE documents SET synced = 1 WHERE id = ?', [document.id]);
      }
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
        'synced': document.synced,
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
        print("boş");
        return [];
      }

      List<DocumentModel> documents = [];
      for (var row in result) {
        DocumentModel document = DocumentModel.fromJson(row);
        print(document.synced);
        documents.add(document);
      }
      print("documents");
      return documents;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<void> clearLocalDb() async {
    final db = _syncService.db;

    try {
      final tables = await db
          .getAll('SELECT name FROM sqlite_master WHERE type="documents"');

      // Her tabloyu sil
      for (var table in tables) {
        final tableName = table['name'];
        await db.execute('DROP TABLE IF EXISTS $tableName');
        print('Table $tableName dropped');
      }
    } catch (e) {
      print('Veritabanı silme hatası: $e');
    }
  }
}
