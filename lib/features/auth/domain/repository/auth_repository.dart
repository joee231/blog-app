import '../../../../core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class AuthRepository {
Future<Either<Failure, User>> SignUpWithEmailAndPassword(
{
  required String name,
  required String email,
  required String password
});

Future<Either<Failure, User>> LogInWithEmailAndPassword(
    {
      required String email,
      required String password
    });

Future<Either<Failure , User>> currentUser();
}