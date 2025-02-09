import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sync_doc/presentation/authentication/login/view/login_view.dart';
import 'package:sync_doc/providers/auth/auth_provider.dart';

class AuthGateView extends StatelessWidget {
  const AuthGateView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: StreamBuilder<AuthState>(
        stream: authProvider.getAuthState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (authProvider.user != null) {
            return const Text('Home');
          }

          return const LoginView();
        },
      ),
    );
  }
}
