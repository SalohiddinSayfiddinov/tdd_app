import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/products/domain/entities/product.dart';
import 'package:tdd_app/src/products/domain/repositories/products_repo.dart';

class GetProductById extends UsecaseWithParams<Product, String> {
  const GetProductById(this._repository);
  final ProductsRepo _repository;

  @override
  ResultFuture<Product> call(String params) async =>
      _repository.getProductById(productId: params);
}
