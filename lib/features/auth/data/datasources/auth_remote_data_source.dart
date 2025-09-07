import 'package:blogapp/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> SignUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password});
  Future<String> LogInWithEmailAndPassword(
      {required String email, required String password});
}

class authRemoteDataSourceImpl implements AuthRemoteDataSource {

  final SupabaseClient supabaseClient;
  authRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<String> LogInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement LogInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> SignUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password}) async {
    final responce = await supabaseClient.auth.signUp(
        password: password ,
        email: email ,
        data: {'name' : name})
        .then((value)
    {
      if (value.user == null) {
        throw ServerException('Something went wrong');
      }  
      return value.user!.id;
    }).catchError((error)
    {
      throw ServerException(error.message);
    });
    return responce;
 }

}