import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repo;
  StreamSubscription? _sub;

  ProductCubit(this._repo) : super(ProductInitial());

  Future<void> loadProducts() async {
    try {
      emit(ProductLoading());
      final prods = await _repo.fetchAllProducts();
      emit(ProductLoaded(prods));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  // optional live updates
  void subscribeToProducts() {
    _sub?.cancel();
    _sub = _repo.listenProducts().listen((prods) => emit(ProductLoaded(prods)));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
