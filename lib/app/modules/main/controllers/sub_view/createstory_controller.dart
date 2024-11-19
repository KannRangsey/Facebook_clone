import 'dart:io';

import 'package:facebook_clone/app/data/models/story_model.dart';
import 'package:facebook_clone/app/data/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CreateStoryController extends GetxController {
  final provider = ApiProvider();
  storemepmodel story = storemepmodel();
  final isLoding = false.obs;
  void createStory({required String text, required File image}) async {
    isLoding.value = true;
    try {
      final status = await provider.appstory(text: text, image: image);
      if (status) {
        Get.back(result: true); //close create post view after show snackbar
        Get.snackbar(
          'Success',
          'Post created successfully',
          snackbarStatus: (status) {},
        );
      } else {
        Get.snackbar('Error', 'Failed to create post');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
