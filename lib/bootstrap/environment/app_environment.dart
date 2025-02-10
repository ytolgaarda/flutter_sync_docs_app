import 'package:sync_doc/bootstrap/configuration/base_configuration.dart';
import 'package:sync_doc/bootstrap/configuration/development_env.dart';

enum EnvType { development }

class AppEnvironment {
  static late final BaseConfiguration _configuration;
  static late final EnvType _envType;

  AppEnvironment.init({required EnvType envType}) {
    _envType = envType;

    switch (envType) {
      case EnvType.development:
        _configuration = DevelopmentEnv();
    }
  }

  static String get anonKey => _configuration.apiKey;
  static String get baseURL => _configuration.baseURL;
  static String get currentEnvironment => _envType.name;
}
