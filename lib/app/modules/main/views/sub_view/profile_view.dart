import 'package:facebook_clone/app/modules/main/controllers/profile_controller.dart';
import 'package:facebook_clone/app/modules/main/views/sub_view/create_story.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> _listfriends = [
      'https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp',
      'https://r2.erweima.ai/imgcompressed/compressed_3cd28ff945d3870ce452fd77a10fd54c.webp',
      'https://dogagingproject.org/_next/image?url=https%3A%2F%2Fcontent.dogagingproject.org%2Fwp-content%2Fuploads%2F2023%2F09%2Fhome-thumb-min.jpg&w=3840&q=75',
      'https://hips.hearstapps.com/hmg-prod/images/grey-cat-playing-royalty-free-image-1721750423.jpg?crop=0.752xw:1.00xh;0.178xw,0&resize=640:*',
      'https://transforms.stlzoo.org/production/animals/amur-tiger-01-01.jpg?w=1200&h=1200&auto=compress%2Cformat&fit=crop&dm=1658935145&s=95d03aceddd44dc8271beed46eae30bc',
      'https://wilang.org/wp-content/uploads/2016/04/lion-1.jpg',
    ];

    return Scaffold(
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = controller.user.user;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return StoryScreen();
                            },
                          ));
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.blue,
                        child: controller.user.user?.profileImage == null &&
                                controller.user.user?.profileImage == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "http://192.168.18.12:8000/images/${controller.user.user!.profileImage!}"),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${user?.name}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${user?.email}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3,
                          ),
                          children: const [
                            Card(
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                  '+Add friends',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            Card(
                              color: Color.fromARGB(255, 223, 229, 233),
                              child: Center(
                                child: Text(
                                  'Messages',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                            Card(
                              color: Color.fromARGB(255, 223, 229, 233),
                              child: Center(
                                child: Text(
                                  'More',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 223, 229, 233)),
                              ),
                              onPressed: () {},
                              child: const Text('Posts',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('About'),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Photos'),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Video'),
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Details", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.school_outlined,
                            color: Colors.black, size: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Study IT Program at BETIE international university",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.home_outlined,
                            color: Colors.black, size: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          " Phnom Penh, Cambodia",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: Colors.black, size: 30),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          " From Kapong Chang ,Kpong Chang ,Khmer Cambodia",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "2500 Friend",
                            style: TextStyle(fontSize: 15),
                          )),
                      TextButton(onPressed: () {}, child: Text("Find friends"))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 6 / 8),
                        itemCount: _listfriends.length,
                        itemBuilder: (context, index) {
                          final item = _listfriends[index];
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(item),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}
