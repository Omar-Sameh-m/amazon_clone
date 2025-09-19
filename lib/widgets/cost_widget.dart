import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  const CostWidget({super.key, required this.color, required this.cost});
  final Color color;
  final double cost;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '£E',
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontFeatures: [FontFeature.superscripts()],
          ),
        ),
        Text(
          cost.toInt().toString(),
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
        ),
        Text(
          (cost - cost.toInt()).toStringAsFixed(2).toString().substring(1),
          style: TextStyle(fontSize: 10, color: color),
        ),
      ],
    );
  }
}
