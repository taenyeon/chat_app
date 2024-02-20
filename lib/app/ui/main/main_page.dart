import 'dart:math';

import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlexibleGridView(
      axisCount: GridLayoutEnum.twoElementsInRow,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(
        4,
        (index) => Container(
          color: colors[Random().nextInt(colors.length)],
          height: 600 + Random().nextInt(100).toDouble(),
        ),
      ),
    );
  }
}

List<Color> colors = [
  Colors.white30,
  Colors.limeAccent,
  Colors.white,
  Colors.blue,
  Colors.orangeAccent
];
