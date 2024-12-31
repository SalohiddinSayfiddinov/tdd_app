import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/src/products/domain/entities/product.dart';
import 'package:tdd_app/src/products/domain/usecases/get_product_by_id.dart';
import 'package:tdd_app/src/products/domain/usecases/get_products.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(
      {required GetProducts getProducts,
      required GetProductById getProductById})
      : _getProducts = getProducts,
        _getProductById = getProductById,
        super(const ProductsInitial());
  final GetProducts _getProducts;
  final GetProductById _getProductById;

  Future<void> getProducts() async {
    emit(const GettingProducts());
    final result = await _getProducts();

    result.fold(
      (failure) => emit(ProductsError(failure.errorMessage)),
      (products) => emit(ProductsLoaded(products)),
    );
  }

  Future<void> getProductById({required String productId}) async {
    emit(const GettingProducts());
    final result = await _getProductById(productId);

    result.fold(
      (failure) => emit(ProductsError(failure.errorMessage)),
      (product) => emit(ProductLoaded(product)),
    );
  }
}
