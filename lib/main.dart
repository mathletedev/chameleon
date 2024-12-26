import 'package:chameleon/views/debate.dart';
import 'package:chameleon/views/end.dart';
import 'package:chameleon/views/guess.dart';
import 'package:chameleon/views/menu.dart';
import 'package:chameleon/views/play.dart';
import 'package:chameleon/views/unmask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkNotifier = ValueNotifier(false);

void main() {
  runApp(const ProviderScope(child: ChameleonApp()));
}

class ChameleonApp extends StatelessWidget {
  const ChameleonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkNotifier,
      builder: (context, isDark, child) => MaterialApp(
        title: 'Chameleon',
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: const Main(),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String _view = 'menu';

  _setViewCallback(String view) {
    setState(() {
      _view = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chameleon'),
        actions: [
          IconButton(
            icon: Icon(darkNotifier.value ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => darkNotifier.value = !darkNotifier.value,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: switch (_view) {
          'menu' => MenuView(setViewCallback: _setViewCallback),
          'play' => PlayView(setViewCallback: _setViewCallback),
          'debate' => DebateView(setViewCallback: _setViewCallback),
          'unmask' => UnmaskView(setViewCallback: _setViewCallback),
          'guess' => GuessView(setViewCallback: _setViewCallback),
          'win_chameleon' =>
            EndView(setViewCallback: _setViewCallback, chameleonWon: true),
          'win_players' =>
            EndView(setViewCallback: _setViewCallback, chameleonWon: false),
          _ => MenuView(setViewCallback: _setViewCallback),
        },
      ),
    );
  }
}
