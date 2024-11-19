import 'package:facebook_clone/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialize the controller if it is not already put
    final MainController controller = Get.put(MainController()); //??
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Facebook',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align items to the end
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Vertically center the items
              children: [
                const SizedBox(
                    width: 10), // Add spacing between the image and icons
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 195, 192, 192),
                  ),
                  child: const Icon(Icons.search, color: Colors.black),
                ),
                const SizedBox(width: 10), // Add spacing between icons
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 195, 192, 192),
                  ),
                  child: Image.network(
                    "https://img.icons8.com/ios7/600/facebook-messenger.png",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GetBuilder<MainController>(
          id: 'index_stack',
          builder: (context) {
            return IndexedStack(
              index: controller.seletedIndex,
              children: controller.pages,
            );
          }),
      bottomNavigationBar: GetBuilder<MainController>(
          id: 'bottom_navigation_bar',
          builder: (_) {
            return BottomNavigationBar(
              onTap: controller.onItemTapped,
              currentIndex: controller.seletedIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_collection), label: 'Videos'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
              ],
            );
          }),
    );
  }
}
