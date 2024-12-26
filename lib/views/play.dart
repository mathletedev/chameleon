import 'package:chameleon/main.dart';
import 'package:chameleon/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayView extends StatefulWidget {
  final void Function(String) setViewCallback;

  const PlayView({super.key, required this.setViewCallback});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  bool _reveal = false;
  bool _showNext = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final gameState = ref.watch(gameControllerProvider);
      final chameleon = gameState.currPlayer == gameState.chameleon;

      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Player ${gameState.currPlayer + 1}',
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              _reveal && chameleon
                  ? const GradientText(
                      'You are the Chameleon!',
                      style: TextStyle(fontSize: 24),
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.green,
                          Colors.blue,
                          Colors.indigo,
                        ],
                        stops: [
                          0.0,
                          0.2,
                          0.4,
                          0.6,
                          0.8,
                          1.0,
                        ],
                      ),
                    )
                  : Text(
                      _reveal ? gameState.secretWord : '???',
                      style: const TextStyle(fontSize: 24),
                    ),
              const Divider(height: 32, indent: 32, endIndent: 32),
              Text(
                'Category: ${gameState.category}',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  shrinkWrap: true,
                  children: List.generate(
                    16,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: (index ~/ 4 + index % 4) % 2 == 0
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.onInverseSurface,
                      child: Center(
                        child: Text(
                          gameState.words[index],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTapDown: (_) => setState(() {
                  _reveal = true;
                }),
                onTapCancel: () => setState(() {
                  _reveal = false;
                }),
                child: ElevatedButton.icon(
                  label: const Text('Reveal Word'),
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _showNext = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _showNext
            ? FloatingActionButton.extended(
                label: const Text('Next'),
                icon: const Icon(Icons.skip_next),
                onPressed: () {
                  setState(() {
                    _showNext = false;
                  });

                  var end =
                      !ref.read(gameControllerProvider.notifier).nextPlayer();
                  if (end) {
                    widget.setViewCallback('menu');
                  }
                },
              )
            : null,
      );
    });
  }
}
