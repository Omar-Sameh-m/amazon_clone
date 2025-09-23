import 'dart:typed_data';

import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_main_button.dart';
import 'package:amazon_clone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();

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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? Image.network(
                                      'data:image/png;base64,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',
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
                            margin: EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 15,
                            ),
                            height: screenSize.height * 0.7,
                            width: screenSize.width * 0.7,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Item Details',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextFieldWidget(
                                  title: 'Item name',
                                  controller: nameController,
                                  obscureText: false,
                                  hintText: 'Enter the name of the item',
                                ),
                                SizedBox(height: 15),
                                TextFieldWidget(
                                  title: 'Cost',
                                  controller: costController,
                                  obscureText: false,
                                  hintText: 'Enter the cost of the item',
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Discount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),

                                ListTile(
                                  title: Text('None'),
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
                                  title: Text('70%'),
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
                                  title: Text('60%'),
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
                                  title: Text('50%'),
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
                            color: yellowColor,
                            isLoading: isLoading,
                            onPressed: () {},
                            child: Text(
                              'Sell',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          CustomMainButton(
                            color: Colors.grey[300]!,
                            isLoading: isLoading,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator(color: Colors.orange)),
      ),
    );
  }
}
