import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/services/service_providers.dart';

class CreateNoteView extends ConsumerStatefulWidget {
  final String userId;
  const CreateNoteView({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateDocViewState();
}

class _CreateDocViewState extends ConsumerState<CreateNoteView> {
  @override
  Widget build(BuildContext context) {
    final noteState = ref.watch(createNoteProvider(widget.userId));
    final viewModelNotifier =
        ref.read(createNoteProvider(widget.userId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Not Oluştur'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: viewModelNotifier.updateTitle,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: viewModelNotifier.updateContent,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              noteState.isSaving
                  ? const Center(child: CircularProgressIndicator())
                  : Text(noteState.isSaved
                      ? 'Note saved automatically!'
                      : 'Changes will be saved automatically.'),
            ],
          ),
        ),
      ),
    );
  }
}
