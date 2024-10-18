import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageGridScreen extends StatelessWidget {
  const ImageGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Images'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('images').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Display 2 images per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              String imageUrl = snapshot.data!.docs[index]['url'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              );
            },
          );
        },
      ),
    );
  }
}
