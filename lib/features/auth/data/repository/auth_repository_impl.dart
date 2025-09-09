import 'package:blogapp/core/error/failure.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> LogInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> SignUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final uid = await remoteDataSource.SignUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(uid);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
