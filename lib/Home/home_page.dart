import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_/Home/gridview_screen.dart';
import 'image_picker_screen.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(
            Icons.exit_to_app
          ))
        ],
        title: const Text('Image Picker and Display'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImagePickerScreen()),
                );
              },
              child: const Text('Pick and Upload Image'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageGridScreen()),
                );
              },
              child: const Text('View Uploaded Images'),
            ),
          ],
        ),
      ),
    );
  }
}
