import 'package:flutter/material.dart';
import 'package:diary/app.dart';
import 'package:diary/api.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppAPI().init();
  runApp(App());
}
