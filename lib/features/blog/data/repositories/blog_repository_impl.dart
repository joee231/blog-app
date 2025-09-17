import 'dart:io';

import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/features/blog/data/model/blog_model.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exception.dart';
import '../datasources/blog_remote_data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        title: title,
        content: content,
        posterId: posterId,
        updatedAt: DateTime.now(),
        imageUrl: "",
        topics: topics,
      );
      final imageUrl =  await blogRemoteDataSource.uploadBlogImage(
          image: image, blog: blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return Right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
    // TODO: implement uploadBlog
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return   Right( blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
