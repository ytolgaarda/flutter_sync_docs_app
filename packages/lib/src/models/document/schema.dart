import 'package:powersync/powersync.dart';

const notesTable = 'notes';

Schema schema = Schema(([
  const Table(notesTable, [
    Column.text('id'), // UUID olarak kullanılabilir
    Column.text('content'), // Not içeriği
    Column.integer('created_at'), // Unix timestamp formatında zaman
    Column.integer('last_updated_at'), // Son güncellenme zamanı
  ], indexes: [
    Index('created_index', [IndexedColumn('created_at')])
  ]),
]));
