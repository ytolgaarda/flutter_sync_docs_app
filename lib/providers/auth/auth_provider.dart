import 'package:flutter/material.dart';
import 'package:packages/packages.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final AuthService _service = AuthService.instance;

  AuthProvider() {
    _initialize(); // Başlatma metodunu çağır
  }

  Future<void> _initialize() async {
    // Ayrı başlatma metodu
    _isLoading = true;
    notifyListeners();
    await streamAuthChanges(); // streamAuthChanges'i await ile çağır
    _isLoading = false;
    notifyListeners();
  }

  Future<void> streamAuthChanges() async {
    // Async hale getirildi
    AuthService.instance.streamAuthState().listen((authState) async {
      // await eklendi.
      _isLoading = true; // buraya aldım.
      notifyListeners();
      if (authState.session != null && authState.session?.user != null) {
        _user = await _service.fetchMyUser();
      } else {
        _user = null;
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signup(String email, String password, String name) async {
    try {
      _isLoading = true;
      _errorMessage = null; // Hata durumunu temizle
      notifyListeners();

      final response = await _service.signUp(email, password, name);

      if (response.user == null) {
        throw Exception(
            'Kayıt başarısız: Kullanıcı bilgisi alınamadı'); // Türkçe mesaj
      }

      _user = await _service.fetchMyUser();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString(); // Hatayı string olarak sakla
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null; // Hata durumunu temizle
      notifyListeners();

      final response = await _service.login(email, password);

      if (response.user == null) {
        throw Exception(
            'Giriş başarısız: Kullanıcı bilgisi alınamadı'); // Türkçe mesaj
      }

      _user = await _service.fetchMyUser();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString(); // Hatayı string olarak sakla
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null; // Hata durumunu temizle
    notifyListeners();
    await _service.signOut();
    _user = null;
    _isLoading = false;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  set errorMessage(String? message) {
    _errorMessage = message;
    notifyListeners(); // Değişikliği dinleyicilere bildir
  }
}
