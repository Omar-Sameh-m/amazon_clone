import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        
      },
      child: Column(
        children: [
          SizedBox(
            width: screenSize.width / 3,
            child: Image.network(productModel.url),
          ),
          Text(
            productModel.productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingStarWidget(rating: productModel.rating),
              Text(
                productModel.noOfRating.toString(),
                style: const TextStyle(color: activeCyanColor),
              ),
            ],
          ),
          CostWidget(
            color: const Color.fromARGB(255, 93, 10, 10),
            cost: productModel.cost,
          ),
        ],
      ),
    );
  }
}
