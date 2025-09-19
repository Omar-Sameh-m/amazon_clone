import 'package:flutter/material.dart';

class CustomSquareButton extends StatelessWidget {
  const CustomSquareButton({
    super.key,
    required this.child,
    required this.color,
    required this.onPressed,
    required this.dimension,
  });
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double dimension;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: dimension,
        width: dimension,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
