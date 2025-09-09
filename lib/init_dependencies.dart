import 'package:blogapp/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/domain/repository/auth_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supbaseUrl,
    anonKey: AppSecrets.supbaseApiKey,
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  // Bloc/Cubit

  // UseCases

  // Repository

  // Data sources
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => authRemoteDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator()),
  );
}
