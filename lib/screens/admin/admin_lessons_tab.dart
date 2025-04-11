import 'package:flutter/material.dart';

class AdminLessonsTab extends StatefulWidget {
  const AdminLessonsTab({super.key});

  @override
  State<AdminLessonsTab> createState() => _AdminLessonsTabState();
}

class _AdminLessonsTabState extends State<AdminLessonsTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedUnit;
  String? lessonImagePath;

  // Simulated units
  final List<String> _units = ['Unit 1', 'Unit 2', 'Unit 3'];

  Future<void> _pickImage() async {
    // TODO: Implement image picker
  }

  void _saveLesson() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save lesson to backend
      print('Lesson saved: ${_titleController.text}, $selectedUnit');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              'Create/Edit Lesson',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Lesson Title'),
              validator:
                  (value) =>
                      value == null || value.isEmpty ? 'Enter a title' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedUnit,
              decoration: const InputDecoration(labelText: 'Select Unit'),
              items:
                  _units
                      .map(
                        (unit) =>
                            DropdownMenuItem(value: unit, child: Text(unit)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => selectedUnit = value),
              validator: (value) => value == null ? 'Select a unit' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Lesson Description',
              ),
              maxLines: 3,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Enter a description'
                          : null,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Upload Lesson Image'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveLesson,
              child: const Text('Save Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}
