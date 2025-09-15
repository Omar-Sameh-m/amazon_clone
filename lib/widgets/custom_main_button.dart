import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  const CustomMainButton({
    super.key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  });
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? Padding(
                padding: EdgeInsets.all(5),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CircularProgressIndicator(),
                ),
              )
            : child,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(),
          backgroundColor: color,
          fixedSize: Size(screenSize.width * 0.5, 40),
        ),
      ),
    );
  }
}
