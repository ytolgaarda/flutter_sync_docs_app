import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sync_doc/presentation/authentication/signup/view/signup_view.dart';
import 'package:sync_doc/providers/auth/auth_controller.dart';
import 'package:sync_doc/providers/auth/providers.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final authControllerState = ref.watch(authControllerProvider);

    String? errorMessage = authControllerState.errorMessage;

    bool isLoading = authControllerState.isLoading;

    void login() async {
      try {
        await ref
            .read<AuthController>(authControllerProvider.notifier)
            .login(_emailController.text, _passwordController.text);
      } catch (e) {
        log(e.toString());
        if (errorMessage != null && errorMessage.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(errorMessage), backgroundColor: Colors.red),
            );
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // E-posta alanı
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-posta'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Şifre alanı
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Şifre'),
            ),
            const SizedBox(height: 16),

            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading)
              ElevatedButton(
                onPressed: login,
                child: const Text('Giriş Yap'),
              ),
            const SizedBox(height: 56),
            TextButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignUpView())),
                child: const Text('Henüz hesabın yok mu? Kayıt Ol'))
          ],
        ),
      ),
    );
  }
}
