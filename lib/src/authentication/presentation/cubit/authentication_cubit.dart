import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_app/src/authentication/domain/usecases/get_users.dart';

part 'authentication_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial());
  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser({
    required String name,
    required String surname,
    required String password,
    required String phone,
  }) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        name: name,
        surname: surname,
        password: password,
        phone: phone,
      ),
    );

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
