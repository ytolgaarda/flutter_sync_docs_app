import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sync_doc/presentation/authentication/login/view/login_view.dart';
import 'package:sync_doc/presentation/home/view/home_view.dart';
import 'package:sync_doc/providers/auth/auth_state_provider.dart';

class AuthGateView extends ConsumerWidget {
  const AuthGateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      body: authState.when(
        data: (authState) {
          if (authState?.session != null) {
            return const HomeView();
          } else {
            return const LoginView();
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Hata: $error')),
      ),
    );
  }
}


/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_doc/presentation/authentication/login/view/login_view.dart';
import 'package:sync_doc/presentation/home/view/home_view.dart';

import '../../../../providers/auth/auth_provider.dart';

class AuthGateView extends StatefulWidget {
  const AuthGateView({super.key});

  @override
  State<AuthGateView> createState() => _AuthGateViewState();
}

class _AuthGateViewState extends State<AuthGateView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Hata varsa ve hata mesajı değiştiyse SnackBar göster
          if (authProvider.errorMessage != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Hata: ${authProvider.errorMessage}')),
              );
              authProvider
                  .clearErrorMessage(); // Hatayı gösterdikten sonra temizle
            });
          }

          if (authProvider.user == null) {
            return const LoginView();
          } else {
            return const HomeView();
          }
        },
      ),
    );
  }
}
 */