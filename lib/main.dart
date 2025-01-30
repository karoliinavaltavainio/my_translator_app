import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/history_screen.dart';
import 'models/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import the AuthGate you created
import 'services/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the platform-appropriate config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
          secondary: Colors.deepOrangeAccent,
          primary: Colors.orangeAccent, // Optional override
          onPrimary: Colors.white,       // Text color on primary
        ),

        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default TextTheme with updated properties.
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal),
          bodyLarge: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),

        // Define the default InputDecoration theme.
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.black),
        ),

        // Define ElevatedButton theme using colorScheme.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent, // Background color
            foregroundColor: Colors.white,         // Text color
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),

      // Instead of initialRoute and routes, just set the home to AuthGate
      home: const AuthGate(),

      // Keep your onGenerateRoute if you still want to navigate to /history by name
      onGenerateRoute: (settings) {
        if (settings.name == '/history') {
          final args = settings.arguments as List<Translation>;
          return MaterialPageRoute(
            builder: (context) => HistoryScreen(history: args),
          );
        }
        // If no match, return null
        return null;
      },
    );
  }
}
