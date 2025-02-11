import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String _apiKey = 'AIzaSyDf90kmoypm8Sf4ItEhx1BQGqO9UaHLOb4';

  static Future<String> translateText(String text, String targetLang, [String? sourceLang]) async {
    final url = Uri.parse(
      'https://translation.googleapis.com/language/translate/v2?key=$_apiKey',
    );

    final bodyMap = <String, dynamic>{
      'q': text,
      'target': targetLang,
      'format': 'text',
    };

    if (sourceLang != null && sourceLang.isNotEmpty) {
      bodyMap['source'] = sourceLang;
    }

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bodyMap),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['data']['translations'][0]['translatedText'];
    } else {
      print('Viga: ${response.statusCode} - ${response.body}');
      throw Exception('Translation failed');
    }
  }
}
