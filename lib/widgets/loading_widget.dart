import 'package:flutter/material.dart';

/**
 * LoadingWidget displays a centered loading indicator
 *
 * This widget shows a simple loading spinner with an optional message
 * to indicate that data is being loaded or processed.
 *
 * Key Features:
 * - Centered loading indicator
 * - Customizable loading message
 * - Consistent styling with the app theme
 */
class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.orange,
          ),
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                message!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
