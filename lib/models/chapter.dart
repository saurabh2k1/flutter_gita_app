class Chapter {
  final int chapterNumber;
  final int versesCount;
  final String name;
  final String translation;
  final String transliteration;
  final Map<String, String> meaning;
  final Map<String, String> summary;

  Chapter({
    required this.chapterNumber,
    required this.versesCount,
    required this.name,
    required this.translation,
    required this.transliteration,
    required this.meaning,
    required this.summary,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterNumber: json['chapter_number'],
      versesCount: json['verses_count'],
      name: json['name'],
      translation: json['translation'],
      transliteration: json['transliteration'],
      meaning: Map<String, String>.from(json['meaning']),
      summary: Map<String, String>.from(json['summary']),
    );
  }
}
