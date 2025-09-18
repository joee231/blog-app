import 'package:blogapp/core/themes/app-palette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/calculate_reading_time.dart';
import '../../../../core/utils/format_date.dart';
import '../../domain/entities/blog.dart';


class BlogViewerPage extends StatelessWidget {
  static rout(Blog blog) => MaterialPageRoute(
      builder: (Context) =>
      BlogViewerPage(blog: blog
      ),
  );
  final Blog blog;
  const BlogViewerPage({super.key , required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(blog.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 20,),
                Text(
                  'by ${blog.posterName}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )
                ),
                SizedBox(height: 5,),
          
                Text(
                    'Updated at: ${FormatDateByDMMMYYYY(blog.updatedAt)} . ${CalculateReadingTime(blog.content)} min read',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppPallete.greyColor,
                    fontWeight: FontWeight.w500,
          
                  ),
                ),
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: blog.imageUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image, color: Colors.red)),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  blog.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
