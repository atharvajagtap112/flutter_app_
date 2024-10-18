import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key,required this.onPickedImage});
  final void Function(File selectedImage) onPickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickedImage() async{
    final pickedImage= await ImagePicker().pickImage(source: ImageSource.camera ,imageQuality: 50,maxWidth: 150);
    if(pickedImage==null){
      return;
    }
    setState(() {
      _pickedImageFile=File(pickedImage.path);
    });

 widget.onPickedImage(_pickedImageFile!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImageFile!=null? FileImage(_pickedImageFile!):null,
        ),

        TextButton.icon(onPressed: _pickedImage,
        icon: const Icon(Icons.image) ,
        label: Text("Add Image",
        style: TextStyle(
          color: Theme.of(context).primaryColor
        ),),
       
        ),
        
        
      ],
    );
  }
}