import 'package:flutter/foundation.dart' show immutable;

@immutable
class GameState {
  final int chameleon;
  final int currPlayer;
  final int numPlayers;
  final String category;
  final List<String> words;
  final String secretWord;

  const GameState({
    required this.chameleon,
    this.currPlayer = 0,
    required this.numPlayers,
    this.category = '',
    this.words = const [],
    this.secretWord = '',
  });

  GameState copyWith({
    int? chameleon,
    int? currPlayer,
    int? numPlayers,
    String? category,
    List<String>? words,
    String? secretWord,
  }) {
    return GameState(
      chameleon: chameleon ?? this.chameleon,
      currPlayer: currPlayer ?? this.currPlayer,
      numPlayers: numPlayers ?? this.numPlayers,
      category: category ?? this.category,
      words: words ?? this.words,
      secretWord: secretWord ?? this.secretWord,
    );
  }
}
