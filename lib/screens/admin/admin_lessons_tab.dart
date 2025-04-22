import 'package:flutter/material.dart';

class AdminLessonsTab extends StatefulWidget {
  const AdminLessonsTab({super.key});

  @override
  State<AdminLessonsTab> createState() => _AdminLessonsTabState();
}

class _AdminLessonsTabState extends State<AdminLessonsTab> {
  final List<Map<String, String>> _lessons = [
    {
      'number': '1',
      'title': 'Introduction to Signs',
      'unit': 'Unit 1',
      'description': 'Basic signs to start with.',
    },
    {
      'number': '2',
      'title': 'Greetings',
      'unit': 'Unit 1',
      'description': 'Common greetings in sign language.',
    },
  ];

  void _showAddLessonDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(16),
            content: SizedBox(
              height: 500,
              width: 1000,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Add Lesson',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Unit',
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Unit 1',
                                  child: Text('Unit 1'),
                                ),
                                DropdownMenuItem(
                                  value: 'Unit 2',
                                  child: Text('Unit 2'),
                                ),
                              ],
                              onChanged: (_) {},
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Lesson No.',
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Lesson Title',
                              ),
                            ),
                            TextFormField(
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Description',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Handle image selection
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Drop or Upload Image',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: _showAddLessonDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Lesson'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Lesson No.')),
                  DataColumn(label: Text('Lesson Title')),
                  DataColumn(label: Text('Unit')),
                  DataColumn(label: Text('Lesson Description')),
                  DataColumn(label: Text('Actions')),
                ],
                rows:
                    _lessons.map((lesson) {
                      return DataRow(
                        cells: [
                          DataCell(Text(lesson['number']!)),
                          DataCell(Text(lesson['title']!)),
                          DataCell(Text(lesson['unit']!)),
                          DataCell(Text(lesson['description']!)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
