import 'dart:collection';

import 'package:chameleon/controllers/game_controller.dart';
import 'package:chameleon/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

class MenuView extends HookConsumerWidget {
  final void Function(String) setViewCallback;

  const MenuView({super.key, required this.setViewCallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameControllerProvider);
    final numPlayers = gameState.numPlayers;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Play Chameleon!',
            style: TextStyle(
              fontSize: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => ref
                    .read(gameControllerProvider.notifier)
                    .setNumPlayers(numPlayers - 1),
              ),
              Text(
                'Players: $numPlayers',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => ref
                    .read(gameControllerProvider.notifier)
                    .setNumPlayers(numPlayers + 1),
              ),
            ].expand((x) => [const SizedBox(width: 16), x]).skip(1).toList(),
          ),
          NumberPicker(
            minValue: minPlayers,
            maxValue: maxPlayers,
            value: numPlayers,
            onChanged: (value) =>
                ref.read(gameControllerProvider.notifier).setNumPlayers(value),
            axis: Axis.horizontal,
            itemHeight: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Category',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          // check if categories is populated; otherwise initialSelection will be blank
          if (gameState.categories.isNotEmpty)
            DropdownMenu<String>(
              initialSelection: gameState.category,
              dropdownMenuEntries: UnmodifiableListView(
                gameState.categories.map(
                  (x) => DropdownMenuEntry(value: x, label: x),
                ),
              ),
              width: 200,
              onSelected: (category) {
                ref
                    .read(gameControllerProvider.notifier)
                    .setCategory(category ?? 'Inventions');
              },
            )
        ].expand((x) => [const SizedBox(height: 16), x]).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Play!'),
        icon: const Icon(Icons.sports_esports),
        onPressed: () {
          ref.read(gameControllerProvider.notifier).startGame();

          setViewCallback('play');
        },
      ),
    );
  }
}
