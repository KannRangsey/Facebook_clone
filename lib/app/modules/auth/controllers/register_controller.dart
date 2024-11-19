import 'dart:io';

import 'package:facebook_clone/app/data/providers/api_provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupController extends GetxController {
  final _imagePicker = ImagePicker();
  File? image; // optional image file can be null

  void pickImage() async {
    try {
      final XFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (XFile != null) {
        image = File(XFile.path);
        update();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  final provider = ApiProvider();// used to make Http requests to the server
  //Register user
  Future<bool> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await provider.register(
          name: name,
          email: email,
          password: password,
          image: image
      );
      if(response) {
        Get.snackbar('Success', 'User registered successfully');
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', e.toString());

      return false;
    }
  }
}
