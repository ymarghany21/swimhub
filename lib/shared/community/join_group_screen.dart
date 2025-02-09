import 'package:flutter/material.dart';

class JoinGroupScreen extends StatelessWidget {
  JoinGroupScreen({super.key});

  final List<Map<String, String>> _groups = [
    {'name': 'Swimming Enthusiasts', 'description': 'A group for swimmers'},
    {'name': 'Parents Circle', 'description': 'A group for parents'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 165, 245),
        elevation: 0,
        title: const Text(
          'Join Group',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 79, 165, 245),
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: _groups.length,
          itemBuilder: (context, index) {
            final group = _groups[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  group['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 79, 165, 245),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    group['description']!,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert,
                      color: Color.fromARGB(255, 79, 165, 245)),
                  onSelected: (value) {
                    if (value == 'Invite') {
                      _showSnackBar(context, 'Group URL copied!');
                    } else if (value == 'Leave') {
                      _showSnackBar(context, 'Left the group!');
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'Invite',
                      child: Text('Invite'),
                    ),
                    const PopupMenuItem(
                      value: 'Leave',
                      child: Text('Leave Group'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
