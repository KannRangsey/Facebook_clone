import 'dart:io';
import 'package:facebook_clone/app/modules/main/controllers/sub_view/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CreatePostView extends StatelessWidget {
  final File photo; // optional image file can be null
CreatePostView({super.key, required this.photo});
 final controller = Get.put(CreatePostController()); //Call create post controller to use it in this view
 final captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(onPressed: () {
            controller.createPost(caption: captionController.text,photo: photo);
          }, child: const Text('Post')),
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 2,
                controller: captionController,
                style: const TextStyle(
                  fontSize: 16, // Font size
                  fontWeight: FontWeight.normal, // Font weight
                ),
                decoration: const InputDecoration(
                  contentPadding:  EdgeInsets.symmetric(
                      vertical: 2, horizontal: 10),
                  border: InputBorder.none, // Remove the border
                  enabledBorder: InputBorder.none, // Remove the enabled border
                  focusedBorder: InputBorder.none, // Remove the focused border

                  hintText: 'What\'s on your mind?',
                  hintStyle:  TextStyle(
                      color: Colors.grey), // Hint text color
                  filled: false, // Disable the fill color
                ),
              ),

            ),
            const SizedBox(height: 10),
            Image.file(photo),
          ],
        ),
      ),
    );
  }
}