class Card {
  final String category;
  final List<String> words;

  Card({
    required this.category,
    required this.words,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        category: json['category'],
        words: (json['words'] as List).map((x) => x as String).toList(),
      );
}
