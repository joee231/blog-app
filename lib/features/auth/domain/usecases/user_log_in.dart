import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecase/use_case.dart';
import '../../../../core/entities/user.dart';
import 'package:fpdart/src/either.dart';

import '../repository/auth_repository.dart';

class UserLogin implements UseCase<User , UserLoginParameters>
{
  final AuthRepository authRepository;
  UserLogin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserLoginParameters parameters) async {

    return await authRepository.LogInWithEmailAndPassword(
        email: parameters.email,
        password: parameters.password
    );

  }

}


class UserLoginParameters {
  final String email;
  final String password;

  UserLoginParameters({
    required this.email,
    required this.password,
  });
}