import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _postContentController = TextEditingController();
  String? _selectedPhoto;

  bool get isPostButtonEnabled =>
      _postContentController.text.isNotEmpty || _selectedPhoto != null;

  void _onPost() {
    // Handle post creation logic here
    Navigator.pop(context); // Redirect back to Community Screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post created successfully!')),
    );
  }

  void _onSelectPhoto() {
    // Logic to select a photo
    setState(() {
      _selectedPhoto = 'Sample Photo'; // Placeholder for photo upload
    });
  }

  @override
  void dispose() {
    _postContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 165, 245),
        elevation: 0,
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: isPostButtonEnabled ? _onPost : null,
            child: Text(
              'Post',
              style: TextStyle(
                color: isPostButtonEnabled
                    ? const Color.fromARGB(255, 79, 165, 245)
                    : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info
              const Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Text(
                      'Y',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 79, 165, 245),
                      ),
                    ), // Placeholder for user's initials
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Yehia El Marghany', // Replace with actual user name
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Post Content Field
              TextFormField(
                controller: _postContentController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "What is on your mind...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Refresh to enable/disable Post button
                },
              ),
              const Spacer(),
              // Photo Button
              TextButton.icon(
                onPressed: _onSelectPhoto,
                icon: const Icon(
                  Icons.photo,
                  color: Color.fromARGB(255, 79, 165, 245),
                ),
                label: const Text(
                  'Photo',
                  style: TextStyle(
                    color: Color.fromARGB(255, 79, 165, 245),
                    fontSize: 16,
                  ),
                ),
              ),
              if (_selectedPhoto != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Photo Selected: $_selectedPhoto',
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
