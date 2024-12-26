import 'package:chameleon/common/types.dart';
import 'package:chameleon/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UnmaskView extends HookConsumerWidget {
  final SetViewCallback setViewCallback;

  const UnmaskView({super.key, required this.setViewCallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Player ${gameState.chameleon + 1}',
          style: TextStyle(
            fontSize: 36,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text('was the Chameleon!', style: TextStyle(fontSize: 28)),
        const Divider(height: 64, indent: 64, endIndent: 64),
        Text(
          'Did the Chameleon escape?',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setViewCallback('win_chameleon');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
              ),
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                setViewCallback('guess');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
              ),
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
