class Chapter {
  final int id;
  final String name;
  final String slug;
  final String nameTransliterated;
  final String nameTranslated;
  final int versesCount;
  final int chapterNumber;
  final String nameMeaning;
  final String chapterSummary;
  final String chapterSummaryHindi;

  Chapter({
    required this.id,
    required this.name,
    required this.slug,
    required this.nameTransliterated,
    required this.nameTranslated,
    required this.versesCount,
    required this.chapterNumber,
    required this.nameMeaning,
    required this.chapterSummary,
    required this.chapterSummaryHindi,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      nameTransliterated: json['name_transliterated'],
      nameTranslated: json['name_translated'],
      versesCount: json['verses_count'],
      chapterNumber: json['chapter_number'],
      nameMeaning: json['name_meaning'],
      chapterSummary: json['chapter_summary'],
      chapterSummaryHindi: json['chapter_summary_hindi'],
    );
  }
}
