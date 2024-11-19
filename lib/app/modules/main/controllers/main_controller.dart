import 'package:facebook_clone/app/modules/main/views/sub_view/home_view.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/profile_view.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/video_view.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/setting_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  var seletedIndex = 0;

  var pages = [
    // list of pages we want to show
    HomeView(),
    YouTubePlayerScreen(),
    const ProfileView(),
    SettingView(),
  ];
  void onItemTapped(int index) {
    // function use for tap on bottom nav
    seletedIndex =
        index; //update base on the index that we choose in bottom nav
    update(['index_stack', 'bottom_navigation_bar']); // update all widgets
  }

  final box = GetStorage();
  void logout() {
    box.remove('token');
    // back to login view
    Get.offAllNamed('/login');
  }
}
