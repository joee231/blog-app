import 'package:blogapp/core/error/failure.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

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
  }) async {

     return _getUser(() async => await remoteDataSource.LogInWithEmailAndPassword(
       email: email,
       password: password,
     ),
     );
  }

  @override
  Future<Either<Failure, User>> SignUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
      return _getUser(()  async => await remoteDataSource.SignUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),);

  }
  Future<Either<Failure, User>> _getUser
      (
      Future<User> Function() fn
      ) async
  {
    try {
      final user = await fn();
      return Right(user);
    } on sp.AuthException catch (e) {
      return Left(Failure(e.message));
    }
    on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
