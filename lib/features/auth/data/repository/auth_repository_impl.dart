import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/features/auth/data/models/user_model.dart';
import 'package:fpdart/src/either.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl(
    this.connectionChecker, {
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure('User not logged in'));
        }
        return right(
          UserModel(
              id: session!.user.id,
              email: session.user.email ?? '',
              name: ''
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> LogInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.LogInWithEmailAndPassword(
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
    return _getUser(
      () async => await remoteDataSource.SignUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return Left(Failure(Constants.noConnectionMessage));
      }
      final user = await fn();
      return Right(user);
    }  on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
