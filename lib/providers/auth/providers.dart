import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/providers/auth/auth_controller.dart';

final authServiceProvider =
    Provider<AuthService>((ref) => AuthService.instance);

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthControllerState>((ref) {
  final service = ref.watch<AuthService>(authServiceProvider);
  return AuthController(service);
});
