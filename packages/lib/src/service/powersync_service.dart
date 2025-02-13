import 'dart:io';
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

  Future<void> initialize() async {
    final dbPath = '${Directory.systemTemp.path}/powersync.db';

    powerSyncDatabase = PowerSyncDatabase(
      path: dbPath,
      schema: schema,
    );

    await powerSyncDatabase.initialize();
  }

  PowerSyncDatabase get db => powerSyncDatabase;
}
