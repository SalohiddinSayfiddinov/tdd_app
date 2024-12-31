import 'package:dartz/dartz.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/errors/failure.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/products/data/datasources/products_remote_data_source.dart';
import 'package:tdd_app/src/products/domain/entities/product.dart';
import 'package:tdd_app/src/products/domain/repositories/products_repo.dart';

class ProductsRepoImpl implements ProductsRepo {
  const ProductsRepoImpl(this._remoteDataSource);
  final ProductsRemoteDataSrcImpl _remoteDataSource;

  @override
  ResultFuture<Product> getProductById({required String productId}) async {
    try {
      final result =
          await _remoteDataSource.getProductById(productId: productId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> getProducts() async {
    try {
      final result = await _remoteDataSource.getProducts();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
