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

  Future<AuthResponse> signUp(
      String email, String password, String name) async {
    final response =
        await _supabaseClient.auth.signUp(email: email, password: password);

    final user = response.user;

    if (user != null) {
      await _saveUserToDatabase(
          UserModel(id: user.id, name: name, email: email));
    } else {
      throw Exception("Kullanıcı oluşturulamadı.");
    }

    return response;
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<UserModel?> fetchMyUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) return null;

    final response =
        await _supabaseClient.from('users').select().eq('id', user.id).single();

    return UserModel.fromJson(response);
  }

  Stream<AuthState> streamAuthState() => _supabaseClient.auth.onAuthStateChange;

  Future<void> _saveUserToDatabase(UserModel user) async {
    await _supabaseClient.from('users').insert(user.toJson());
  }
}
