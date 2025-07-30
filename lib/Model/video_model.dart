// class VideoModel {
//   final String title;
//   final String url;
//     final DateTime dateSent;

//   VideoModel({required this.title, required this.url,required this.dateSent});
// }

class VideoModel {
  final String title;
  final String url;
  final DateTime dateSent;
  final String? description;

  VideoModel({
    required this.title,
    required this.url,
    required this.dateSent,
    this.description,
  });
}

