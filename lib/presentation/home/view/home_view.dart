import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sync_doc/presentation/documents/create_doc/view/create_note_view.dart';
import 'package:sync_doc/presentation/documents/list/view/documents_view.dart';
import 'package:sync_doc/providers/auth/user_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(userFutureProvider);

    return userFuture.when(
        data: (user) {
          if (user != null) {
            log("userid ${user.id}");
            return Scaffold(
                floatingActionButton: FloatingActionButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CreateNoteView(userId: user.id)));
                }),
                appBar: AppBar(title: const Text('Sync Docs')),
                body: const DocumentsListWidget());
          }
          return const Text('user fetching error');
        },
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
