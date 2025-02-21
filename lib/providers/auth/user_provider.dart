import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/providers/auth/providers.dart';

final userFutureProvider = FutureProvider<UserModel?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return authService.fetchMyUser();
});
