import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

const int maxPlayers = 10;
const int minPlayers = 3;

class MenuView extends StatefulWidget {
  final void Function(String) setViewCallback;

  const MenuView({super.key, required this.setViewCallback});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _numPlayers = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Play Chameleon', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          NumberPicker(
            minValue: minPlayers,
            maxValue: maxPlayers,
            value: _numPlayers,
            onChanged: (value) => setState(() => _numPlayers = value),
            axis: Axis.horizontal,
            itemHeight: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => setState(() {
                  _numPlayers = (_numPlayers - 1).clamp(minPlayers, maxPlayers);
                }),
              ),
              Text('Players: $_numPlayers'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() {
                  _numPlayers = (_numPlayers + 1).clamp(minPlayers, maxPlayers);
                }),
              ),
            ].expand((x) => [const SizedBox(width: 16), x]).skip(1).toList(),
          ),
        ].expand((x) => [const SizedBox(height: 16), x]).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Play!'),
        icon: const Icon(Icons.sports_esports),
        onPressed: () {
          widget.setViewCallback('game');
        },
      ),
    );
  }
}
