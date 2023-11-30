import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AudioScreen extends StatefulWidget {
  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  List<String> videoIds = [
    'ksPR_l6JCYc',
    'WHPEKLQID4U',
    'eKFTSSKCzWA',
    '3uj5W2KamSQ',
    // Add more video IDs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.yellow.shade800,
      body: ListView.builder(
        itemCount: videoIds.length,
        itemBuilder: (context, index) {
          return AudioPlayerBar(videoId: videoIds[index]);
        },
      ),
    );
  }
}

class AudioPlayerBar extends StatefulWidget {
  final String videoId;

  AudioPlayerBar({required this.videoId});

  @override
  _AudioPlayerBarState createState() => _AudioPlayerBarState();
}

class _AudioPlayerBarState extends State<AudioPlayerBar> {
  late YoutubePlayerController _controller;
  bool isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true, // Set loop to true for auto-looping
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_controller.value.isReady && !isPlayerReady) {
      // The player is now ready. You can show UI elements.
      setState(() {
        isPlayerReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.0),
          YoutubePlayerBuilder(
            player: YoutubePlayer(controller: _controller),
            builder: (context, player) {
              return Column(
                children: <Widget>[
                  player,
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
