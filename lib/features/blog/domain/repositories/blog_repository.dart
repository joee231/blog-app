import 'dart:io';

import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/blog_model.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
});

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}

