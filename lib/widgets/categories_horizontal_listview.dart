import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/views/results_screen.dart';
import 'package:flutter/material.dart';

/**
 * CategoriesHorizontalListViewBar displays horizontal scrollable categories
 *
 * This widget shows:
 * - Horizontal list of product categories
 * - Category icons and names
 * - Tap navigation to results screen for each category
 * - Consistent styling and layout
 *
 * Key Features:
 * - Horizontal scrolling
 * - Category-based navigation
 * - Visual category representation
 * - Integration with results screen
 */

class CategoriesHorizontalListViewBar extends StatelessWidget {
  const CategoriesHorizontalListViewBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ResultsScreen(query: categoriesList[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(categoryLogos[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(categoriesList[index]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
