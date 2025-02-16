import 'package:powersync/powersync.dart';

const documentsTable = 'documents';

Schema schema = Schema([
  const Table(documentsTable, [
    Column.text('title'),
    Column.text('content'),
    Column.text('update_at'),
    Column.text('created_by'),
  ], indexes: [
    Index('created_by_idx', [IndexedColumn('created_by')])
  ])
]);
