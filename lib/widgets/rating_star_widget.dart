import 'package:flutter/material.dart';

class RatingStarWidget extends StatelessWidget {
  const RatingStarWidget({super.key, required this.rating});
  final int rating;
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < 5; i++) {
      children.add(
        i < rating
            ? Icon(Icons.star, color: Colors.amber)
            : Icon(Icons.star_border, color: Colors.amber),
      );
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
  }
}
