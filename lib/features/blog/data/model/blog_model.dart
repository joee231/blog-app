import '../../domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.posterId,
    required super.updatedAt,
    required super.imageUrl,
    required super.topics,
    super.posterName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      posterId: json["poster_id"],
      updatedAt: json['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(json["updated_at"]),
      imageUrl: json["image_url"],
      topics: List<String>.from(json["topics"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "content": this.content,
      "poster_id": this.posterId,
      "updated_at": this.updatedAt.toIso8601String(),
      "image_url": this.imageUrl,
      "topics": topics,
    };
  }
  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? posterId,
    DateTime? updatedAt,
    String? imageUrl,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      posterId: posterId ?? this.posterId,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      posterName: posterName ?? this.posterName,
    );
  }
}
