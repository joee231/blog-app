import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blogapp/core/usecase/use_case.dart';
import 'package:blogapp/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/blog.dart';
import '../../domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final uploadBlog _uploadblog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required uploadBlog uploadblog, required GetAllBlogs getAllBlogs})
    : _uploadblog = uploadblog,
      _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onBlogFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadblog(
      uploadBlogParameters(
        image: event.image,
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );
    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }
  void _onBlogFetchAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(noParams());
    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogDisplaySuccess(blogs: r)),
    );
  }
}
