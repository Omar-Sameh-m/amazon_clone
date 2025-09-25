import 'dart:typed_data';
import 'package:amazon_clone/blocs/user_details/user_details_bloc.dart';
import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * SellScreen allows users to sell products on the platform
 *
 * This screen provides:
 * - Image upload functionality for product photos
 * - Product name and cost input fields
 * - Discount selection options
 * - Product upload to database
 * - User authentication integration
 *
 * Key Features:
 * - Image picker integration
 * - Form validation
 * - Real-time discount calculation
 * - Firebase integration for product storage
 * - User profile integration
 */

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];
  //keysofdiscoutn[selected -1]

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? Image.network(
                                      "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                                      height: screenSize.height / 10,
                                    )
                                  : Image.memory(
                                      image!,
                                      height: screenSize.height / 10,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  Uint8List? temp = await Utils().pickImage();
                                  if (temp != null) {
                                    setState(() {
                                      image = temp;
                                    });
                                  }
                                },
                                icon: Icon(Icons.file_upload),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 10,
                            ),
                            height: screenSize.height * 0.7,
                            width: screenSize.width * 0.7,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldWidget(
                                  title: "Name",
                                  controller: nameController,
                                  obscureText: false,
                                  hintText: "Enter the name of the item",
                                ),
                                TextFieldWidget(
                                  title: "Cost",
                                  controller: costController,
                                  obscureText: false,
                                  hintText: "Enter the cost of the item",
                                ),
                                const Text(
                                  "Discount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                ListTile(
                                  title: Text("None"),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("70%"),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("60%"),
                                  leading: Radio(
                                    value: 3,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text("50%"),
                                  leading: Radio(
                                    value: 4,
                                    groupValue: selected,
                                    onChanged: (int? i) {
                                      setState(() {
                                        selected = i!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomMainButton(
                            child: const Text(
                              "Sell",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: yellowColor,
                            isLoading: isLoading,
                            onPressed: () async {
                              final state = context.read<UserDetailsBloc>().state;
                              String sellerName = "Anonymous";
                              if (state is UserDetailsLoaded) {
                                sellerName = state.userDetails.name;
                              }
                              String output = await CloudFirestoreMethods()
                                  .uploadProductToDatabase(
                                    image: image,
                                    productName: nameController.text,
                                    rawCost: costController.text,
                                    discount: keysForDiscount[selected - 1],
                                    sellerName: sellerName,
                                    sellerUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  );
                              if (output == "success") {
                                Utils().showSnackBar(
                                  context: context,
                                  content: "Posted Product",
                                );
                              } else {
                                Utils().showSnackBar(
                                  context: context,
                                  content: output,
                                );
                              }
                            },
                          ),
                          CustomMainButton(
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.grey[300]!,
                            isLoading: false,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
