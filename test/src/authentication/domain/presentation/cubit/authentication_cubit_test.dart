import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/errors/failure.dart';
import 'package:tdd_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_app/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_app/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthCubit cubit;

  final tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test(
    "initial state should be [AuthInitial]",
    () async {
      expect(cubit.state, const AuthInitial());
    },
  );

  group(
    'createUser',
    () {
      blocTest<AuthCubit, AuthState>(
          'should emit [Creatinguser, UserCreated] when successfull',
          build: () {
            when(() => createUser(any())).thenAnswer(
              (_) async => const Right(null),
            );
            return cubit;
          },
          act: (cubit) => cubit.createUser(
                createdAt: tCreateUserParams.createdAt,
                name: tCreateUserParams.name,
                avatar: tCreateUserParams.avatar,
              ),
          expect: () => const [
                CreatingUser(),
                UserCreated(),
              ],
          verify: (_) {
            verify(() => createUser(tCreateUserParams)).called(1);
            verifyNoMoreInteractions(createUser);
          });
      blocTest<AuthCubit, AuthState>(
          'should emit [Creatinguser, AuthError] when unsuccessfull',
          build: () {
            when(() => createUser(any())).thenAnswer(
              (_) async => const Left(tApiFailure),
            );
            return cubit;
          },
          act: (cubit) => cubit.createUser(
                createdAt: tCreateUserParams.createdAt,
                name: tCreateUserParams.name,
                avatar: tCreateUserParams.avatar,
              ),
          expect: () => [
                const CreatingUser(),
                AuthError(tApiFailure.errorMessage),
              ],
          verify: (_) {
            verify(() => createUser(tCreateUserParams)).called(1);
            verifyNoMoreInteractions(createUser);
          });
    },
  );
  group(
    'getUsers',
    () {
      blocTest<AuthCubit, AuthState>(
          'should emit [GettingUserss, UsersLoaded] when successfull',
          build: () {
            when(() => getUsers()).thenAnswer(
              (_) async => const Right([]),
            );
            return cubit;
          },
          act: (cubit) => cubit.getUsers(),
          expect: () => const [
                GettingUsers(),
                UsersLoaded([]),
              ],
          verify: (_) {
            verify(() => getUsers()).called(1);
            verifyNoMoreInteractions(getUsers);
          });
      blocTest<AuthCubit, AuthState>(
          'should emit [GettingUserss, AuthError] when unsuccessfull',
          build: () {
            when(() => getUsers()).thenAnswer(
              (_) async => const Left(tApiFailure),
            );
            return cubit;
          },
          act: (cubit) => cubit.getUsers(),
          expect: () => [
                const GettingUsers(),
                AuthError(tApiFailure.errorMessage),
              ],
          verify: (_) {
            verify(() => getUsers()).called(1);
            verifyNoMoreInteractions(createUser);
          });
    },
  );
}
