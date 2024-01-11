import 'dart:math';

import 'package:flutter/material.dart';

class ContainerTransform extends StatelessWidget {
  const ContainerTransform({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 150,
      height: 150 * 0.618,
      transform: Matrix4.skew(-pi / 10, 0),
      child: const Text(
        'Container',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
