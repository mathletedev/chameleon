import 'dart:convert';
import 'dart:math';

import 'package:chameleon/models/card.dart';
import 'package:chameleon/models/game_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameControllerProvider =
    NotifierProvider<GameController, GameState>(GameController.new);

const int maxPlayers = 10;
const int minPlayers = 3;

class GameController extends Notifier<GameState> {
  late List<Card> _cards;

  GameController() {
    rootBundle.loadString('assets/cards.json').then((contents) {
      _cards =
          (jsonDecode(contents) as List).map((x) => Card.fromJson(x)).toList();

      state =
          state.copyWith(categories: _cards.map((x) => x.category).toList());

      setCategory('Inventions');
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
    state = state.copyWith(
      category: category,
      words: _cards.firstWhere((element) => element.category == category).words,
    );

    assert(state.words.length == 16);
  }

  void startGame() {
    state = state.copyWith(
      chameleon: Random().nextInt(state.numPlayers),
      currPlayer: 0,
      secretWord: state.words[Random().nextInt(state.words.length)],
    );
  }

  bool nextPlayer() {
    state = state.copyWith(currPlayer: (state.currPlayer + 1));

    return state.currPlayer < state.numPlayers;
  }
}
