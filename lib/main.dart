import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/video_controller.dart';
import 'View/admin_login screen.dart';
import 'View/archive_screen.dart';
import 'View/home_screen.dart';
import 'View/video_player_screen.dart';
// import 'View/admin_login_screen.dart';

void main() {
  runApp(SaturdayVibesApp());
}

class SaturdayVibesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(VideoController());

    return GetMaterialApp(
      title: 'Saturday Vibes',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/archive', page: () => ArchiveScreen()),
        GetPage(name: '/videoPlayer', page: () => VideoPlayerScreen()),
         GetPage(name: '/admin', page: () => AdminLoginScreen()),
      ],
    );
  }
}
