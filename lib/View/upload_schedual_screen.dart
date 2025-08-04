import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/video_controller.dart';
import '../Model/video_model.dart';

class UploadScheduleScreen extends StatefulWidget {
  @override
  _UploadScheduleScreenState createState() => _UploadScheduleScreenState();
}

class _UploadScheduleScreenState extends State<UploadScheduleScreen> {
  final controller = Get.find<VideoController>();

  final TextEditingController linkController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // If needed, do additional initialization here
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _submit() {
    if (linkController.text.isNotEmpty && titleController.text.isNotEmpty && selectedDate != null) {
      final newVideo = VideoModel(
        title: titleController.text,
        url: linkController.text,
        dateSent: selectedDate!,
        description: descriptionController.text.isNotEmpty ? descriptionController.text : null,
      );
      controller.archiveVideos.add(newVideo);
      linkController.clear();
      titleController.clear();
      descriptionController.clear();
      selectedDate = null;
      setState(() {});
      Get.snackbar("Success", "Video Uploaded or Scheduled!");
    } else {
      Get.snackbar("Missing Info", "Please fill required fields and pick a date.");
    }
  }

  void _deleteVideo(int index) {
    controller.archiveVideos.removeAt(index);
    setState(() {});
  }

  void _editVideo(int index) {
    final video = controller.archiveVideos[index];
    final tempTitle = TextEditingController(text: video.title);
    final tempUrl = TextEditingController(text: video.url);
    final tempDescription = TextEditingController(text: video.description ?? '');
    DateTime tempDate = video.dateSent;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:Color.fromARGB(255, 238, 108, 82) ,
        title: Text('Edit Video', style: GoogleFonts.cinzel(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tempTitle,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: tempUrl,
                decoration: const InputDecoration(labelText: 'URL'),
              ),
              TextField(
                controller: tempDescription,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: tempDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => tempDate = picked);
                  }
                },
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                label: Text(
                  'Change Date: ${tempDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const  Color.fromARGB(255, 23, 86, 121) ,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (tempTitle.text.isNotEmpty && tempUrl.text.isNotEmpty) {
                controller.archiveVideos[index] = VideoModel(
                  title: tempTitle.text,
                  url: tempUrl.text,
                  description: tempDescription.text,
                  dateSent: tempDate,
                );
                setState(() {});
                Get.back();
                Get.snackbar("Updated", "Video updated successfully!");
              } else {
                Get.snackbar("Invalid", "Please fill all fields and pick a valid date.");
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
  color: Color.fromARGB(255, 253, 107, 78), // Replace with your desired solid color
),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor:const  Color.fromARGB(255, 23, 86, 121) ,
          title: Text(
            'Upload  Schedule Video',
            style: GoogleFonts.cinzel(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Video',
                    style: GoogleFonts.cinzel(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField("YouTube Video Link", linkController),
                  const SizedBox(height: 16),
                  _buildTextField("Title", titleController),
                  const SizedBox(height: 16),
                  _buildTextField("Quote/Description (Optional)", descriptionController, maxLines: 2,),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickDate,
                        icon: const Icon(Icons.calendar_today, color: Colors.white),
                        label: Text(
                          selectedDate == null
                              ? 'Pick Send Date'
                              : 'Scheduled: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const  Color.fromARGB(255, 23, 86, 121) ,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Upload'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const  Color.fromARGB(255, 23, 86, 121) ,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Divider(color: const  Color.fromARGB(255, 23, 86, 121) , thickness: 1.2),
                  const SizedBox(height: 10),
                  Text(
                    'Past Videos',
                    style: GoogleFonts.cinzel(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => controller.archiveVideos.isEmpty
                      ? const Text('No videos uploaded yet.')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.archiveVideos.length,
                          itemBuilder: (context, index) {
                            final video = controller.archiveVideos[index];
//                             return Card(
//   color:const  Color.fromARGB(255, 23, 86, 121), // Set background color here
//   margin: const EdgeInsets.symmetric(vertical: 8),
//   elevation: 3,
//   child: ListTile(
//     title: Text(
//       video.title,
//       style: GoogleFonts.cinzel(fontWeight: FontWeight.bold,color: Colors.white),
//     ),
//     subtitle: Text(
//   'Date: ${video.dateSent.toLocal().toString().split(' ')[0]}\n'
//   'URL: ${video.url}\n${video.description ?? ''}',
//   style: const TextStyle(color: Colors.white),
// ),

//     trailing: Wrap(
//       spacing: 8,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.edit, color: Colors.white),
//           onPressed: () => _editVideo(index),
//         ),
//         IconButton(
//           icon: const Icon(Icons.delete, color: Colors.white),
//           onPressed: () => _deleteVideo(index),
//         ),
//       ],
//     ),
//   ),
// );

                          },
                        )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    style: const TextStyle(color: Colors.white), // Text entered will be white
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.cinzel(color: Colors.white), // Label text white
      filled: true,
      fillColor: const Color.fromARGB(255, 23, 86, 121), // Background color of text field
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
}