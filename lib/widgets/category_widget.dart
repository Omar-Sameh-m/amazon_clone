import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/views/results_screen.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ResultsScreen(query: categoriesList[index]);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(categoryLogos[index]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(categoriesList[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
