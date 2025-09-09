import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecase/use_case.dart';
import 'package:fpdart/src/either.dart';

import '../entities/user.dart';
import '../repository/auth_repository.dart';

class UserSignUp implements UseCase<User , SignUpParameters>{

  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(SignUpParameters parameters) async {
     return await authRepository.SignUpWithEmailAndPassword(
         name: parameters.name,
         email: parameters.email,
         password: parameters.password
     );
throw UnimplementedError();
  }
}


class SignUpParameters {
  final String name;
  final String email;
  final String password;

  SignUpParameters({
    required this.name,
    required this.email,
    required this.password,
  });
}