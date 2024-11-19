import 'package:facebook_clone/app/data/models/user.model.dart';
import 'package:facebook_clone/app/data/providers/api_provider.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final provider = ApiProvider();
  UserResModel user = UserResModel();
  var isLoading = false;

  void updateUI(bool state) {
    isLoading = state;
    update();
  }

  void me() async {
    try {
      final user = await provider.getCurrentUserLoggedIn();

      updateUI(true);
      if (user.user != null) {
        this.user = user;
        updateUI(false);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    me();
    super.onInit();
  }
}
