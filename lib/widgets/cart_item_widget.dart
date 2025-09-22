import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/views/product_screen.dart';
import 'package:amazon_clone/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone/widgets/custom_square_button.dart';
import 'package:amazon_clone/widgets/product_info_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Container(
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductScreen(productModel: productModel),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenSize.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(productModel.url),
                        ),
                      ),
                    ),
                    ProductInfoWidget(
                      productName: productModel.productName,
                      cost: productModel.cost,
                      sellerName: productModel.sellerName,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    CustomSquareButton(
                      color: Colors.grey[500]!,
                      onPressed: () {},
                      dimension: 50,
                      child: Icon(Icons.remove),
                    ),
                    CustomSquareButton(
                      color: Colors.grey[500]!,
                      onPressed: () {},
                      dimension: 50,
                      child: Text('0'),
                    ),
                    CustomSquareButton(
                      color: Colors.grey[500]!,
                      onPressed: () {},
                      dimension: 50,
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSimpleRoundedButton(onPressed: () {}, text: 'Delete'),
                  SizedBox(width: 5),
                  CustomSimpleRoundedButton(
                    onPressed: () {},
                    text: 'Save for later',
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'See more like this',
                  style: TextStyle(color: activeCyanColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
