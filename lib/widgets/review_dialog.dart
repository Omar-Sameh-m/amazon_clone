import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Type a review for this product!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),

      // encourage your user to leave a high rating?
      submitButtonText: 'Send',
      commentHint: 'Type here',

      onSubmitted: (RatingDialogResponse res) async {
        final state = context.read<UserDetailsBloc>().state;
        String senderName = "Anonymous";
        if (state is UserDetailsLoaded) {
          senderName = state.userDetails.name;
        }
        CloudFirestoreMethods().uploadReviewToDatabase(
          productUid: productUid,
          model: ReviewModel(
            senderName: senderName,
            description: res.comment,
            rating: res.rating.toInt(),
          ),
        );
      },
    );
  }
}
