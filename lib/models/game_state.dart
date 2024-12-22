import 'package:flutter/foundation.dart' show immutable;

@immutable
class GameState {
  final int chameleon;
  final int currPlayer;
  final int numPlayers;

  const GameState(
      {required this.chameleon, this.currPlayer = 0, required this.numPlayers});

  GameState copyWith({int? chameleon, int? currPlayer, int? numPlayers}) {
    return GameState(
      chameleon: chameleon ?? this.chameleon,
      currPlayer: currPlayer ?? this.currPlayer,
      numPlayers: numPlayers ?? this.numPlayers,
    );
  }
}
