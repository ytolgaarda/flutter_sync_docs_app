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

      print(connectivityResult);
      if (connectivityResult.contains(ConnectivityResult.none)) {
        await _saveDocumentToLocalDB(document);
      } else {
        await saveDocumentToSupabase(document);
      }
    } catch (e, stackTrace) {
      log("Hata oluştu: $e", name: "addNote", stackTrace: stackTrace);
    }
  }

  Future<void> _saveDocumentToLocalDB(DocumentModel document) async {
    try {
      await _syncService.db.execute(
        'INSERT INTO documents (id, title, content, update_at, created_by, synced) VALUES (uuid(), ?, ?, ?, ?, ?)',
        [
          document.title,
          document.content,
          document.update_at.toIso8601String(),
          document.created_by,
          0,
        ],
      );
      log("Doküman başarıyla yerel veritabanına kaydedildi: $document");
    } catch (e, stackTrace) {
      log("Yerel veritabanına kaydetme hatası: $e",
          name: "_saveDocumentToLocalDB", stackTrace: stackTrace);
    }
  }

  Future<String?> saveDocumentToSupabase(DocumentModel document) async {
    try {
      final existingDocumentResponse = await _supabaseClient
          .from('documents')
          .select()
          .eq('id', document.id!)
          .single();

      if (existingDocumentResponse.isNotEmpty) {
        await _supabaseClient.from('documents').update({
          'title': document.title,
          'content': document.content,
          'update_at': document.update_at.toIso8601String(),
        }).eq('id', document.id!);

        log("Doküman Supabase'de güncellendi: $document");

        await _syncService.db.execute(
          'UPDATE documents SET synced = 1 WHERE id = ?',
          [document.id],
        );
      } else {
        final response = await _supabaseClient.from('documents').upsert({
          'title': document.title,
          'content': document.content,
          'update_at': document.update_at.toIso8601String(),
          'created_by': document.created_by,
          'synced': 1,
        }).select();

        if (response.isNotEmpty) {
          final supabaseId = response.first['id'];
          log('Yeni document Supabase\'e kaydedildi, ID: $supabaseId');

          // **Yerel veritabanındaki `synced` durumunu güncelle**
          await _syncService.db.execute(
            'UPDATE documents SET id = ?, synced = 1 WHERE id = ?',
            [supabaseId, document.id],
          );
        }
      }
      return document.id; // Belgeyi Supabase'e kaydettikten sonra ID'yi döndür
    } catch (e) {
      log('Error saving document to Supabase: $e');
      return null;
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
        log(document.getInfo() ?? '');
        documents.add(document);
      }

      return documents;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<List<DocumentModel>> getAllDocumentsFromRemoteDatabase() async {
    try {
      final response = await _supabaseClient
          .from('documents')
          .select()
          .order('update_at', ascending: false);
      if (response.isEmpty) {
        log("documents empty in remote db");
        return [];
      }
      List<DocumentModel> documents = [];
      for (var row in response) {
        documents.add(DocumentModel.fromJson(row));
      }
      log("Documents from Remote DB: $documents");
      return documents;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<void> clearLocalDb() async {
    final db = _syncService.db;

    try {
      await db.execute('DROP VIEW IF EXISTS documents');
      print('Table "documents" dropped');
    } catch (e) {
      print('Veritabanı silme hatası: $e');
    }
  }
}
