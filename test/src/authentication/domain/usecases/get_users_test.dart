import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_app/src/authentication/domain/usecases/get_users.dart';

import '../authentication_repository_mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = GetUsers(repository);
  });

  final tResponse = [User.empty()];

  test(
    'should call [AuthRepo.getUsers] and return [List<Users>]',
    () async {
      // Arrange
      when(() => repository.getUsers())
          .thenAnswer((_) async => Right(tResponse));

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(Right(tResponse)));
      verify(() => repository.getUsers()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
