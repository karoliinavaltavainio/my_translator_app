import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/translation_controller.dart';
import '../models/translation.dart';
import 'history_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/history_button.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final outputController = TextEditingController(text: "Result here...");
  final TranslationController translationController = TranslationController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  String inputText = '';
  String inputLanguage = 'en';
  String outputLanguage = 'fr';

  List<Translation> translationHistory = [];

  @override
  void initState() {
    super.initState();
    loadTranslationHistory();
  }

  Future<void> loadTranslationHistory() async {
    List<Translation> history = await translationController.loadHistory();
    setState(() {
      translationHistory = history;
    });
  }

  Future<void> translateText() async {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final translated = await translationController.translateText(
          inputText,
          inputLanguage,
          outputLanguage,
          currentHistory: translationHistory,
        );

        Navigator.of(context).pop();
        setState(() {
          outputController.text = translated;
        });
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Translation failed: $e"),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fix the errors in red before submitting."),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _signOut() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Karoliinas Translator App",
        actions: [
          HistoryButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HistoryScreen(history: translationHistory),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
            iconColor: Colors.black,
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.black,
            tooltip: 'Sign Out',
            onPressed: _signOut,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "images/languages.jpg",
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Enter text to translate",
                      hintText: "Type here...",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        inputText = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter text to translate.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: inputLanguage,
                          decoration: const InputDecoration(
                            labelText: "From",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              inputLanguage = newValue!;
                            });
                          },
                          items: <String>['en', 'fr', 'es', 'de', 'ur', 'hi']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toUpperCase()),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.swap_horiz, color: Colors.orangeAccent),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: outputLanguage,
                          decoration: const InputDecoration(
                            labelText: "To",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              outputLanguage = newValue!;
                            });
                          },
                          items: <String>['en', 'fr', 'es', 'de', 'ur', 'hi']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toUpperCase()),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: translateText,
                    icon: const Icon(Icons.translate),
                    label: const Text("Translate"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: outputController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Translated Text",
                      hintText: "Result here...",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
