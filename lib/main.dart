import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:minito/app.dart';
import 'package:minito/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initialise hive for lightweight key-value storage
  await Hive.initFlutter();

  runApp(
    // use ProviderScope to house all providers
    const ProviderScope(child: Minito()),
  );
}
