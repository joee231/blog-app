import 'package:blogapp/features/auth/domain/entities/user.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthInitial()) {
    on<AuthSIgnUp>((event, emit)  async {
      emit(AuthLoading());
     final res =  await  _userSignUp(
        SignUpParameters(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
     res.fold(
             (failure) => emit(AuthFailure(failure.message)),
             (user) =>  emit(AuthSuccess(user))
     );
    });
  }
}
