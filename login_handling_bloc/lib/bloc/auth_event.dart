part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginButtonPresssed extends AuthEvent {
  final String email;
  final String password;

  AuthLoginButtonPresssed({required this.email, required this.password});
}
