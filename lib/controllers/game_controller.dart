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

      state =
          state.copyWith(categories: _cards.map((x) => x.category).toList());
    });
  }

  @override
  GameState build() => GameState();

  void setNumPlayers(int numPlayers) {
    state = state.copyWith(
      numPlayers: numPlayers.clamp(minPlayers, maxPlayers),
    );
  }

  void setCategory(String category) {
    state = state.copyWith(category: category);
  }

  void startGame() {
    var words = _cards
        .firstWhere((element) => element.category == state.category)
        .words;

    state = state.copyWith(
      chameleon: Random().nextInt(state.numPlayers),
      currPlayer: 0,
      words: words,
      secretWord: words[Random().nextInt(words.length)],
    );
  }

  bool nextPlayer() {
    state = state.copyWith(currPlayer: (state.currPlayer + 1));

    return state.currPlayer < state.numPlayers;
  }
}
