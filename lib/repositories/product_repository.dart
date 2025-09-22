import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchAllProducts() async {
    final snap = await _db.collection('products').get();
    return snap.docs.map((d) {
      final map = d.data();
      return ProductModel.fromMap({...map, 'id': d.id});
    }).toList();
  }

  Stream<List<ProductModel>> listenProducts() {
    return _db.collection('products').snapshots().map((snap) =>
      snap.docs.map((d) => ProductModel.fromMap({...d.data(), 'id': d.id})).toList()
    );
  }
}
