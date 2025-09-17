import 'package:blogapp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (Context) => BlogPage());
  const BlogPage({super.key});

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
    );
  }
}
