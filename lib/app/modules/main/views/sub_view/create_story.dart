import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/sub_view/createstory_controller.dart';

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  File? image;
  final controller = Get.put(
      CreateStoryController()); //Call create post controller to use it in this view
  final captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
              onPressed: () {
                controller.createStory(
                    text: captionController.text, image: image!);
              },
              child: const Text('Post')),
        ],
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
                  contentPadding: EdgeInsets.symmetric(),
                  border: InputBorder.none, // Remove the border
                  enabledBorder: InputBorder.none, // Remove the enabled border
                  focusedBorder: InputBorder.none, // Remove the focused border
                  hintText: 'What\'s on your mind?', // Placeholder text
                ),
              ),
            ),
            image == null
                ? const Text('No image selected')
                : Image.file(
                    image!,
                    width: 200,
                    height: 200,
                  ),
            ElevatedButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    image = File(pickedFile.path);
                  });
                }
              },
              child: const Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}
