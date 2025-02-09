import 'package:flutter/material.dart';
import 'package:packages/packages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> signup(String email, String password) async {
    final response = await AuthService.instance.signUp(email, password);

    if (response.user != null) {
      throw Exception('Login failed user login error');
    }
    _user = await AuthService.instance.fetchMyUser();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await AuthService.instance.login(email, password);

    if (response.user != null) {
      throw Exception('Login failed user login error');
    }
    _user = await AuthService.instance.fetchMyUser();
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.instance.signOut();
    _user = null;
    notifyListeners();
  }

  Stream<AuthState> getAuthState() {
    return AuthService.instance.streamAuthState();
  }
}
