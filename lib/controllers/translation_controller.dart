import 'package:translator/translator.dart' as translator;
import '../models/translation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationController {
  final translator.GoogleTranslator _translator = translator.GoogleTranslator();
  static const String historyKey = 'translation_history';

  // Load translation history from SharedPreferences
  Future<List<Translation>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString(historyKey);
    if (historyJson == null) return [];
    List<dynamic> decoded = jsonDecode(historyJson);
    return decoded.map<Translation>((item) => Translation.fromMap(item)).toList();
  }

  // Save translation history to SharedPreferences
  Future<void> saveHistory(List<Translation> history) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> historyMap =
    history.map((translation) => translation.toMap()).toList();
    String historyJson = jsonEncode(historyMap);
    await prefs.setString(historyKey, historyJson);
  }

  // Clear entire translation history
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(historyKey);
  }

  // Translate text and add to history
  Future<String> translateText(
      String text,
      String fromLanguage,
      String toLanguage, {
        required List<Translation> currentHistory,
      }) async {
    try {
      final translation = await _translator.translate(text, from: fromLanguage, to: toLanguage);
      final newTranslation = Translation(
        inputText: text,
        translatedText: translation.text,
        timestamp: DateTime.now(),
      );
      currentHistory.add(newTranslation);
      await saveHistory(currentHistory);
      return translation.text;
    } catch (e) {
      print("Error in TranslationController: $e");
      return "Error: Unable to translate";
    }
  }
}
