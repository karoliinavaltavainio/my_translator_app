class Translation {
  final String inputText;
  final String translatedText;
  final DateTime timestamp;

  Translation({
    required this.inputText,
    required this.translatedText,
    required this.timestamp,
  });

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation(
      inputText: map['inputText'],
      translatedText: map['translatedText'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inputText': inputText,
      'translatedText': translatedText,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Translation &&
              runtimeType == other.runtimeType &&
              inputText == other.inputText &&
              translatedText == other.translatedText &&
              timestamp == other.timestamp;

  @override
  int get hashCode =>
      inputText.hashCode ^ translatedText.hashCode ^ timestamp.hashCode;
}
