import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';

import '../../../../providers/services/service_providers.dart';

class EditDocumentView extends ConsumerStatefulWidget {
  final DocumentModel document;
  const EditDocumentView({
    super.key,
    required this.document,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditDocumentViewState();
}

class _EditDocumentViewState extends ConsumerState<EditDocumentView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  Timer? _debounceTimer;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.document.title);
    _contentController = TextEditingController(text: widget.document.content);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _debounceSave() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), _syncDocument);
  }

  Future<void> _syncDocument() async {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final document = widget.document.copyWith(
      title: _titleController.text,
      content: _contentController.text,
      update_at: DateTime.now(),
      synced: 0,
    );

    try {
      ref.read(documentServiceProvider).addNote(document);

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Document Synced!")));
    } catch (e) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error syncing document")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Document"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _debounceSave(); // Yazma işlemi devam ettikçe senkronizasyonu erteleyin
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
              onChanged: (value) {
                _debounceSave(); // Yazma işlemi devam ettikçe senkronizasyonu erteleyin
              },
            ),
            const SizedBox(height: 20),
            if (_isSaving)
              const CircularProgressIndicator(), // Senkronize edilirken bir loading spinner'ı göster
          ],
        ),
      ),
    );
  }
}
