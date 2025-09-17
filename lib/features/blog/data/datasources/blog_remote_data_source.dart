import 'dart:io';

import 'package:blogapp/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
    // TODO: implement uploadBlog
    throw UnimplementedError();

  }
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blogs_images').upload(blog.id, image);

      return supabaseClient.storage.from('blogs_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogData = await supabaseClient.from('blogs').select('*, profiles(name)').order('updated_at', ascending: false);

      return (blogData as List).map((e) => BlogModel.fromJson(e).copyWith(
        posterName: (e['profiles'] != null && e['profiles']['name'] != null) ? e['profiles']['name'] as String : null
      )).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }

  }

}
