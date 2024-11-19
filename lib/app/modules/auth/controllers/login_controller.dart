import 'package:facebook_clone/app/modules/main/views/main_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_provider.dart';

class LoginController extends GetxController {
  final provider = ApiProvider(); // used to make Http requests to the server
  final box = GetStorage(); //

  // toggle password visibility
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  //

  void login({required String email, required String password}) async {
    try {
      final response = await provider.login(email: email, password: password);
      if (response.token != null) {
        box.write('token', response.token);// store the token in the local storage for future requests to the server 
        Get.snackbar('Success', 'User logged in successfully',
            snackbarStatus: (status) {
          if (status == SnackbarStatus.CLOSED) {
            Get.off(() => const MainView());// go to main view after login success
          }
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
