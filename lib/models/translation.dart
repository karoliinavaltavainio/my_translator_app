class Translation {
  final String inputText;
  final String translatedText;
  final DateTime timestamp;

  Translation({
    required this.inputText,
    required this.translatedText,
    required this.timestamp,
  });

  // Convert Translation object to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'inputText': inputText,
      'translatedText': translatedText,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create Translation object from Map
  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      inputText: map['inputText'] ?? '',
      translatedText: map['translatedText'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}