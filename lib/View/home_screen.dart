import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../Controller/video_controller.dart';
import 'Import Past link.dart';
import 'user_management_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VideoController controller = Get.find();
  // final VideoController controller = VideoController();


  late YoutubePlayerController ytController1;
  late YoutubePlayerController ytController2;
  late YoutubePlayerController ytController3;

  late bool isWide;
  late double screenWidth;

  @override
  void initState() {
    super.initState();

    final videoId1 =
        YoutubePlayer.convertUrlToId(controller.latestVideo.value.url)!;
    ytController1 = YoutubePlayerController(
      initialVideoId: videoId1,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );

    final videoId2 =
        YoutubePlayer.convertUrlToId(controller.latestVideo2.value.url)!;
    ytController2 = YoutubePlayerController(
      initialVideoId: videoId2,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );

    final videoId3 =
        YoutubePlayer.convertUrlToId(controller.archiveVideos[3].url)!;
    ytController3 = YoutubePlayerController(
      initialVideoId: videoId3,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    ytController1.dispose();
    ytController2.dispose();
    ytController3.dispose();
    super.dispose();
  }

  Widget buildVideoSection({
    required YoutubePlayerController ytController,
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown.shade800, width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.shade200,
                blurRadius: 10,
                offset: const Offset(3, 5),
              ),
            ],
          ),
          child: YoutubePlayer(
            controller: ytController,
            showVideoProgressIndicator: true,
            width: screenWidth < 500 ? screenWidth * 0.95 : 600,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: GoogleFonts.cinzel(
            fontSize: isWide ? 20 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.libreBaskerville(
            fontSize: isWide ? 16 : 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
onPressed: () => Navigator.pushNamed(context, '/archive'),
          icon: const Icon(Icons.archive_outlined),
          label: const Text("View Archive"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 23, 86, 121),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            textStyle: GoogleFonts.cinzel(
              fontSize: isWide ? 18 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    isWide = screenWidth > 700;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF3E5AB), Color(0xFFE0C097)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor:  Color.fromARGB(255, 238, 108, 82),

        appBar: AppBar(
          title: Text(
            'Saturday Vibes',
            style: GoogleFonts.cinzel(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          centerTitle: true,
          backgroundColor: const  Color.fromARGB(255, 23, 86, 121),

          elevation: 4,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu ,color: Colors.white,),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
             DrawerHeader(
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 23, 86, 121), // New background color
  ),
  child: Text(
    'Menu',
    style: GoogleFonts.cinzel(
      color: Colors.white,
      fontSize: 24,
    ),
  ),
),

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Get.back(),
              ),
              // ListTile(
              //   leading: const Icon(Icons.settings),
              //   title: const Text('Setting'),
              //   onTap: () {
              //     Get.back();
              //     Get.toNamed('/archive');
              //   },
              // ),
              ListTile(
  leading: const Icon(Icons.person),
  title: const Text('User Management'),
  onTap: () {
    Get.back(); // Close drawer
    Get.to(() => UserManagementScreen()); // Navigate to User Management
  },
),

             ListTile(
  leading: const Icon(Icons.link),
  title: const Text('Import Past Link'),
  onTap: () {
    Get.back(); // Close the drawer
    Get.to(() => PastVideosScreen()); // Navigate to the screen
  },
),
 ListTile(
                leading: const Icon(Icons.archive),
                title: const Text('Archive'),
                onTap: () {
                  Get.back();
                  Get.toNamed('/archive');
                },
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Admin'),
                onTap: () {
                  Get.back();
                  Get.toNamed('/admin');
                },
              ),
            ],
          ),
        ),
        
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: isWide ? 700 : double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildVideoSection(
                    ytController: ytController1,
                    title: controller.latestVideo.value.title,
                    description: controller.latestDescription.value,
                  ),
                  buildVideoSection(
                    ytController: ytController2,
                    title: controller.latestVideo2.value.title,
                    description: controller.latestDescription2.value,
                  ),
                  buildVideoSection(
                    ytController: ytController3,
                    title: controller.latestVideo3.value.title,
                    description: controller.latestDescription3.value,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}