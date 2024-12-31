import 'package:dartz/dartz.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/errors/failure.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_app/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String name,
    required String surname,
    required String password,
    required String phone,
  }) async {
    try {
      final result = await _remoteDataSource.createUser(
          name: name, password: password, phone: phone, surname: surname);

      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
