import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/src/authentication/domain/entities/user.dart';
import 'package:tdd_app/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_app/src/authentication/domain/usecases/get_users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const CreatingUser());
    final result = await _createUser(
      CreateUserParams(
        name: event.name,
        surname: event.surname,
        phone: event.phone,
        password: event.password,
      ),
    );

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(
    GetUsersEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const GettingUsers());
    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
