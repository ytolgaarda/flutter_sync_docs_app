import 'package:flutter/services.dart';
import 'package:packages/packages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../environment/app_environment.dart';

class AppInitialize {
  static AppInitialize? _instance;
  AppInitialize._internal();
  static AppInitialize get instance {
    _instance ??= AppInitialize._internal();
    return _instance!;
  }

  void initialize() async {
    // Env initialization
    AppEnvironment.init(envType: EnvType.development);
    // Supabase initialization
    await Supabase.initialize(
        url: AppEnvironment.baseURL, anonKey: AppEnvironment.anonKey);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Powersync initialization
    await PowerSyncService.instance.initialize(DocumentService());
  }
}
