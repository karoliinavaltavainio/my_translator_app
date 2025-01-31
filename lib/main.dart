import 'package:flutter/material.dart';
import 'views/history_screen.dart';
import 'models/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'services/auth_gate.dart';

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
      title: 'Translator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
          secondary: Colors.deepOrangeAccent,
          primary: Colors.orangeAccent,
          onPrimary: Colors.white,
        ),

        fontFamily: 'Montserrat',

        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
          bodyLarge: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.black),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),

      home: const AuthGate(),

      onGenerateRoute: (settings) {
        if (settings.name == '/history') {
          final args = settings.arguments as List<Translation>;
          return MaterialPageRoute(
            builder: (context) => HistoryScreen(history: args),
          );
        }
        return null;
      },
    );
  }
}
