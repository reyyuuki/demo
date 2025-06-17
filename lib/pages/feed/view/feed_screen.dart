import 'package:demo/pages/feed/controller/feed_controller.dart';
import 'package:demo/pages/feed/view/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedController controller = Get.put(FeedController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.3),
        title: Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF0077B5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'LinkedIn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.message_outlined, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0077B5)),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.loadFeed();
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return PostCard(
                post: post,
                onLike: () => controller.toggleLike(post.id),
                onComment: () => controller.incrementComments(post.id),
                onShare: () => controller.incrementShares(post.id),
              );
            },
          ),
        );
      }),
    );
  }
}
