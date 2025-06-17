class PostModel {
  final String id;
  final String authorName;
  final String authorTitle;
  final String authorImage;
  final String timeAgo;
  final String content;
  final String? postImage;
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final bool isVerified;

  PostModel({
    required this.id,
    required this.authorName,
    required this.authorTitle,
    required this.authorImage,
    required this.timeAgo,
    required this.content,
    this.postImage,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isVerified = false,
  });

  PostModel copyWith({
    String? id,
    String? authorName,
    String? authorTitle,
    String? authorImage,
    String? timeAgo,
    String? content,
    String? postImage,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
    bool? isVerified,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorTitle: authorTitle ?? this.authorTitle,
      authorImage: authorImage ?? this.authorImage,
      timeAgo: timeAgo ?? this.timeAgo,
      content: content ?? this.content,
      postImage: postImage ?? this.postImage,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
