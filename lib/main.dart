import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salah/salah_app.dart';
import 'package:salah/firebase_options.dart';
import 'package:salah/local_database/prefs_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PrefsManager.instance.init();
  runApp(SalahApp());
}
