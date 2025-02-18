import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packages/packages.dart';
import 'package:sync_doc/providers/services/service_providers.dart';

class DocumentsListWidget extends ConsumerWidget {
  const DocumentsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentState = ref.watch(documentViewModelProvider);

    return documentState.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : documentState.error != null
            ? const Center(
                child: Text('Error'),
              )
            : Column(
                children: [
                  _buildDocumentList('Notlarım', documentState.allDocs),
                ],
              );
  }

  Widget _buildDocumentList(String title, List<DocumentModel> documents) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.storage),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  return ListTile(
                    title: Text(doc.title),
                    subtitle: Text(doc.content),
                    trailing: doc.synced == 1
                        ? const Icon(Icons.cloud_done, color: Colors.green)
                        : const Icon(Icons.cloud_off, color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
