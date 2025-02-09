import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/auth/auth_provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password TextField
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),

            // Confirm Password TextField
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                if (_passwordController.text !=
                    _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Şifreler eşleşmiyor')),
                  );
                  return;
                }
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                try {
                  await authProvider.signup(_emailController.text,
                      _passwordController.text, 'tolga arda');

                  if (authProvider.user != null) {
                    // ignore: use_build_context_synchronously
                    if (mounted) Navigator.pop(context);
                  }
                } catch (e) {
                  authProvider.errorMessage = e.toString();
                }
              },
              child: const Text('Kaydol'), // Türkçe mesaj
            ),
          ],
        ),
      ),
    );
  }
}
