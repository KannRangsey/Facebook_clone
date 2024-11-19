import 'package:facebook_clone/app/modules/main/controllers/sub_view/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostPage extends StatelessWidget {
  final dynamic post;

  const EditPostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    TextEditingController captionController =
        TextEditingController(text: post.caption);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        actions: [
          TextButton(
            onPressed: () {
              controller.updatePost(
                caption: captionController.text,
                postId: post.id.toString(),
              );
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: captionController,
                      decoration: const InputDecoration(
                        labelText: 'Edit post',
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () {
                      return controller.image.value != null
                          ? Image.file(controller.image.value!)
                          : Image.network(
                              "http://172.20.10.3:8000/posts/${post.image!}");
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset:const Offset(0, 4),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  controller.pickImagetoUpdate();
                },
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                     SizedBox(width: 10),
                     Text(
                      'Upload new photo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
