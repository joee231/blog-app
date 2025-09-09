import 'package:blogapp/features/auth/domain/entities/user.dart';
import 'package:blogapp/features/auth/domain/usecases/user_log_in.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSIgnUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSIgnUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      SignUpParameters(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogin(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
        UserLoginParameters(email: event.email, password: event.password));
    res.fold(
          (failure) => emit(AuthFailure(failure.message)),
          (user) => emit(AuthSuccess(user)),
    );
  }

}
