import 'package:blogapp/core/error/failure.dart';
import 'package:blogapp/core/usecase/use_case.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

import '../repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog> , noParams>{
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(noParams parameters) async {
      return await blogRepository.getAllBlogs();

  }
}