import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';
import '../../models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void add(ProductModel productModel) {
    final list = List<ProductModel>.from(state.items)..add(productModel);
    emit(CartState(items: list));
  }

  void remove(ProductModel productModel) {
    final list = List<ProductModel>.from(state.items)
      ..removeWhere((e) => e.id == productModel.id);
    emit(CartState(items: list));
  }

  void clear() => emit(const CartState(items: []));
}
