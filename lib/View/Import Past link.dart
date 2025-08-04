// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ImportPastLinksScreen extends StatefulWidget {
//   @override
//   State<ImportPastLinksScreen> createState() => _ImportPastLinksScreenState();
// }

// class _ImportPastLinksScreenState extends State<ImportPastLinksScreen> {
//   final TextEditingController linkController = TextEditingController();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   DateTime? selectedDate;

//   void _pickDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   void _importVideo() {
//     if (linkController.text.isEmpty || selectedDate == null) {
//       Get.snackbar("Error", "Link and Date are required!",
//           backgroundColor: Colors.red.shade400, colorText: Colors.white);
//       return;
//     }

//     // TODO: Save the video data to controller/database
//     debugPrint("Link: ${linkController.text}");
//     debugPrint("Date: ${selectedDate.toString()}");
//     debugPrint("Title: ${titleController.text}");
//     debugPrint("Description: ${descriptionController.text}");

//     // Clear fields after save
//     linkController.clear();
//     titleController.clear();
//     descriptionController.clear();
//     setState(() => selectedDate = null);

//     Get.snackbar("Imported", "Video link imported successfully!",
//         backgroundColor: Colors.green.shade700, colorText: Colors.white);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:  Color.fromARGB(255, 238, 108, 82),
//       appBar: AppBar(
//         backgroundColor:const  Color.fromARGB(255, 23, 86, 121) ,
//         title: const Text("Import Past Links", style: TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildField("YouTube Link", linkController, isRequired: true),
//             const SizedBox(height: 12),
//             ElevatedButton.icon(
//               onPressed: _pickDate,
//               icon: const Icon(Icons.calendar_today, color: Colors.white),
//               label: Text(
//                 selectedDate == null
//                     ? "Pick Date"
//                     : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const  Color.fromARGB(255, 23, 86, 121) ,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _buildField("Title (Optional)", titleController),
//             const SizedBox(height: 12),
//             _buildField("Description (Optional)", descriptionController, maxLines: 3),
//             const SizedBox(height: 24),
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: _importVideo,
//                 icon: const Icon(Icons.save, color: Colors.white),
//                 label: const Text("Import Video", style: TextStyle(color: Colors.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const  Color.fromARGB(255, 23, 86, 121) ,
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildField(String label, TextEditingController controller, {bool isRequired = false, int maxLines = 1}) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: isRequired ? "$label *" : label,
//         labelStyle: const TextStyle(color: Colors.white),
//         filled: true,
//         fillColor: const  Color.fromARGB(255, 23, 86, 121) ,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }
// }

// past_videos_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/video_controller.dart';

class PastVideosScreen extends StatelessWidget {
  final controller = Get.find<VideoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 107, 78),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 86, 121),
        title: Text(
          'Past Videos',
          style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final videos = controller.archiveVideos;
        if (videos.isEmpty) {
          return const Center(
            child: Text(
              'No videos uploaded yet.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return Card(
              color: const Color.fromARGB(255, 23, 86, 121),
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              child: ListTile(
                title: Text(
                  video.title,
                  style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  'Date: ${video.dateSent.toLocal().toString().split(' ')[0]}\n'
                  'URL: ${video.url}\n${video.description ?? ''}',
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Get.back(); // Optional: return and open edit on main screen
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        controller.archiveVideos.removeAt(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

