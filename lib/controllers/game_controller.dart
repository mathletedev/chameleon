import 'dart:math';

import 'package:chameleon/models/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const int maxPlayers = 10;
const int minPlayers = 3;

class GameController extends Notifier<GameState> {
  @override
  GameState build() => GameState(chameleon: -1, numPlayers: 6);

  void setNumPlayers(int numPlayers) {
    state = state.copyWith(
      numPlayers: numPlayers.clamp(minPlayers, maxPlayers),
    );
  }

  void startGame() {
    state = state.copyWith(
      chameleon: Random().nextInt(state.numPlayers),
      currPlayer: 0,
    );
  }
}
