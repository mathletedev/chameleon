import 'package:chameleon/common/types.dart';
import 'package:chameleon/controllers/game_controller.dart';
import 'package:chameleon/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GuessView extends HookConsumerWidget {
  final SetViewCallback setViewCallback;

  const GuessView({super.key, required this.setViewCallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Time to guess!',
          style: TextStyle(
            fontSize: 36,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: CardWidget(cellGenerator: (index) {
            var word = gameState.words[index];

            return TextButton(
              onPressed: () {
                setViewCallback(
                  word == gameState.secretWord
                      ? 'win_chameleon'
                      : 'win_players',
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                shape: const ContinuousRectangleBorder(),
              ),
              child: Text(
                word,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
