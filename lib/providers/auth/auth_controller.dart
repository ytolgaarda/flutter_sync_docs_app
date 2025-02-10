import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';

final class AuthControllerState {
  final bool isLoading;
  final String? errorMessage;

  AuthControllerState({this.isLoading = false, this.errorMessage});

  AuthControllerState copyWith({bool? isLoading, String? errorMessage}) {
    return AuthControllerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthController extends StateNotifier<AuthControllerState> {
  final AuthService _service;

  AuthController(this._service) : super(AuthControllerState());

  Future<void> signup(String email, String password, String name) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final response = await _service.signUp(email, password, name);

      if (response.user == null) {
        throw Exception('Kayıt başarısız: Kullanıcı bilgisi alınamadı');
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final response = await _service.login(email, password);

      if (response.user == null) {
        throw Exception('Giriş başarısız: Kullanıcı bilgisi alınamadı');
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _service.signOut();
    state = state.copyWith(isLoading: false);
  }
}
