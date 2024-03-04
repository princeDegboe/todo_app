import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
    final String id;
    final String content;
    final String userId;
    final String postId;
    final DateTime createdAt;
    final DateTime updatedAt;

    Comment({
        required this.id,
        required this.content,
        required this.userId,
        required this.postId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        userId: json["user_id"],
        postId: json["post_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "user_id": userId,
        "post_id": postId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
