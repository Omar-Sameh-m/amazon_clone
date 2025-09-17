import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/banner_ad_widget.dart';
import 'package:amazon_clone/widgets/categories_horizontal_listview.dart';
import 'package:amazon_clone/widgets/products_showcase_listview.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
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
  ScrollController scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                SizedBox(height: kAppBarHeight / 2),
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
                ProductsShowcaseListview(
                  title: 'Explore',
                  children: testChildren,
                ),
              ],
            ),
          ),
          UserDetailsBar(
            offset: offset,
            userDetailsModel: UserDetailsModel(
              name: 'Omar',
              address: 'anywhere',
            ),
          ),
        ],
      ),
    );
  }
}
