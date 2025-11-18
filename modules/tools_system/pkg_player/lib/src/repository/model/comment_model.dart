class Comment {
  final int id;
  final int packageId;
  final int? parentId;
  final int userId;
  final String guestName;
  final String content;
  final String contentType;
  final int? rating;
  final String createAt;
  final List<Comment> replies;
  final int repliesTotal;

  Comment({
    required this.id,
    required this.packageId,
    this.parentId,
    required this.userId,
    required this.guestName,
    required this.content,
    required this.contentType,
    this.rating,
    required this.createAt,
    required this.replies,
    required this.repliesTotal,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      packageId: json['package_id'],
      parentId: json['parent_id'],
      userId: json['user_id'],
      guestName: json['guest_name'],
      content: json['content'],
      contentType: json['content_type'],
      rating: json['rating'],
      createAt: json['create_at'],
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e))
              .toList() ??
          [],
      repliesTotal: json['replies_total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_id': packageId,
      'parent_id': parentId,
      'user_id': userId,
      'guest_name': guestName,
      'content': content,
      'content_type': contentType,
      'rating': rating,
      'create_at': createAt,
      'replies': replies.map((e) => e.toJson()).toList(),
      'replies_total': repliesTotal,
    };
  }
}

class CommentsResponse {
  final List<Comment> data;
  final int total;

  CommentsResponse({
    required this.data,
    required this.total,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) {
    return CommentsResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => Comment.fromJson(e))
          .toList(),
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'total': total,
    };
  }
}