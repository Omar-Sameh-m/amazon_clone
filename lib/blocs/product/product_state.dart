import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductFailure extends ProductState {
  final String error;
  ProductFailure(this.error);
  @override
  List<Object?> get props => [error];
}
