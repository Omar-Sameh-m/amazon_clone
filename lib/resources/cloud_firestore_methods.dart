import 'dart:typed_data';

import 'package:amazon_clone/models/order_request_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/models/user_details_model.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amazon_clone/services/storage_service.dart';
import 'package:flutter/cupertino.dart';

/**
 * CloudFirestoreClass handles all Firebase Firestore operations
 *
 * This class provides methods for:
 * - User data management (name, address)
 * - Product management (upload, fetch, update)
 * - Cart operations (add, remove, buy items)
 * - Order management and processing
 * - Review system integration
 * - Image upload to Local Storage
 *
 * Key Features:
 * - Comprehensive error handling
 * - Integration with Firebase Auth for user-specific data
 * - Support for product ratings and reviews
 * - Cart and order processing workflow
 */

class CloudFirestoreMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final StorageService _storageService =
      StorageServiceFactory.createStorageService();

  Future uploadNameAndAddressToDatabase({
    required UserDetailsModel user,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    if (snap.exists && snap.data() != null) {
      UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
        (snap.data() as dynamic),
      );
      return userModel;
    } else {
      // Return default if no data
      return UserDetailsModel(name: "User", address: "Address not set");
    }
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
          url: url,
          productName: productName,
          cost: cost,
          discount: discount,
          uid: uid,
          sellerName: sellerName,
          sellerUid: sellerUid,
          rating: 5,
          noOfRating: 0,
        );

        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<String> uploadImageToDatabase({
    required Uint8List image,
    required String uid,
  }) async {
    try {
      // Use local storage service instead of Firebase Storage
      String fileName = 'product_$uid.jpg';
      String imagePath = await _storageService.uploadImage(image, fileName);
      return imagePath;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model = ProductModel.getModelFromJson(
        json: (docSnap.data() as dynamic),
      );
      children.add(SimpleProductWidget(productModel: model));
    }
    return children;
  }

  Future uploadReviewToDatabase({
    required String productUid,
    required ReviewModel model,
  }) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model = ProductModel.getModelFromJson(
        json: snapshot.docs[i].data(),
      );
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  Future addProductToOrders({
    required ProductModel model,
    required UserDetailsModel userDetails,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future sendOrderRequest({
    required ProductModel model,
    required UserDetailsModel userDetails,
  }) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
      orderName: model.productName,
      buyersAddress: userDetails.address,
    );
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }

  Future changeAverageRating({
    required String productUid,
    required ReviewModel reviewModel,
  }) async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .get();
    ProductModel model = ProductModel.getModelFromJson(
      json: (snapshot.data() as dynamic),
    );
    int currentRating = model.rating;
    int newRating = ((currentRating + reviewModel.rating) / 2).toInt();
    await firebaseFirestore.collection("products").doc(productUid).update({
      "rating": newRating,
    });
  }
}
