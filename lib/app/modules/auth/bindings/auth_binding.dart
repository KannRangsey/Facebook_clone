import 'package:facebook_clone/app/modules/auth/controllers/login_controller.dart';
import 'package:facebook_clone/app/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignupController());
  }
}