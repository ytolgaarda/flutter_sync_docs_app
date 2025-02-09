import 'package:envied/envied.dart';
import 'package:sync_doc/bootstrap/configuration/base_configuration.dart';

part 'development_env.g.dart';

@Envied(path: 'env/.development.env', obfuscate: true)
final class DevelopmentEnv implements BaseConfiguration {
  @EnviedField(varName: 'ANON_KEY')
  static final String _anonKey = _DevelopmentEnv._anonKey;
  @EnviedField(varName: 'BASE_URL')
  static final String _baseURL = _DevelopmentEnv._baseURL;

  @override
  String get apiKey => _anonKey;

  @override
  String get baseURL => _baseURL;
}
