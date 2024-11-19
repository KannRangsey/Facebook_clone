import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogoutController extends GetxController {
  final GetStorage box = GetStorage();

  void logout() {
    // Remove the saved token from storage
    box.remove('token');

    // Navigate back to the login view and clear the entire navigation stack
    Get.offAllNamed('/login');
  } 
}
