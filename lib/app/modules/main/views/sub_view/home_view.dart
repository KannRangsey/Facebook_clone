import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_clone/app/modules/main/controllers/sub_view/home_controller.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/comment_view.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/edit_post.dart';
import 'package:facebook_clone/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:readmore/readmore.dart';

import '../../controllers/profile_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final List<String> _Story = [
    'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    'https://cdn-icons-png.flaticon.com/512/149/149071.png',
  ];
  // Avoid redundant initialization
  final homeController = Get.put(HomeController());
  final profileController = Get.put(ProfileController());
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GetBuilder<ProfileController>(
                          builder: (profileController) {
                            if (profileController.isLoading) {
                              return const CircularProgressIndicator();
                            }
                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  profileController.user.user?.profileImage ==
                                          null
                                      ? const NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                        )
                                      : NetworkImage(
                                          "http://192.168.18.12:8000/images/${profileController.user.user!.profileImage!}",
                                        ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              hintText: 'What\'s on your mind?',
                              hintStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            checkPhotoPermission();
                            homeController.pickImage();
                          },
                          child: Container(
                            width: 43,
                            height: 43,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/up.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                      thickness: 3, color: Colors.grey.withOpacity(0.5)),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.23,
                          color: Colors.grey[200],
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 185,
                                            color: Colors.grey[300],
                                            width: 110,
                                            child: Image.network(
                                              "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/66848033-1500-412e-84e9-84ab12ac9f39/dfvztc0-6d31dd41-0a32-491e-b8dd-4da6f5ce703f.jpg/v1/fill/w_894,h_894,q_70,strp/ai_art___pretty_girl_by_habaricszs_dfvztc0-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTI4MCIsInBhdGgiOiJcL2ZcLzY2ODQ4MDMzLTE1MDAtNDEyZS04NGU5LTg0YWIxMmFjOWYzOVwvZGZ2enRjMC02ZDMxZGQ0MS0wYTMyLTQ5MWUtYjhkZC00ZGE2ZjVjZTcwM2YuanBnIiwid2lkdGgiOiI8PTEyODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.D9n5YcmFdfFEw6gryYN_wj5lDQjPVoE1chVITSERydk",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.blue,
                                              child: CircleAvatar(
                                                radius: 13,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 1,
                                            child: Container(
                                              width: 120.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blueGrey),
                                              child: Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10,
                                                    bottom: 5),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    checkPhotoPermission();
                                                    homeController.pickImage();
                                                  },
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                      thickness: 3, color: Colors.grey.withOpacity(0.5)),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = controller.posts.posts!.data![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      post.user!.profileImage != null
                                          ? CachedNetworkImageProvider(
                                              "http://192.168.18.12:8000/images/${post.user!.profileImage!}",
                                            )
                                          : const CachedNetworkImageProvider(
                                              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                            ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${post.user!.name}'),
                                    Text(timeago.format(
                                        DateTime.parse(post.createdAt!))),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == "edit") {
                                          Get.to(
                                              () => EditPostPage(post: post));
                                        } else {
                                          controller
                                              .deletePost(post.id.toString());
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ];
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(Icons.close),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8),
                            child: ReadMoreText(
                              post.caption ?? '',
                              trimLines: 1,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: ' Read more',
                              trimExpandedText: ' Read less',
                              style: const TextStyle(fontSize: 14),
                              moreStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (post.image != null)
                            Image.network(
                                "http://192.168.18.12:8000/posts/${post.image!}"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('${post.likesCount}'),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('${post.commentsCount}'),
                                    const SizedBox(width: 5),
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
                                  controller.likeDislike(
                                      post.id.toString(), index);
                                },
                                child: Row(
                                  children: [
                                    Icon(post.isLiked!
                                        ? Icons.favorite
                                        : Icons.favorite_outline),
                                    const SizedBox(width: 5),
                                    const Text('Like'),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => CommentView(
                                      post: post,
                                      index: 0,
                                      postId: post.id.toString()));
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.comment),
                                    SizedBox(width: 5),
                                    Text('Comment'),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Icon(Icons.share),
                                    SizedBox(width: 5),
                                    Text('Share'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    childCount: controller.posts.posts!.data!.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
