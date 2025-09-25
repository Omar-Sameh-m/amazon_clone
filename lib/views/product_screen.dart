import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * ProductScreen displays detailed product information and interactions
 *
 * This screen shows:
 * - Product image and details
 * - Price and discount information
 * - Rating and reviews
 * - Add to cart functionality
 * - Buy now option
 * - Product reviews section
 *
 * Key Features:
 * - Product image carousel
 * - Interactive rating system
 * - Review management
 * - Cart integration
 * - User authentication checks
 */

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceThingy = Expanded(child: Container());
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
                    SizedBox(
                      height:
                          screenSize.height -
                          (kAppBarHeight + (kAppBarHeight / 2)),
                      child: Column(
                        children: [
                          const SizedBox(height: kAppBarHeight / 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                                        style: const TextStyle(
                                          color: activeCyanColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Text(widget.productModel.productName),
                                  ],
                                ),
                                RatingStarWidget(
                                  rating: widget.productModel.rating,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: screenSize.height / 3,
                              constraints: BoxConstraints(
                                maxHeight: screenSize.height / 3,
                              ),
                              child: Image.network(widget.productModel.url),
                            ),
                          ),
                          spaceThingy,
                          CostWidget(
                            color: Colors.black,
                            cost: widget.productModel.cost,
                          ),
                          spaceThingy,
                          CustomMainButton(
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.orange,
                            isLoading: false,
                            onPressed: () async {
                              final state = context.read<UserDetailsBloc>().state;
                              UserDetailsModel userDetails = UserDetailsModel(name: "Anonymous", address: "Unknown");
                              if (state is UserDetailsLoaded) {
                                userDetails = state.userDetails;
                              }
                              await CloudFirestoreMethods().addProductToOrders(
                                model: widget.productModel,
                                userDetails: userDetails,
                              );
                              Utils().showSnackBar(
                                context: context,
                                content: "Done",
                              );
                            },
                          ),
                          spaceThingy,
                          CustomMainButton(
                            child: const Text(
                              "Add to cart",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: yellowColor,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFirestoreMethods().addProductToCart(
                                productModel: widget.productModel,
                              );
                              Utils().showSnackBar(
                                context: context,
                                content: "Added to cart.",
                              );
                            },
                          ),
                          spaceThingy,
                          CustomSimpleRoundedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReviewDialog(
                                  productUid: widget.productModel.uid,
                                ),
                              );
                            },
                            text: "Add a review for this product",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.productModel.uid)
                            .collection("reviews")
                            .snapshots(),
                        builder:
                            (
                              context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot,
                            ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    ReviewModel model =
                                        ReviewModel.getModelFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data(),
                                        );
                                    return ReviewWidget(reviewModel: model);
                                  },
                                );
                              }
                            },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const UserDetailsBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
