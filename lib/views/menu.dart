import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

const int minPlayers = 3;
const int maxPlayers = 10;

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int _numPlayers = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                _numPlayers = (_numPlayers - 1).clamp(minPlayers, maxPlayers);
              }),
            ),
            Text('Players: $_numPlayers'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                _numPlayers = (_numPlayers + 1).clamp(minPlayers, maxPlayers);
              }),
            ),
          ].expand((x) => [const SizedBox(width: 16), x]).skip(1).toList(),
        ),
      ],
    );
  }
}
