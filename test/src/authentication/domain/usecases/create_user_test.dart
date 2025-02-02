// What does the class depend on
// Answer -- AuthenticationRepository
// how can we create a fake version of the dependency
// Answer -- Use Mocktail
// How do we control what our dependencies do
// Answer -- Using the Mocktail's APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_app/src/authentication/domain/usecases/create_user.dart';

import '../authentication_repository_mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(
    () {
      repository = MockAuthenticationRepository();
      usecase = CreateUser(repository);
    },
  );

  final params = CreateUserParams.empty();
  test(
    "should call the [AuthRepo.createUser]",
    () async {
      // Arrange
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((invocation) async => const Right(null));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right(null)));
      verify(
        () => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
