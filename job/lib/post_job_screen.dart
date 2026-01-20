import 'package:flutter/material.dart';
import 'package:job/services/job_service.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  // 🔹 Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController employmentTypeController =
      TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBBD2F0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Employer Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Job Title'),
            _textField(titleController),

            _label('Category'),
            _dropdownField(),

            _label('Location'),
            _textField(locationController),

            _label('Employment time'),
            _textField(employmentTypeController),

            _label('Salary'),
            _textField(salaryController),

            _label('Description'),
            _descriptionField(),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBBD2F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await JobService().postJob(
                    title: titleController.text.trim(),
                    category: category ?? '',
                    location: locationController.text.trim(),
                    employmentType: employmentTypeController.text.trim(),
                    salary: salaryController.text.trim(),
                    description: descriptionController.text.trim(),
                  );

                  Navigator.pop(context);
                },
                child: const Text(
                  'Post Job',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Widgets ----

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }

  Widget _textField(TextEditingController controller) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }

  Widget _descriptionField() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: descriptionController,
        maxLines: 5,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _dropdownField() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: category,
          hint: const Text('Select category'),
          items: const [
            DropdownMenuItem(value: 'Education', child: Text('Education')),
            DropdownMenuItem(value: 'Health', child: Text('Health')),
            DropdownMenuItem(value: 'IT', child: Text('IT')),
            DropdownMenuItem(value: 'Business', child: Text('Business')),
          ],
          onChanged: (value) {
            setState(() {
              category = value;
            });
          },
        ),
      ),
    );
  }
}
