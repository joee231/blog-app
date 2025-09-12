import 'package:blogapp/core/error/exception.dart';
import 'package:blogapp/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> SignUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password});
  Future<UserModel> LogInWithEmailAndPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentUserData();
}

class authRemoteDataSourceImpl implements AuthRemoteDataSource {

  final SupabaseClient supabaseClient;
  authRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> LogInWithEmailAndPassword({required String email, required String password}) async {
     try {
    print('Attempting log in with email: $email');
    final value = await supabaseClient.auth.signInWithPassword(
    password: password,
    email: email,
    );
    print('Supabase sign in response: user=${value.user}, error=${value.toString()}');
    if (value.user == null) {
    throw ServerException(value.toString() ?? 'Something went wrong');
    }
    return UserModel.fromJson(value.user!.toJson());
    } catch (error) {
    print('Sign up error: $error');
    if (error is AuthException) {
    throw ServerException(error.message);
    } else if (error is ServerException) {
    throw error;
    } else {
    throw ServerException(error.toString());
    }
  }
  }

  @override
  Future<UserModel> SignUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password}) async {
    try {
      print('Attempting sign up with email: $email');
      final value = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      print('Supabase signUp response: user=${value.user}, error=${value.toString()}');
      if (value.user == null) {
        throw ServerException(value.toString() ?? 'Something went wrong');
      }
      return UserModel.fromJson(value.user!.toJson());
    } catch (error) {
      print('Sign up error: $error');
      if (error is AuthException) {
        throw ServerException(error.message);
      } else if (error is ServerException) {
        throw error;
      } else {
        throw ServerException(error.toString());
      }
    }
 }

  @override
  Future<UserModel?> getCurrentUserData() async {

    try{
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq(
            'id',
            currentUserSession!.user.id
        );
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email
        );
      }  
      return null ;
    }catch (e){
      throw ServerException(e.toString());

    }

  }


}