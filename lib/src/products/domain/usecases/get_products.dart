import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/products/domain/entities/product.dart';
import 'package:tdd_app/src/products/domain/repositories/products_repo.dart';

class GetProducts extends UsecaseWithoutParams<List<Product>> {
  const GetProducts(this._repository);
  final ProductsRepo _repository;

  @override
  ResultFuture<List<Product>> call() async => _repository.getProducts();
}
