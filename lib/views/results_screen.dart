import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/widgets/loading_widget.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/**
 * ResultsScreen displays search results for products
 *
 * This screen shows:
 * - Search query display
 * - Grid of products matching the search query
 * - Loading states for better UX
 * - Integration with Firestore for product data
 *
 * Key Features:
 * - Real-time product search
 * - Grid layout for product display
 * - Loading indicators
 * - Error handling for empty results
 */

class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Showing results for ",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextSpan(
                      text: query,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection("products").get(),
              builder:
                  (
                    context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      List<ProductModel> allProducts = snapshot.data!.docs
                          .map(
                            (doc) =>
                                ProductModel.getModelFromJson(json: doc.data()),
                          )
                          .toList();
                      List<ProductModel> filteredProducts = allProducts
                          .where(
                            (product) => product.productName
                                .toLowerCase()
                                .contains(query.toLowerCase()),
                          )
                          .toList();
                      if (filteredProducts.isEmpty) {
                        return Center(
                          child: Text("No results found for '$query'"),
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 3.5,
                              ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            ProductModel product = filteredProducts[index];
                            return SimpleProductWidget(productModel: product);
                          },
                        );
                      }
                    }
                  },
            ),
          ),
        ],
      ),
    );
  }
}
