import 'dart:convert';

import 'package:tdd_app/core/constants/constants.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String surname,
    required String password,
    required String phone,
  });

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDataSrcImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String name,
    required String surname,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await _client.post(
        Uri.http(Constants.baseUrl, Constants.createUserEndpoint),
        body: jsonEncode(
          {
            'name': name,
            'surname': surname,
            'phone': phone,
            'password': password,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.http(Constants.baseUrl, Constants.getUserEndpoint),
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
