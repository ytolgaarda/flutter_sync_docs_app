import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sync_doc/bootstrap/initialize/app_initialize.dart';

Future<void> bootstrap(FutureOr<Widget> Function() appBuilder) async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppInitialize.instance.initialize();

    /// todo Sentry or Crashlitics init.
    runApp(await appBuilder());
  }, (error, stackTrac) async {
    log('$error', name: 'Error', stackTrace: stackTrac);
  });
}
