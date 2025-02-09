import 'package:flutter/material.dart';
import 'package:sync_doc/providers/auth/auth_provider.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthProvider _authProvider;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _error = false;

  bool get error => _error;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LoginViewModel({
    required AuthProvider authProvider,
    required this.emailController,
    required this.passwordController,
  }) : _authProvider = authProvider;

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authProvider.login(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      _errorMessage = 'Login Failed: $e';
      _error = true;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
