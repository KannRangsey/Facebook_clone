import 'package:facebook_clone/app/constants/color.dart';
import 'package:facebook_clone/app/modules/main/controllers/sub_view/comment_controller.dart';
import 'package:facebook_clone/app/modules/main/controllers/sub_view/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentView extends GetView<CommentController> {
  final dynamic post;
  final int index;
  final String postId;

  const CommentView(
      {super.key,
      required this.post,
      required this.index,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    final CommentController myCommentcontroller = Get.put(CommentController());
    // Fetch comments when the widget is built
    myCommentcontroller.getComments(post_id: postId);
    final controller = Get.put(HomeController());
    TextEditingController captionController =
        TextEditingController(text: post.caption);

    final txtCommentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comment'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture and name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        post.user!.profileImage != null
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  "http://192.168.18.12:8000/images/${post.user!.profileImage}",
                                ),
                              )
                            : const CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage('https://i.pravatar.cc/300'),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${post.user!.name}'),
                              Text(timeago
                                  .format(DateTime.parse(post.createdAt!))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReadMoreText(
                      captionController.text, // The text to display
                      trimLines:
                          1, // Number of lines before showing "Read more"
                      colorClickableText:
                          Colors.blue, // Color of "Read more"/"Read less" text
                      trimMode: TrimMode.Line, // Trim based on lines
                      trimCollapsedText: ' Read more', // Text when collapsed
                      trimExpandedText: ' Read less', // Text when expanded
                      style: const TextStyle(
                        color: Colors.black, // Main text color
                      ),
                      moreStyle: const TextStyle(
                        color:
                            Colors.blue, // "Read more"/"Read less" text color
                        fontWeight: FontWeight
                            .bold, // Optional style for the toggle text
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () {
                      return controller.image.value != null
                          ? Image.file(controller.image.value!)
                          : Image.network(
                              "http://192.168.18.12:8000/posts/${post.image!}");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('${post.likesCount}'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('Likes'),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            Text('${post.commentsCount}'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text('Comments'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              controller.likeDislike(post.id.toString(), index);
                            },
                            child: Row(
                              children: [
                                post.isLiked!
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : const Icon(Icons.favorite_outline),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('Like'),
                              ],
                            )),
                        TextButton(
                            onPressed: () {
                              Get.to(() => CommentView(
                                  post: post, index: index, postId: postId));
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.comment),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Comment'),
                              ],
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(Icons.share),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Share'),
                              ],
                            )),
                      ]),
                  Divider(
                    thickness: 3,
                    color: Colors.grey.shade300,
                  ),
                  // List add comment
                  const SizedBox(height: 10),
                  Obx(() {
                    if (myCommentcontroller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (myCommentcontroller.errorMessage.isNotEmpty) {
                      return Center(
                          child: Text(
                              'Error: ${myCommentcontroller.errorMessage}'));
                    }

                    if (myCommentcontroller.comments.isEmpty) {
                      return const Center(child: Text('No comments found.'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: myCommentcontroller.comments.length,
                      itemBuilder: (context, index) {
                        final comment = myCommentcontroller.comments[index];
                        return ListTile(
                          leading: comment.user != null
                              ? CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    'http://192.18.12:8000/images/${comment.user?.profileImage}',
                                  ),
                                )
                              : null,
                          title: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: KTextField,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                  'http://192.18.12:8000/images/${comment.user?.profileImage ?? ''}',
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                comment.user?.name ??
                                                    'Unknown User',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            comment.text ?? '',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    PopupMenuButton<int>(
                                      icon: const Icon(Icons.more_horiz),
                                      onSelected: (value) {
                                        if (value == 1) {
                                          myCommentcontroller
                                              .deleteCommentbycommentID(
                                                  commentId:
                                                      comment.id.toString(),
                                                  postId: postId);
                                          // Call the Post Function to Refresh the Page
                                          //Refresh the UI
                                          controller.getPosts();
                                          Navigator.of(context).pop();
                                          print('Delete selected');
                                        } else if (value == 2) {
                                          // Show the edit bottom sheet
                                          TextEditingController
                                              textEditingController =
                                              TextEditingController(
                                                  text: comment.text);

                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(10.0),
                                              ),
                                            ),
                                            builder: (context) {
                                              return Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Edit Comment',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close)),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextFormField(
                                                        controller:
                                                            textEditingController,
                                                        style: const TextStyle(
                                                          // Text color inside the TextFormField
                                                          fontSize:
                                                              16, // Font size
                                                          fontWeight: FontWeight
                                                              .normal, // Font weight
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0,
                                                                  horizontal:
                                                                      15.0),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            // Border color
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            // Border color
                                                          ),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          filled: true,
                                                          fillColor: KTextField,
                                                          suffixIcon:
                                                              IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .send),
                                                                  onPressed:
                                                                      () {
                                                                    myCommentcontroller.updateComment(
                                                                        commentId: comment
                                                                            .id
                                                                            .toString(),
                                                                        text: textEditingController
                                                                            .text,
                                                                        postId:
                                                                            postId);
                                                                    //Refresh the UI
                                                                    controller
                                                                        .getPosts();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  color: Colors
                                                                      .black54),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                          print('Edit selected');
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 1,
                                          child: Text('Delete'),
                                        ),
                                        const PopupMenuItem(
                                          value: 2,
                                          child: Text('Edit'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      'just now',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Likes',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'Reply',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),

          // Upload Image and comment
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  // controller.pickImagetoUpdate();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: txtCommentController,
                        style: const TextStyle(
                          // Text color inside the TextFormField
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.normal, // Font weight
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey),
                            // Border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: KTextField),
                            // Border color
                          ),

                          hintText: 'Write a comment...',
                          hintStyle: const TextStyle(
                              color: Colors.grey), // Hint text color
                          filled: true,
                          fillColor:
                              KTextField, // Background color of the TextFormField
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                myCommentcontroller.createComment(
                                    postId: postId,
                                    text: txtCommentController.text);
                                txtCommentController.clear();
                                //Refresh the UI
                                controller.getPosts();
                                Navigator.of(context).pop();
                              },
                              color: Colors.black54),
                        ),
                      ),
                    )
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
