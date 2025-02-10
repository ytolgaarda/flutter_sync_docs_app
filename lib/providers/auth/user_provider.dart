import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/providers/auth/providers.dart';

final userStateProvider =
    StateProvider<UserModel?>((ref) => null); // Başlangıç değeri null

final userFutureProvider = FutureProvider<UserModel?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return authService.fetchMyUser();
});
