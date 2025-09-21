import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:amazon_clone/widgets/review_dialog.dart';
import 'package:amazon_clone/widgets/review_widget.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: true, hasBackButton: true),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: kAppBarHeight / 2),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.productModel.sellerName,
                                  style: TextStyle(
                                    color: activeCyanColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(widget.productModel.productName),
                            ],
                          ),
                          RatingStarWidget(rating: widget.productModel.rating),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: screenSize.height / 3,
                        child: FittedBox(
                          child: Image.network(widget.productModel.url),
                        ),
                      ),
                    ),
                    CostWidget(
                      color: Colors.black,
                      cost: widget.productModel.cost,
                    ),
                    SizedBox(height: 15),
                    CustomMainButton(
                      color: Colors.orange,
                      isLoading: false,
                      onPressed: () {},
                      child: Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 15),
                    CustomMainButton(
                      color: yellowColor,
                      isLoading: false,
                      onPressed: () {},
                      child: Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 15),
                    CustomSimpleRoundedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ReviewDialog();
                          },
                        );
                      },
                      text: 'Add a review for this product',
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: screenSize.height,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ReviewWidget(
                            reviewModel: ReviewModel(
                              senderName: 'Omar Sameh',
                              description:
                                  'this is a very good product i really recommend it ',
                              rating: 3,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            UserDetailsBar(
              offset: 0,
              userDetailsModel: UserDetailsModel(
                name: 'omar',
                address: 'cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
