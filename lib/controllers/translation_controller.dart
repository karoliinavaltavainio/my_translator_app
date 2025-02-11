import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/translation_service.dart';
import '../models/translation.dart';

class TranslationController {
  static const String historyKey = 'translation_history';

  Future<List<Translation>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString(historyKey);
    if (historyJson == null) return [];
    List<dynamic> decoded = jsonDecode(historyJson);
    return decoded.map<Translation>((item) => Translation.fromMap(item)).toList();
  }

  Future<void> saveHistory(List<Translation> history) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> historyMap =
    history.map((translation) => translation.toMap()).toList();
    String historyJson = jsonEncode(historyMap);
    await prefs.setString(historyKey, historyJson);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(historyKey);
  }

  Future<void> deleteTranslation(Translation translation) async {
    List<Translation> currentHistory = await loadHistory();
    currentHistory.removeWhere((t) =>
    t.timestamp == translation.timestamp &&
        t.inputText == translation.inputText &&
        t.translatedText == translation.translatedText);
    await saveHistory(currentHistory);
  }

  Future<String> translateText(
      String text,
      String fromLanguage,
      String toLanguage, {
        required List<Translation> currentHistory,
      }) async {
    try {
      final translatedText = await TranslationService.translateText(
        text,
        toLanguage,
        fromLanguage,
      );

      final newTranslation = Translation(
        inputText: text,
        translatedText: translatedText,
        timestamp: DateTime.now(),
      );

      currentHistory.add(newTranslation);
      await saveHistory(currentHistory);

      return translatedText;
    } catch (e) {
      print("Error in TranslationController: $e");
      throw Exception("Unable to translate");
    }
  }
}
