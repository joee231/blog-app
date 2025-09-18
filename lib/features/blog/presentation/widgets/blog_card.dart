import 'package:flutter/material.dart';

import '../../../../core/utils/calculate_reading_time.dart';
import '../../domain/entities/blog.dart';
import '../pages/blog_viewer_page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key , required this.blog , required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        // Navigate to blog viewer page
         Navigator.push(context, BlogViewerPage.rout(blog));
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.all(16).copyWith(
            bottom: 4
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                    [
                      ...blog.topics
                    ]
                        .map(
                          (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label: Text(e),

                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
                Text(blog.title ,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

              ],
            ),

            Text('${CalculateReadingTime(blog.content)}  min '),
          ],
        ),
      ),
    );
  }
}
