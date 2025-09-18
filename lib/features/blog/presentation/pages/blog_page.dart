import 'package:blogapp/core/themes/app-palette.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (Context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blog App'
        ),
        actions: [
          IconButton(
              onPressed: ()
              {
                Navigator.push(context, AddNewBlogPage.rout());
              },
              icon: Icon(Icons.add_circle_outline),),
        ],
      ),
      body: BlocConsumer<BlogBloc , BlogState>(
        listener: ( context, BlogState state) { 
          if (state is BlogFailure) {
            showSnackbar(context, state.error);
          }  
        },
        builder: ( context, BlogState state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            final blogs = state.blogs;
            if (blogs.isEmpty) {
              return const Center(
                child: Text('No Blogs Available'),
              );
            } else {
              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: index % 3 == 0 ? AppPallete.gradient1 : index % 3 == 1 ? AppPallete.gradient2 : AppPallete.gradient3,
                  );
                },
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
