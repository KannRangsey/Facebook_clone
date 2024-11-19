import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Reactioncontroller extends GetxController {
  var posts = <dynamic>[].obs; // List of posts (Observable for state management)

  // Function to set a reaction for a specific post
  void setReaction(String postId, int index, String reaction) {
    // Update the local post state
    posts[index].reaction = reaction;
    posts.refresh();

    // Send the reaction update to the backend
    _updateReactionOnServer(postId, reaction);
  }

  // Simulated backend update (replace with actual API call)
  Future<void> _updateReactionOnServer(String postId, String reaction) async {
    try {
      // Example: Replace with actual HTTP call
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      print('Reaction "$reaction" updated for post $postId on server');
    } catch (e) {
      print('Error updating reaction: $e');
    }
  }
}
