import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/models/order_request_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/views/sell_screen.dart';
import 'package:amazon_clone/widgets/accountscreen_app_bar.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/products_showcase_listview.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * AccountScreen displays user account information and order history
 *
 * This screen shows:
 * - User profile information with name and avatar
 * - Sign out and sell buttons
 * - User's order history
 * - Order requests from other users
 * - Integration with user details provider
 *
 * Key Features:
 * - User authentication state management
 * - Order history display
 * - Order request management
 * - Profile customization options
 */

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AccountscreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              IntroductionWidgetAccountScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  child: const Text(
                    "Sell",
                    style: TextStyle(color: Colors.black),
                  ),
                  color: yellowColor,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SellScreen(),
                      ),
                    );
                  },
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("orders")
                    .get(),
                builder:
                    (
                      context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data(),
                          );
                          children.add(
                            SimpleProductWidget(productModel: model),
                          );
                        }
                        return ProductsShowcaseListview(
                          title: "Your orders",
                          children: children,
                        );
                      }
                    },
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orderRequests")
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
                              OrderRequestModel model =
                                  OrderRequestModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data(),
                                  );
                              return ListTile(
                                title: Text(
                                  "Order: ${model.orderName}",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  "Address: ${model.buyersAddress}",
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(
                                          FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                        )
                                        .collection("orderRequests")
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete();
                                  },
                                  icon: Icon(Icons.check),
                                ),
                              );
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
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      builder: (context, state) {
        String name = "Loading";
        if (state is UserDetailsLoaded) {
          name = state.userDetails.name;
        }
        return Container(
          height: kAppBarHeight / 2,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Container(
            height: kAppBarHeight / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.000000000001),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hello, ",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 26,
                          ),
                        ),
                        TextSpan(
                          text: name,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTDxANEA0QEBUQFQ8QDw8PEA8PEBASFRIWFhcRFRMYHSggGBolGxYVITMhJSkrLi4uFx8zODMuNygtLisBCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAQsAvQMBIgACEQEDEQH/xAAbAAEBAQADAQEAAAAAAAAAAAAABQQBAgMGB//EADgQAQACAAIHBQYEBQUAAAAAAAABAgMRBAUSITFRcSJBYZGxMlKBocHRQoKi4RNDkvDxIzNTYoP/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A/SgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAjl6KGjau78T+mJ9Z+wJ2f+O/yetNHvPDDv8azHqt4eHFd1axXpu+buCBfCtHGlo8ZrOXnwecS+jeONo1Le1WOsbp84BDGrStBmvajtR+qOscmUAAAAAAAAAAAAAAAGrV2DtX2p4U39Z7vv8AbNA0TZjbtHan9McurYAAADhyAJWsNE2e3WN0+1HuzM8Y8JVXW1c4mJ3xMTEx4SD58d8bD2bTSfwzl1junydAAAAAAAAAAAAAFbVVcsPP3rWny7P0SVrQP9qnT6yDQAAAAAAACVranbrbnWY8p/diUdcfg/N5bk4AAAAAAAAAAAABW1VfPDy92bR59qPX5JLVq7G2b5Twvu6T3esx8QWAAAAAAAcWtERMzuiM5mfCAS9bX7da8omfOf2YnfGxNq03n8U5/SPlEOgAAAAAAAAAAAAAAK2gaXtRs2ntR+qOfVsfO+PLfE8lDRtY92J/XEesfYFIdMPEi0Z1tFuku4APHG0mtfatGfuxvt5QD2StYaXtdis7o9qec8o8IdNK06bdmOzX9U9Z+zKAAAAAAAAAAAAAAADmtZmcoiZmeERvkHBG+coiZnlETM+UKOj6t78Sfy1n1n7N2HhxWMq1iOm4EemhYk79iY8ZmKz92imi43/Ll/wCt5+imAlX0TGnjeZ8P4lvSWe+i3rxw7Zc6xtR8lxyD52BdxtHrb2qxPjwt5wm6ToFq769qOX4o+HeDIAAAAAAAAAAAADvg4c2tFY4z5RHOQMDBm87NfjM8IjnKzo2jxSMo7+Np4z/fJzo+BFK7MfGe+Z5y9QAAAAAAAAY9M0KLdqu63yt18fFJtGU5TGUxumJ4xL6Jk03RNuNqMotHD/tHuyCQAAAAAAAAAAsaBo2xXf7Vt8+HKrDq3A2r7U8Kb+s90fXyWAAAAAAAAAAAAATNaaPlP8WO/dfr3W/vwYH0FqxMTExnE7phBxcPZtNJ35d/OO6fIHUAAAAABxLl6aPh7V615zv6Rvn5R8wVtBwtnDiO+e1brP2jKPg0AAAAAAAAAAAAAAna2wvZxPyz8d8fPPzUXlpOHtUtXnE5deMfPIEIcRLkAAAABt1TTO9re7HztP2iWJT1RXs3nnaI8oj7yDeAAAAAAAAAAAAAADgELSabN715WnLpO+PV5tWs6/6s+MVn1j6MoAAAACvquv8Ap8eM2np3fRIUdXaVER/DtOWUzlM8Jz8eYKIAAAAAAAAAAAAADhy4tOUZzOURxmd0Ama3r2qznxrMZdJ/dhatP0iL2jLhXOM+eeWfw3MoAAAAAAO+FjWr7Npjw4x5TuaaayvHGtbedZ+sMYCnXWcd9LR0ms+uT0jWOH3zaOtLfTNIAW66Zhz/ADK/GcvV2jSKTGcYlZ/NVCAX6YlZ3xas9JiXbPxjzfO5GQPos/GHS2NWJym9Y8JtEIGRkC9bSaRunEpH5odLadhx/MiekWt6QigK1tY07tqelcvXJ5W1pyw5+Noj0zTgGq+sLzw2a9Iznzn7M17zO+1pt1nP/DgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB/9k=",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
