import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Function to upload the image to Firebase Storage and save URL in Firestore
  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      await storageRef.putFile(_imageFile!);
      String downloadUrl = await storageRef.getDownloadURL();

      // Save download URL to Firestore
      await FirebaseFirestore.instance.collection('images').add({'url': downloadUrl});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image uploaded successfully!')));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick and Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display the picked image preview
            _imageFile != null
                ? Image.file(_imageFile!, height: 300, width: 300)
                : const Text('No image selected', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
