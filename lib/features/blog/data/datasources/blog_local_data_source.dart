import 'package:blogapp/features/blog/data/model/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  // Define local data source methods here
  void uploadlocalBlog({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}
class BlogLocalDataSourceimpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceimpl(this.box);
  @override
  void uploadlocalBlog({required List<BlogModel> blogs}) {
    box.clear();
    box.write(()
    {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());

      }
    }

    );

  }

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(()
    {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogs;

  }

}