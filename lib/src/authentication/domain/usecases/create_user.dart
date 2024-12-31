import 'package:equatable/equatable.dart';
import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(CreateUserParams params) async => _repository.createUser(
        name: params.name,
        surname: params.surname,
        password: params.password,
        phone: params.phone,
      );
}

class CreateUserParams extends Equatable {
  final String name;
  final String surname;
  final String password;
  final String phone;

  const CreateUserParams({
    required this.name,
    required this.surname,
    required this.password,
    required this.phone,
  });

  factory CreateUserParams.empty() {
    return const CreateUserParams(
      name: "_empty.name",
      surname: "_empty.surname",
      password: "_empty.password",
      phone: "_empty.phone",
    );
  }

  @override
  List<Object?> get props => [phone, name, surname, password];
}
