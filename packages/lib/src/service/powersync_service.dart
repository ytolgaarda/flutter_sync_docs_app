import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:packages/packages.dart';

import '../models/document/schema.dart';
import 'package:powersync/powersync.dart';

class PowerSyncService {
  static PowerSyncService? _instance;
  PowerSyncService._();
  static PowerSyncService get instance {
    _instance ??= PowerSyncService._();
    return _instance!;
  }

  late final PowerSyncDatabase powerSyncDatabase;
  late final DocumentService _documentService;

  PowerSyncDatabase get db => powerSyncDatabase;

  Future<void> initialize(DocumentService documentService) async {
    _documentService = documentService;
    final dbPath = '${Directory.systemTemp.path}/powersync.db';

    powerSyncDatabase = PowerSyncDatabase(
      path: dbPath,
      schema: schema,
    );

    await powerSyncDatabase.initialize();

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> res) {
      if (res.isNotEmpty) {
        for (var connectivity in res) {
          if (connectivity != ConnectivityResult.none) {
            uploadPendingDocumentsToSupabase();
            break;
          }
        }
      }
    });
  }

  Future<void> uploadPendingDocumentsToSupabase() async {
    try {
      final pendingDocuments = await powerSyncDatabase
          .getAll('SELECT * FROM documents WHERE synced = 0');

      for (var doc in pendingDocuments) {
        final DocumentModel document = DocumentModel.fromJson(doc);
        await _documentService.saveDocumentToSupabase(document);

        await powerSyncDatabase.execute(
            'UPDATE documents SET synced = 1 WHERE id = ?', [doc['id']]);
      }
    } catch (e) {
      print('Hata: $e');
    }
  }
}
