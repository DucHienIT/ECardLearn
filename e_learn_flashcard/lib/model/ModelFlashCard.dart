class FlashcardItem {
  String key; // Key hoặc ID của flashcard
  String meaning; // Nghĩa của flashcard
  String phonetic; // Phiên âm của flashcard

  FlashcardItem({
    required this.key,
    required this.meaning,
    required this.phonetic,
  });

  factory FlashcardItem.fromJson(Map<String, dynamic> json) {
    return FlashcardItem(
      key: json['key'] ?? '',
      meaning: json['meaning'] ?? '',
      phonetic: json['phonetic'] ?? '',
    );
  }
}
