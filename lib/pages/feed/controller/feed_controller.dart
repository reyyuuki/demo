import 'package:demo/pages/feed/model/post_model.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  final RxList<PostModel> _posts = <PostModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadFeed();
  }

  void loadFeed() {
    _isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      _posts.value = _getStaticPosts();
      _isLoading.value = false;
    });
  }

  void toggleLike(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(
        isLiked: !post.isLiked,
        likes: post.isLiked ? post.likes - 1 : post.likes + 1,
      );
    }
  }

  void incrementComments(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(comments: post.comments + 1);
    }
  }

  void incrementShares(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(shares: post.shares + 1);
    }
  }

  List<PostModel> _getStaticPosts() {
    return [
      PostModel(
        id: '1',
        authorName: 'Prakash Chandra',
        authorTitle: 'Full Stack MERN Developer | 21K+ Followers',
        authorImage: 'https://via.placeholder.com/150',
        timeAgo: '5d',
        isVerified: true,
        content:
            'What will be the output of the following JavaScript code?\n\nconsole.log(1 + true + "3");\n\nA) "13true"\nB) "23"\nC) 5\nD) "1true3"',
        likes: 150,
        comments: 146,
        shares: 2,
      ),
      PostModel(
        id: '2',
        authorName: 'Sarah Johnson',
        authorTitle: 'UX/UI Designer | Product Design Lead',
        authorImage: 'https://via.placeholder.com/150',
        timeAgo: '1h',
        isVerified: false,
        content:
            'Just completed an amazing workshop on Design Systems! The key takeaways:\n\n• Consistency is everything\n• Start small, scale smart\n• Documentation saves lives\n• Collaboration over perfection\n\nWhat\'s your experience with design systems? Drop your thoughts below! 👇',
        likes: 89,
        comments: 23,
        shares: 7,
      ),
      PostModel(
        id: '3',
        authorName: 'Michael Chen',
        authorTitle: 'Senior Software Engineer at Google',
        authorImage: 'https://via.placeholder.com/150',
        timeAgo: '3h',
        isVerified: true,
        content:
            'Excited to share that our team just launched a new feature that improves app performance by 40%! 🚀\n\nThe journey wasn\'t easy - countless hours of debugging, optimizing algorithms, and team collaboration. But seeing the impact on millions of users makes it all worth it.\n\n#SoftwareEngineering #TeamWork #Innovation',
        postImage: 'https://via.placeholder.com/600x400',
        likes: 234,
        comments: 45,
        shares: 12,
      ),
      PostModel(
        id: '4',
        authorName: 'Emily Rodriguez',
        authorTitle: 'Marketing Manager | Digital Strategy Expert',
        authorImage: 'https://via.placeholder.com/150',
        timeAgo: '6h',
        isVerified: false,
        content:
            'Marketing tip of the day: Your audience doesn\'t care about your product features. They care about how your product makes their life better.\n\nFocus on benefits, not features. Tell stories, not specifications.\n\nWhat\'s the best marketing advice you\'ve ever received?',
        likes: 67,
        comments: 18,
        shares: 5,
      ),
      PostModel(
        id: '5',
        authorName: 'David Kim',
        authorTitle: 'Data Scientist | AI Enthusiast',
        authorImage: 'https://via.placeholder.com/150',
        timeAgo: '12h',
        isVerified: true,
        content:
            'The future of AI is not about replacing humans, but augmenting human capabilities.\n\nJust finished analyzing user behavior data for our latest product. The insights are fascinating:\n\n📊 85% of users prefer personalized experiences\n🎯 Engagement increases 3x with AI recommendations\n⚡ Response time improved by 60%\n\nData doesn\'t lie, but it does tell stories. What story is your data telling you?',
        postImage: 'https://via.placeholder.com/600x300',
        likes: 156,
        comments: 34,
        shares: 8,
      ),
    ];
  }
}
