import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String url;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int noOfRating;

  ProductModel({
    this.id,
    required this.url,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.noOfRating,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String?,
      url: map['url'] as String,
      productName: map['productName'] as String,
      cost: map['cost'] as double,
      discount: map['discount'] as int,
      uid: map['uid'] as String,
      sellerName: map['sellerName'] as String,
      sellerUid: map['sellerUid'] as String,
      rating: map['rating'] as int,
      noOfRating: map['noOfRating'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'productName': productName,
      'cost': cost,
      'discount': discount,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'noOfRating': noOfRating,
    };
  }
}
