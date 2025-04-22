import 'package:flutter/material.dart';

class AdminUnitsTab extends StatefulWidget {
  const AdminUnitsTab({super.key});

  @override
  State<AdminUnitsTab> createState() => _AdminUnitsTabState();
}

class _AdminUnitsTabState extends State<AdminUnitsTab> {
  final TextEditingController _unitController = TextEditingController();
  final List<String> units = [];

  void _addUnit() {
    final text = _unitController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      units.add(text);
      _unitController.clear();
    });
  }

  void _deleteUnit(int index) {
    setState(() {
      units.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Unit',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Input field
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _unitController,
                  decoration: const InputDecoration(
                    labelText: 'Unit Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _addUnit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Divider(),

          const Text(
            'Units List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // List of units
          ...units.asMap().entries.map((entry) {
            final index = entry.key;
            final unit = entry.value;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(unit),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteUnit(index),
                ),
              ),
            );
          }),

          if (units.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'No units added yet.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
