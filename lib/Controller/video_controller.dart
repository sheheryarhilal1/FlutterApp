import 'package:get/get.dart';
import '../Model/video_model.dart';

class VideoController extends GetxController {
  var latestVideo = VideoModel(
    title: 'Saturday Vibes',
    url: 'https://www.youtube.com/watch?v=K18cpp_-gP8',
    dateSent: DateTime.now(),
  ).obs;

  var latestDescription = 'Start your weekend with energys 🌟'.obs;


  var latestVideo2 = VideoModel(
    title: 'Saturday Vibes2',
    url: 'https://www.youtube.com/watch?v=jNQXAC9IVRw',
    dateSent: DateTime.now(),
  ).obs;

  var latestDescription2 = 'Start your weekend with a  energy seam 🌟'.obs;

   var latestVideo3 = VideoModel(
    title: 'Saturday Vibes3',
    url: 'https://www.youtube.com/watch?v=ysz5S6PUM-U',
    dateSent: DateTime.now(),
  ).obs;

  var latestDescription3 = 'Start your weekend with a  energy  🌟'.obs;



  var archiveVideos = <VideoModel>[
    VideoModel(
      title: 'Saturday Vibes #1',
      url: 'https://www.youtube.com/watch?v=jNQXAC9IVRw',
      dateSent: DateTime(2024, 7, 13),
    ),
    VideoModel(
      title: 'Saturday Vibes #2',
      url: 'https://www.youtube.com/watch?v=ysz5S6PUM-U',
      dateSent: DateTime(2024, 7, 20),
    ),

    VideoModel(
      title: 'Saturday Vibes #1',
      url: 'https://www.youtube.com/watch?v=jNQXAC9IVRw',
      dateSent: DateTime(2024, 7, 13),
    ),
    VideoModel(
      title: 'Saturday Vibes #2',
      url: 'https://www.youtube.com/watch?v=ysz5S6PUM-U',
      dateSent: DateTime(2024, 7, 20),
    ),
    
  ].obs;
}
