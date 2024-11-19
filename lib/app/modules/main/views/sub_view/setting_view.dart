import 'package:facebook_clone/app/modules/main/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:facebook_clone/app/modules/auth/controllers/logout_controller.dart'; // Ensure that this import points to your controller

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final LogoutController controller = Get.put(LogoutController());
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final List<String> _friendsShort = [
      'Friends',
      'Professional dashboard',
      'Memories',
      'Feeds',
      'Group',
      'Marketplace',
      'Events',
      'Pages',
      'More',
    ];
    final List<Icon> _listIcons = [
      const Icon(Icons.person, color: Colors.blue),
      const Icon(Icons.dashboard, color: Colors.blue),
      const Icon(Icons.memory, color: Colors.blue),
      const Icon(Icons.help),
      const Icon(Icons.group),
      const Icon(Icons.person_add),
      const Icon(Icons.event, color: Colors.red),
      const Icon(Icons.pages, color: Colors.orange),
      const Icon(Icons.more_horiz),
    ];
    final List<String> _settings = [
      "Help & Support",
      "Settings & Privacy",
      "Professional Access",
    ];
    final List<Icon> _listIcons2 = [
      const Icon(Icons.help),
      const Icon(Icons.settings),
      const Icon(Icons.person),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Your Shortcuts",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildListView(_friendsShort, _listIcons),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Settings",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _buildListView(_settings, _listIcons2),
            const SizedBox(height: 10),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
            ),
            const SizedBox(width: 10),
            const Text(
              'Kann Rangsey',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: const Icon(Icons.arrow_downward_outlined,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<String> items, List<Icon> icons) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: icons[index],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    items[index],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {
          controller.logout();
        },
        label: const Text(
          "Logout",
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.logout, color: Colors.black),
      ),
    );
  }
}
