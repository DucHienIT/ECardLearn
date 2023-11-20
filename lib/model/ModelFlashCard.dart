class FlashcardItem {
  String key; // Key hoặc ID của flashcard
  String meaning; // Nghĩa của flashcard
  String phonetic; // Phiên âm của flashcard

  FlashcardItem({
    required this.key,
    required this.meaning,
    required this.phonetic,
  });
}