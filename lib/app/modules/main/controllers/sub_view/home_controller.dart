import 'dart:io';
import 'package:facebook_clone/app/data/models/post.model.dart';
import 'package:facebook_clone/app/data/providers/api_provider.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/create_post_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var isLoading = false;
  final provider = ApiProvider();
  PostResModel posts = PostResModel();

  ///-------------------------------------

  final _imagePicker = ImagePicker();
  var image = Rx<File?>(null); // Make image observable

  void pickImage() async {
    try {
      final XFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (XFile != null) {
        image.value = File(XFile.path);
        final result = await Get.to(() => CreatePostView(
            photo: image
                .value!)); // navigate to create post view with image file as an argument that picked from gallery
        if (result) {
          //call get posts to refresh posts
          getPosts();
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  
  ///-------------------------------------
  void pickImagetoUpdate() async {
    try {
      final XFile? pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image.value = File(pickedFile.path); // Update the observable image
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  ///

  @override
  void onInit() {
    getPosts();
    super.onInit();
  }

  void updateUI(bool state) {
    isLoading = state;
    update();
  }

  // Get posts
  Future<void> getPosts() async {
    try {
      updateUI(true);
      final postData = await provider.getPosts();
      posts = postData;
      // Refresh the UI

      updateUI(false);
    } catch (e) {
      updateUI(false);
      Get.snackbar('Error', e.toString());
    } finally {
      updateUI(false);
    }
  }

  //Delete Post
  void deletePost(String id) async {
    try {
      final status = await provider.deletePost(postId: id);
      if (status) {
        Get.snackbar('Success', 'Post deleted successfully');
        await getPosts();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Like and dislike Post
  void likeDislike(String postId, int postIndex) async {
    try {
      final status = await provider.likeDislike(postId: postId);
      if (posts.posts!.data![postIndex].isLiked!) {
        posts.posts!.data![postIndex].isLiked = false;
        posts.posts!.data![postIndex].likesCount =
            posts.posts!.data![postIndex].likesCount! - 1;
      } else {
        posts.posts!.data![postIndex].isLiked = true;
        posts.posts!.data![postIndex].likesCount =
            posts.posts!.data![postIndex].likesCount! + 1;
      }
      if (status) {
        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //
  void updatePost({
    required String caption,
    required String postId,
  }) async {
    try {
      final status = await provider.updatePost(
        caption: caption,
        photo: image.value!, // Pass image if it's not null
        postId: postId,
      );
      if (status) {
        Get.back(result: true);
        Get.snackbar('Success', 'Post updated successfully');

        await getPosts();
      } else {
        Get.snackbar('Error', 'Failed to update post');
      }
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        Get.snackbar('Error', 'Unauthorized');
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  //
  void updateCommentsCount(String postId, int newCount) {
    final postIndex =
        posts.posts!.data!.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      posts.posts!.data![postIndex].commentsCount = newCount;
      update();
    }
  }

  
}
