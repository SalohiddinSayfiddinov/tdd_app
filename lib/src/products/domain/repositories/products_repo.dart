import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/products/domain/entities/product.dart';

abstract class ProductsRepo {
  const ProductsRepo();

  ResultFuture<List<Product>> getProducts();
  ResultFuture<Product> getProductById({required String productId});
}
