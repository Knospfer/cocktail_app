import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dependency_injection.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  await configureDependencies();
  runApp(const App());
}
