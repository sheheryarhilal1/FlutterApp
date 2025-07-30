import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Controller/video_controller.dart';

class ArchiveScreen extends StatelessWidget {
  final VideoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Past Videos',
          style: GoogleFonts.cinzel(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6D4C41), // Antique dark brown
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF3E5AB),
              Color(0xFFE0C097),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          final videos = controller.archiveVideos;

          // Sort by date descending
          final sortedVideos = List.from(videos)
            ..sort((a, b) => b.dateSent.compareTo(a.dateSent));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedVideos.length,
            itemBuilder: (context, index) {
              final video = sortedVideos[index];
              final videoId = YoutubePlayer.convertUrlToId(video.url);
              final formattedDate = "${video.dateSent.day}/${video.dateSent.month}/${video.dateSent.year}";

              return Card(
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.brown.shade700, width: 1),
                ),
                color: Colors.brown.shade100.withOpacity(0.75),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoId!,
                          flags: const YoutubePlayerFlags(autoPlay: false),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        video.title,
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Sent on: $formattedDate",
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 14,
                          color: Colors.brown.shade800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            Get.toNamed('/videoPlayer', arguments: video.url);
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text("Play"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.brown.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
