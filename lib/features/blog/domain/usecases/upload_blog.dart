import 'dart:io';

import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecase/use_case.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/blog.dart';

class uploadBlog implements UseCase<Blog , uploadBlogParameters>
{
  final BlogRepository blogRepository;

  uploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(uploadBlogParameters parameters) async {


    return await blogRepository.uploadBlog(
      image: parameters.image,
      title: parameters.title,
      content: parameters.content,
      posterId: parameters.posterId,
      topics: parameters.topics,
    );


    // TODO: implement call
    throw UnimplementedError();
  }

}

class uploadBlogParameters {
  final File image;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;

  uploadBlogParameters({
    required this.image,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
  });
}