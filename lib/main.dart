import 'package:advance_flutter_exam/firebase_options.dart';
import 'package:advance_flutter_exam/screens/pages/fetch_page.dart';
import 'package:advance_flutter_exam/screens/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => const HomePage(),
        'fetch': (_) => const FetchPage(),
      },
    );
  }
}
