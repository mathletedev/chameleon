import 'package:chameleon/views/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChameleonApp());
}

class ChameleonApp extends StatelessWidget {
  const ChameleonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chameleon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Main(),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: switch (_view) {
          'menu' => MenuView(setViewCallback: _setViewCallback),
          _ => MenuView(setViewCallback: _setViewCallback),
        },
      ),
    );
  }
}
