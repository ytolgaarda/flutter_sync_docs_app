import 'package:packages/src/models/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static AuthService? _instance;

  AuthService._();

  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> login(String email, String password) async {
    final response = await _supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    return response;
  }

  Future<AuthResponse> signUp(String email, String password) async {
    final response =
        await _supabaseClient.auth.signUp(email: email, password: password);
    return response;
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<UserModel?> fetchMyUser() async {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;

    if (user != null) {
      return UserModel.fromJson(user.toJson());
    } else {
      return null;
    }
  }

  Stream<AuthState> streamAuthState() => _supabaseClient.auth.onAuthStateChange;
}
