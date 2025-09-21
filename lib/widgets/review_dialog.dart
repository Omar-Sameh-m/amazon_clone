import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: Text(
        'Type a review for this product',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),

      submitButtonText: 'Send',
      commentHint: 'Type here',
      onSubmitted: (response) {
        log(response.comment);
      },
    );
  }
}
