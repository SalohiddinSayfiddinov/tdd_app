part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

final class GettingProducts extends ProductsState {
  const GettingProducts();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products);

  final List<Product> products;

  @override
  List<Object?> get props => products.map((e) => e.id).toList();
}

class ProductLoaded extends ProductsState {
  const ProductLoaded(this.product);

  final Product product;

  @override
  List<Object?> get props => [product.id];
}

class ProductsError extends ProductsState {
  const ProductsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
