part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user );// optional uid to provide user id after successful authentication
}
final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);// optional message to provide more details about the failure
}
