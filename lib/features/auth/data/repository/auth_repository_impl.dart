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
    // TODO: implement LogInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> SignUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) {
    // TODO: implement SignUpWithEmailAndPassword
    throw UnimplementedError();
  }

  // Implementation of authentication repository
}
