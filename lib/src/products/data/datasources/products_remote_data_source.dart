import 'dart:convert';

import 'package:tdd_app/core/constants/constants.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/products/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById({required String productId});
}

class ProductsRemoteDataSrcImpl implements ProductsRemoteDataSource {
  const ProductsRemoteDataSrcImpl(this._client);

  final http.Client _client;
  @override
  Future<ProductModel> getProductById({required String productId}) async {
    try {
      final response = await _client.get(
        Uri.http(
            Constants.baseUrl, '${Constants.getProductsEndpoint}$productId/'),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      print(response.body);
      return ProductModel.fromJson(jsonDecode(response.body));
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _client.get(
        Uri.http(Constants.baseUrl, Constants.getProductsEndpoint),
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => ProductModel.fromMap(e))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
