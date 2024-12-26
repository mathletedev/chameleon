import 'package:chameleon/common/types.dart';
import 'package:chameleon/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EndView extends HookConsumerWidget {
  final SetViewCallback setViewCallback;
  final bool chameleonWon;

  const EndView({
    super.key,
    required this.setViewCallback,
    required this.chameleonWon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The ${chameleonWon ? "Chameleon" : "Players"} won!',
              style: TextStyle(
                fontSize: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'The secret word was: ${gameState.secretWord}',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Play Again'),
        icon: const Icon(Icons.play_arrow),
        onPressed: () {
          setViewCallback('menu');
        },
      ),
    );
  }
}
