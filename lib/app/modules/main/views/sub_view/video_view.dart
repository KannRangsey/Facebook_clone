import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;
  @override
  void initState() {
    super.initState();

    _controller1 = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ', // Replace with your first YouTube video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller2 = YoutubePlayerController(
      initialVideoId:
          '3JZ_D3ELwOQ', // Replace with your second YouTube video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    _controller3 = YoutubePlayerController(
      initialVideoId:
          '9daCjOtBDWw', // Replace with your second YouTube video ID
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  Widget buildThumbnail(String videoId, String title, {String? placeholder}) {
    final thumbnailUrl = 'https://i3.ytimg.com/vi/$videoId';
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Image.network(
          thumbnailUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.network(
              placeholder ?? thumbnailUrl,
              fit: BoxFit.cover,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://i.pravatar.cc/300"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Never Gonna Give You Up",
                          style: TextStyle(fontSize: 20)),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    YoutubePlayer(
                      controller: _controller1,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      onReady: () {
                        print('Player 1 is ready.');
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      "15k Likes",
                      style: TextStyle(fontSize: 16),
                    ),
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("12k Comments", style: TextStyle(fontSize: 16)),
                    icon: Icon(
                      Icons.comment,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("2k Shares", style: TextStyle(fontSize: 16)),
                    icon: Icon(Icons.share),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://i.pravatar.cc/300"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Flexing on the Beach",
                          style: TextStyle(fontSize: 20)),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    YoutubePlayer(
                      controller: _controller2,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      onReady: () {
                        print('Player 2 is ready.');
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      "15k Likes",
                      style: TextStyle(fontSize: 16),
                    ),
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("2k Comments", style: TextStyle(fontSize: 16)),
                    icon: Icon(Icons.comment),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("1k Shares", style: TextStyle(fontSize: 16)),
                    icon: Icon(Icons.share),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://i.pravatar.cc/300"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("រឿងបងប្ដីអូនមែនបងប្រុសទេ",
                          style: TextStyle(fontSize: 20)),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    YoutubePlayer(
                      controller: _controller3,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      onReady: () {
                        print('Player 2 is ready.');
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    label: Text(
                      "5k Likes",
                      style: TextStyle(fontSize: 16),
                    ),
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("1k Comments", style: TextStyle(fontSize: 16)),
                    icon: Icon(Icons.comment),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("1k Shares", style: TextStyle(fontSize: 16)),
                    icon: Icon(Icons.share),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
