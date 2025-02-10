import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers.dart';

final authStateProvider = StreamProvider<AuthState?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.streamAuthState();
});
