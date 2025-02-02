import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/errors/failure.dart';
import 'package:tdd_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group('createUser', () {
    test(
        "should call the [RemoteDataSource.createUser] and complete "
        "successfylly when the call to the remote source is successful",
        () async {
      // Arrange
      when(() => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          )).thenAnswer((_) async => Future.value());

      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      // Act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        "should return a [ServerFailure] when the call "
        "to the remote source is unsuccessful", () async {
      // Arrange
      when(() => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          )).thenThrow(const ApiException(
        message: "Unknown Error Occured",
        statusCode: 500,
      ));

      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      // Act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(
          result,
          equals(
            const Left(
                ApiFailure(message: "Unknown Error Occured", statusCode: 500)),
          ));

      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUser', () {
    test(
      "should call the [RemoteDataSource.getUser] and complete "
      "successfylly when the call to the remote source is successful",
      () async {
        // Arrange
        when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);

        // Act
        final result = await repoImpl.getUsers();

        // Assert
        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
        "should return a [ServerFailure] when the call "
        "to the remote source is unsuccessful", () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenThrow(const ApiException(
        message: "Unknown Error Occured",
        statusCode: 500,
      ));

      // Act
      final result = await repoImpl.getUsers();

      // Assert
      expect(
          result,
          equals(
            const Left(
                ApiFailure(message: "Unknown Error Occured", statusCode: 500)),
          ));

      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
