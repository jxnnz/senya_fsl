import 'package:flutter/material.dart';

class AdminSignsTab extends StatefulWidget {
  const AdminSignsTab({super.key});

  @override
  State<AdminSignsTab> createState() => _AdminSignsTabState();
}

class _AdminSignsTabState extends State<AdminSignsTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wordController = TextEditingController();
  String? _selectedLesson;
  String? _selectedUnit;
  String? _videoPath;

  List<String> lessons = ['Lesson 1', 'Lesson 2']; // Replace with dynamic data
  List<String> units = ['Unit A', 'Unit B']; // Replace with dynamic data

  void _pickVideo() async {
    // Placeholder: Implement video picker
    setState(() {
      _videoPath = 'assets/sample_video.mp4';
    });
  }

  void _saveWordAndVideo() {
    if (_formKey.currentState!.validate()) {
      // Submit to backend here
      print('Word: ${_wordController.text}');
      print('Lesson: $_selectedLesson');
      print('Unit: $_selectedUnit');
      print('Video: $_videoPath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Sign',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _wordController,
                  decoration: const InputDecoration(
                    labelText: 'Word (e.g., Hello)',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Enter a word'
                              : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedUnit,
                  decoration: const InputDecoration(
                    labelText: 'Select Unit',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      units.map((unit) {
                        return DropdownMenuItem(value: unit, child: Text(unit));
                      }).toList(),
                  onChanged: (value) => setState(() => _selectedUnit = value),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedLesson,
                  decoration: const InputDecoration(
                    labelText: 'Select Lesson',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      lessons.map((lesson) {
                        return DropdownMenuItem(
                          value: lesson,
                          child: Text(lesson),
                        );
                      }).toList(),
                  onChanged: (value) => setState(() => _selectedLesson = value),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.video_call),
                      label: const Text('Upload Video'),
                      onPressed: _pickVideo,
                    ),
                    const SizedBox(width: 12),
                    if (_videoPath != null) Text('Video selected'),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveWordAndVideo,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
