import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

class CartState extends Equatable {
  final List<ProductModel> items;
  const CartState({this.items = const []});
  @override
  List<Object?> get props => [items];
}
