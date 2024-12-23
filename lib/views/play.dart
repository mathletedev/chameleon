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
                style: const TextStyle(fontSize: 30),
              ),
              _reveal && chameleon
                  ? const GradientText(
                      'You are the Chameleon',
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
                      _reveal ? 'Regular' : '???',
                      style: const TextStyle(fontSize: 24),
                    ),
              SizedBox(
                height: 100,
              ),
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
