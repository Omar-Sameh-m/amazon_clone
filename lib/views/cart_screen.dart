import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/cart_item_widget.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * CartScreen displays user's shopping cart and checkout functionality
 *
 * This screen shows:
 * - List of items in the user's cart
 * - Total price calculation
 * - User details for delivery
 * - Buy now functionality
 * - Integration with Firestore for cart management
 *
 * Key Features:
 * - Real-time cart updates
 * - Price calculation and display
 * - User address integration
 * - Order processing workflow
 */

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(hasBackButton: false, isReadOnly: true),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: kAppBarHeight / 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
                    builder:
                        (
                          context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomMainButton(
                              child: const Text("Loading"),
                              color: yellowColor,
                              isLoading: true,
                              onPressed: () {},
                            );
                          } else {
                            return CustomMainButton(
                              child: Text(
                                "Proceed to buy (${snapshot.data!.docs.length}) items",
                                style: const TextStyle(color: Colors.black),
                              ),
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () async {
                                final state = context.read<UserDetailsBloc>().state;
                                UserDetailsModel userDetails = UserDetailsModel(name: "Anonymous", address: "Unknown");
                                if (state is UserDetailsLoaded) {
                                  userDetails = state.userDetails;
                                }
                                await CloudFirestoreMethods().buyAllItemsInCart(
                                  userDetails: userDetails,
                                );
                                Utils().showSnackBar(
                                  context: context,
                                  content: "Done",
                                );
                              },
                            );
                          }
                        },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
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
                                ProductModel model =
                                    ProductModel.getModelFromJson(
                                      json: snapshot.data!.docs[index].data(),
                                    );
                                return CartItemWidget(product: model);
                              },
                            );
                          }
                        },
                  ),
                ),
              ],
            ),
            UserDetailsBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
