import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chameleon/models/card.dart';
import 'package:chameleon/models/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const int maxPlayers = 10;
const int minPlayers = 3;

class GameController extends Notifier<GameState> {
  late List<Card> _cards;

  GameController() {
    File('assets/cards.json').readAsString().then((contents) {
      _cards =
          (jsonDecode(contents) as List).map((x) => Card.fromJson(x)).toList();
    });
  }

  @override
  GameState build() => GameState(chameleon: -1, numPlayers: 6);

  void setNumPlayers(int numPlayers) {
    state = state.copyWith(
      numPlayers: numPlayers.clamp(minPlayers, maxPlayers),
    );
  }

  void startGame(String category) {
    var words =
        _cards.firstWhere((element) => element.category == category).words;

    state = state.copyWith(
      chameleon: Random().nextInt(state.numPlayers),
      currPlayer: 0,
      category: category,
      words: words,
      secretWord: words[Random().nextInt(words.length)],
    );
  }

  bool nextPlayer() {
    state = state.copyWith(currPlayer: (state.currPlayer + 1));

    return state.currPlayer < state.numPlayers;
  }
}
