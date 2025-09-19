import 'package:amazon_clone/utils/colors_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({
    super.key,
    required this.productName,
    required this.cost,
    required this.sellerName,
  });
  final String productName;
  final double cost;
  final String sellerName;
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SizedBox(
      width: screenSize.width / 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.7,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CostWidget(color: Colors.black, cost: cost),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Sold by '),
                  TextSpan(
                    text: sellerName,
                    style: TextStyle(color: activeCyanColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
