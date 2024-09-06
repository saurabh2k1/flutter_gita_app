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

class Translation {
  final int id;
  final String description;
  final String authorName;
  final String language;

  Translation({
    required this.id,
    required this.description,
    required this.authorName,
    required this.language,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: json['id'],
      description: json['description'],
      authorName: json['author_name'],
      language: json['language'],
    );
  }
}

class Commentary {
  final int id;
  final String description;
  final String authorName;
  final String language;

  Commentary({
    required this.id,
    required this.description,
    required this.authorName,
    required this.language,
  });

  factory Commentary.fromJson(Map<String, dynamic> json) {
    return Commentary(
      id: json['id'],
      description: json['description'],
      authorName: json['author_name'],
      language: json['language'],
    );
  }
}

class Verse {
  final int id;
  final int verseNumber;
  final int chapterNumber;
  final String text;
  final String transliteration;
  final String wordMeanings;
  final List<Translation> translations;
  final List<Commentary> commentaries;

  Verse({
    required this.id,
    required this.verseNumber,
    required this.chapterNumber,
    required this.text,
    required this.translations,
    required this.wordMeanings,
    required this.transliteration,
    required this.commentaries,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    var translationsList = json['translations'] as List;
    List<Translation> translations =
        translationsList.map((i) => Translation.fromJson(i)).toList();

    var commentariesList = json['commentaries'] as List;
    List<Commentary> commentaries =
        commentariesList.map((i) => Commentary.fromJson(i)).toList();

    return Verse(
      id: json['id'],
      verseNumber: json['verse_number'],
      chapterNumber: json['chapter_number'],
      text: json['text'],
      transliteration: json['transliteration'],
      wordMeanings: json['word_meanings'],	
      translations: translations,
      commentaries: commentaries,
    );
  }
}
