import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String name,
    required String surname,
    required String password,
    required String phone,
  });

  ResultFuture<List<User>> getUsers();
}
