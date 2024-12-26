import 'package:chameleon/common/types.dart';
import 'package:flutter/material.dart';

class DebateView extends StatelessWidget {
  final SetViewCallback setViewCallback;

  const DebateView({super.key, required this.setViewCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Time to debate!',
          style: TextStyle(
            fontSize: 36,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Text('Determine which player is the Chameleon'),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          label: const Text(
            'Unmask the Chameleon!',
            style: TextStyle(fontSize: 20),
          ),
          icon: Icon(Icons.visibility),
          onPressed: () {
            setViewCallback('unmask');
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(0, 60),
          ),
        ),
      ],
    );
  }
}
