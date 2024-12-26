import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget Function(int) cellGenerator;

  const CardWidget({super.key, required this.cellGenerator});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
          child: cellGenerator(index),
        ),
      ),
    );
  }
}
