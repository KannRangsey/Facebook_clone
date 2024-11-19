import 'dart:io';
import 'package:facebook_clone/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  final provider = ApiProvider();

  void createPost({required String caption, required File photo}) async {
    try {
      final status = await provider.createPost(caption: caption, photo: photo);
      if (status) {
        Get.back(result: true);//close create post view after show snackbar


        Get.snackbar('Success', 'Post created successfully',snackbarStatus: (status) {

        },);
      } else {
        Get.snackbar('Error', 'Failed to create post');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}