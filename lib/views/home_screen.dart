import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/banner_ad_widget.dart';
import 'package:amazon_clone/widgets/categories_horizontal_listview.dart';
import 'package:amazon_clone/widgets/products_showcase_listview.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> testChildren = [
    SimpleProductWidget(
      url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
    ),
    SimpleProductWidget(
      url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
    ),
    SimpleProductWidget(
      url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
    ),
    SimpleProductWidget(
      url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoriesHorizontalListview(),
            BannerAdWidget(),
            ProductsShowcaseListview(
              title: 'Up to 70% off',
              children: testChildren,
            ),
            ProductsShowcaseListview(
              title: 'Up to 50% off',
              children: testChildren,
            ),
            ProductsShowcaseListview(
              title: 'Up to 40% off',
              children: testChildren,
            ),
            ProductsShowcaseListview(title: 'Explore', children: testChildren),
          ],
        ),
      ),
    );
  }
}
