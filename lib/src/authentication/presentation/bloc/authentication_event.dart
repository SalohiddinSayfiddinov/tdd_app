part of 'authentication_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final String name;
  final String surname;
  final String password;
  final String phone;

  const CreateUserEvent(
      {required this.name,
      required this.surname,
      required this.password,
      required this.phone});

  @override
  List<Object?> get props => [surname, name, phone, password];
}

class GetUsersEvent extends AuthEvent {
  const GetUsersEvent();
}
