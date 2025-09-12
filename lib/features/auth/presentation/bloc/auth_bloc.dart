import 'package:blogapp/core/cubits/app_user/app_user_cubit.dart';
import 'package:blogapp/core/usecase/use_case.dart';
import '../../../../core/entities/user.dart';
import 'package:blogapp/features/auth/domain/usecases/current_user.dart';
import 'package:blogapp/features/auth/domain/usecases/user_log_in.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  final CurrentUser _currentUser;

  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
      _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>(((context , emit) => emit(AuthLoading())));
    on<AuthSIgnUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(noParams());

    res.fold((l) => emit(AuthFailure(l.message)),
            (r ) => _emitAuthSucces(r , emit),
    );
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
      (user) => _emitAuthSucces(user , emit),
    );
  }

  void _onAuthLogin(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParameters(email: event.email, password: event.password),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSucces(user , emit),
    );
  }

  void _emitAuthSucces(User user , Emitter<AuthState> state)
  {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));

  }
}
