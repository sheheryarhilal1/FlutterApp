import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportPastLinksScreen extends StatefulWidget {
  @override
  State<ImportPastLinksScreen> createState() => _ImportPastLinksScreenState();
}

class _ImportPastLinksScreenState extends State<ImportPastLinksScreen> {
  final TextEditingController linkController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _importVideo() {
    if (linkController.text.isEmpty || selectedDate == null) {
      Get.snackbar("Error", "Link and Date are required!",
          backgroundColor: Colors.red.shade400, colorText: Colors.white);
      return;
    }

    // TODO: Save the video data to controller/database
    debugPrint("Link: ${linkController.text}");
    debugPrint("Date: ${selectedDate.toString()}");
    debugPrint("Title: ${titleController.text}");
    debugPrint("Description: ${descriptionController.text}");

    // Clear fields after save
    linkController.clear();
    titleController.clear();
    descriptionController.clear();
    setState(() => selectedDate = null);

    Get.snackbar("Imported", "Video link imported successfully!",
        backgroundColor: Colors.green.shade700, colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade700,
        title: const Text("Import Past Links", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField("YouTube Link", linkController, isRequired: true),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today, color: Colors.white),
              label: Text(
                selectedDate == null
                    ? "Pick Date"
                    : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),
            _buildField("Title (Optional)", titleController),
            const SizedBox(height: 12),
            _buildField("Description (Optional)", descriptionController, maxLines: 3),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _importVideo,
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text("Import Video", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool isRequired = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: isRequired ? "$label *" : label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.brown.shade600,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
