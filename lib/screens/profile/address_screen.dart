import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address';

  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final List<Map<String, String>> _addresses = [
    {
      'id': 'a1',
      'title': 'Home',
      'address': '123 Main St, Springfield, IL 62704',
    },
    {
      'id': 'a2',
      'title': 'Office',
      'address': '456 Business Rd, Metropolis, NY 10001',
    },
  ];

  void _addNewAddress() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add New Address', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address Title',
                  hintText: 'e.g., Home or Office',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.label_important_outline),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Full Address',
                  hintText: 'Street, City, State, Pincode',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('SAVE ADDRESS'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF020617) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('My Addresses'),
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _addresses.length,
        itemBuilder: (ctx, i) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              if (!isDark)
                BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1),
              child: const Icon(Icons.location_on, color: Color(0xFF3B82F6)),
            ),
            title: Text(_addresses[i]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(_addresses[i]['address']!, style: TextStyle(color: isDark ? Colors.white60 : Colors.grey)),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  _addresses.removeAt(i);
                });
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewAddress,
        label: const Text('Add New'),
        icon: const Icon(Icons.add),
        backgroundColor: isDark ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
    );
  }
}
