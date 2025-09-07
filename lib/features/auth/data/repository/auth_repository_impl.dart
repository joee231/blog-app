import 'package:blogapp/core/error/exception.dart';
import 'package:blogapp/core/error/failure.dart';
import 'package:fpdart/src/either.dart';

import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> LogInWithEmailAndPassword({
    required String email,
    required String password,
  }) {

    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> SignUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async{
    try {
      final userID = await remoteDataSource.SignUpWithEmailAndPassword(
          name: name,
          email: email,
          password: password);

return  Right(userID);  }
     on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  // Implementation of authentication repository
}
