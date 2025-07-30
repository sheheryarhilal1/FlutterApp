import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String videoUrl = Get.arguments;
    final String videoId = YoutubePlayer.convertUrlToId(videoUrl)!;

    final YoutubePlayerController ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: true),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Watch Video')),
      body: YoutubePlayer(controller: ytController),
    );
  }
}
