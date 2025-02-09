import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_doc/presentation/authentication/signup/view/signup_view.dart';
import 'package:sync_doc/providers/auth/auth_provider.dart';

import '../view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    _viewModel = LoginViewModel(
      authProvider: authProvider,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    );
  }

  @override
  void dispose() {
    _viewModel.emailController.dispose();
    _viewModel.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Giriş'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: viewModel.emailController,
                    decoration: const InputDecoration(labelText: 'E-posta'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Şifre'),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () async {
                            await viewModel.login();
                            if (viewModel.error) {}
                          },
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator() // Yükleniyorsa progress indicator göster
                        : const Text('Giriş'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignupView()),
                      );
                    },
                    child: const Text('Hesabın yok mu? Kaydol'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
