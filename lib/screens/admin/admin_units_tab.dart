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
    if (_unitController.text.isEmpty) return;
    setState(() {
      units.add(_unitController.text);
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Unit',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _unitController,
            decoration: const InputDecoration(labelText: 'Unit Name'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _addUnit, child: const Text('Add Unit')),
          const Divider(height: 32),
          const Text(
            'Units List',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...units.asMap().entries.map((entry) {
            final index = entry.key;
            final unit = entry.value;
            return ListTile(
              title: Text(unit),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteUnit(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}
