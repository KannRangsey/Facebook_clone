import 'package:get/get.dart';
import '../../../../data/models/comment.model.dart';
import '../../../../data/providers/api_provider.dart';
import 'home_controller.dart';

class CommentController extends GetxController {
  final ApiProvider provider = ApiProvider();
  var comments = <Comments>[]
      .obs; // comments is a list of comments that it is reactive variable
  var isLoading = true.obs; // reactive variable
  var errorMessage = ''.obs; // reactive variable

  // Fetch comments from the API
  Future<void> getComments({required String post_id}) async {
    /// Comment on postId
    try {
      // try catch is used to handle errors
      isLoading.value = true;
      final response = await provider.getComments(id: post_id, posts: 'posts');
      comments.value = response.comments ?? [];
      errorMessage.value = '';
      // update() is used to update the UI after fetching the data
      update();
    } catch (e) {
      // if error
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  final HomeController homeController = Get.find<HomeController>();
  Future<bool> createComment(
      {required String postId, required String text}) async {
    try {
      final response = await provider.addComment(postId: postId, text: text);
      if (response) {
        await getComments(post_id: postId);
        homeController.updateCommentsCount(
            postId, comments.length); // Update count
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      update();
    }
  }

  Future<void> deleteCommentbycommentID(
      {required String commentId, required String postId}) async {
    // delete comment by commentId on postId
    try {
      final status = await provider.deleteComment(commentId: commentId);
      if (status) {
        Get.snackbar('Success', 'Comment deleted successfully');
        await getComments(post_id: postId);
        homeController.updateCommentsCount(postId, comments.length);
      } else {
        Get.snackbar('Error', 'Failed to delete comment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      update();
    }
  }

  Future<void> updateComment(
      {required String commentId,
      required String text,
      required String postId}) async {
    // update comment by commentId on postId
    try {
      final status =
          await provider.editComment(commentId: commentId, text: text);
      if (status) {
        Get.snackbar('Success', 'Comment updated successfully');
        await getComments(post_id: postId);
        homeController.updateCommentsCount(
            postId, comments.length); // Update count
      } else {
        Get.snackbar('Error', 'Failed to update comment');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      update();
    }
  }
}
