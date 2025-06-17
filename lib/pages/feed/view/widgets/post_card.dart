// ignore_for_file: deprecated_member_use

import 'package:demo/pages/feed/model/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildContent(),
          if (post.postImage != null) _buildImage(),
          _buildEngagementStats(),
          const Divider(height: 1),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF0077B5),
            backgroundImage: NetworkImage(post.authorImage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        post.authorName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (post.isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: Color(0xFF0077B5),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  post.authorTitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  post.timeAgo,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        post.content,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          post.postImage!,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,

          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image, color: Colors.grey, size: 50),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEngagementStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (post.likes > 0) ...[
            const Icon(Icons.thumb_up, size: 16, color: Color(0xFF0077B5)),
            const SizedBox(width: 4),
            Text(
              '${post.likes}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
          const Spacer(),
          if (post.comments > 0) ...[
            Text(
              '${post.comments} comments',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
          if (post.comments > 0 && post.shares > 0) ...[
            Text(
              ' • ',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
          if (post.shares > 0) ...[
            Text(
              '${post.shares} reposts',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
            label: 'Like',
            color: post.isLiked ? const Color(0xFF0077B5) : Colors.grey[600]!,
            onTap: onLike,
          ),
          _buildActionButton(
            icon: Icons.comment_outlined,
            label: 'Comment',
            color: Colors.grey[600]!,
            onTap: onComment,
          ),
          _buildActionButton(
            icon: Icons.share_outlined,
            label: 'Share',
            color: Colors.grey[600]!,
            onTap: onShare,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
