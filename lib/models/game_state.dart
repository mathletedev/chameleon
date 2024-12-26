import 'package:flutter/foundation.dart' show immutable;

@immutable
class GameState {
  final int chameleon;
  final int currPlayer;
  final int numPlayers;
  final List<String> categories;
  final String category;
  final List<String> words;
  final String secretWord;

  const GameState({
    this.chameleon = -1,
    this.currPlayer = 0,
    this.numPlayers = 6,
    this.categories = const [],
    this.category = 'Inventions',
    this.words = const [],
    this.secretWord = '',
  });

  GameState copyWith({
    int? chameleon,
    int? currPlayer,
    int? numPlayers,
    List<String>? categories,
    String? category,
    List<String>? words,
    String? secretWord,
  }) {
    return GameState(
      chameleon: chameleon ?? this.chameleon,
      currPlayer: currPlayer ?? this.currPlayer,
      numPlayers: numPlayers ?? this.numPlayers,
      categories: categories ?? this.categories,
      category: category ?? this.category,
      words: words ?? this.words,
      secretWord: secretWord ?? this.secretWord,
    );
  }
}
