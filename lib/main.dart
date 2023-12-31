import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wokwi_talkie/screens/homepage.dart';
import 'package:wokwi_talkie/screens/main_screen.dart';

import 'constant.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: primaryColor,
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}
