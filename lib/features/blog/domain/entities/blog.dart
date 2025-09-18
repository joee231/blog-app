class Blog {
  final String id;
  final String title;
  final String content;
  final String posterId;
  final DateTime updatedAt;
  final String imageUrl;
  final List<String> topics;

  final String? posterName;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.posterId,
    required this.updatedAt,
    required this.imageUrl,
    required this.topics,
    this.posterName,
  });



  //
}
