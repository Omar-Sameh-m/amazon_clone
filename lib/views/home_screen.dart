import 'package:amazon_clone/resources/cloud_firestore_methods.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/widgets/banner_ad_widget.dart';
import 'package:amazon_clone/widgets/categories_horizontal_listview.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/products_showcase_listview.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<int> discounts = [70, 60, 50, 0];
    List<List<Widget>> results = await Future.wait(
      discounts.map((d) => CloudFirestoreMethods().getProductsFromDiscount(d)),
    );
    setState(() {
      discount70 = results[0];
      discount60 = results[1];
      discount50 = results[2];
      discount0 = results[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body:
          discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      SizedBox(height: kAppBarHeight / 2),
                      const CategoriesHorizontalListViewBar(),
                      const BannerAdWidget(),
                      ProductsShowcaseListview(
                        title: "Upto 70% Off",
                        children: discount70!,
                      ),
                      ProductsShowcaseListview(
                        title: "Upto 60% Off",
                        children: discount60!,
                      ),
                      ProductsShowcaseListview(
                        title: "Upto 50% Off",
                        children: discount50!,
                      ),
                      ProductsShowcaseListview(
                        title: "Explore",
                        children: discount0!,
                      ),
                    ],
                  ),
                ),
                UserDetailsBar(offset: offset),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
