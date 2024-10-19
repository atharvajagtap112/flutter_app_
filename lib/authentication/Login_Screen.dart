import 'dart:io';

import 'package:flutter_app_/User_Image_Picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

final _firebase=FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 bool _isObscured = true;
 var isLogin=true;
 var enteredEmail="";
 var enterdPassword="";
 File? selectedImage;
 var isAuthenticating=false;
 var enterdUsername="";
 final _form=GlobalKey<FormState>();
 
 
 void _submit() async{ 
  final isValid=_form.currentState!.validate();
  if(!isValid||(!isLogin&&selectedImage==null)){
      return;
  }
  _form.currentState!.save();
 try {
  setState(() {
    isAuthenticating=true;
  });
if(isLogin) {
   final UserCredential=await _firebase.signInWithEmailAndPassword(email: enteredEmail, password: enterdPassword);
}
else{
 
  final UserCredential= await _firebase.createUserWithEmailAndPassword(email: enteredEmail, password: enterdPassword);
       final storageRef=FirebaseStorage.instance.ref().child('user_images').child('${UserCredential.user!.uid }.jpg');   
        await storageRef.putFile(selectedImage!);
        final imageUrl=await storageRef.getDownloadURL();
        print(imageUrl);
        FirebaseFirestore.instance.collection('users').doc(UserCredential.user!.uid).
        set({
          'username':enterdUsername,
          'email':enteredEmail,
          'image_url':imageUrl
        }
        );
  }
   }
   on FirebaseAuthException catch (error){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message?? 'Authentication failed'))
    );
    setState(() {
      isAuthenticating=false;
    });
  }
}

 
 


 
  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center( 
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image(height: 150,
           image: AssetImage(isDark?'assets/logos/splash-logo-white.png': 'assets/logos/splash-logo-black.png',) 
     ),
     if(isLogin) Text("Welcome back, ",style:Theme.of(context).textTheme.headlineMedium),
     const SizedBox(height: TSizes.sm ,),
     
              Card(
                
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form( 
                    key: _form,
                    child: Column(
                      children: [
                        if(!isLogin)
                          UserImagePicker(onPickedImage: (SelectedImage){
                            selectedImage=SelectedImage;
                          },),
                        
                        
                        TextFormField(
                          decoration: const InputDecoration( 
                             prefixIcon: Icon(Iconsax.direct_right),
                                labelText: 'E-Mail'
                                                     ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if(value==null||value.trim().isEmpty||!value.contains('@')){
                              return 'Please enter a valid email address';
                            }
                            return null;

                          },
                          onSaved: (newValue) {
                            enteredEmail=newValue!;
                          },
                        ),
                      if(!isLogin)
                          TextFormField(
                          decoration: const InputDecoration(labelText: "Username",
                          prefixIcon: Icon(Iconsax.user)
                          ),
                          enableSuggestions: false
                          ,
                        validator: (value) {
                          if(value==null||value.isEmpty||value.trim().length<4){
                            return "Please enter at least 4 characters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          enterdUsername=newValue!;
                        },
                        ),
                      
                         TextFormField(
  decoration: InputDecoration(
    prefixIcon: const Icon(Iconsax.password_check),
    labelText: "Password",
    suffixIcon: IconButton(
      icon: Icon(
        _isObscured ? Icons.visibility_off : Icons.visibility, // Corrected here
      ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured; // Corrected here
        });
      },
    ),
  ),
  obscureText: _isObscured,
  validator: (value) {
    if (value == null ||
        value.trim().isEmpty ||
      
        value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  },
  onSaved: (newValue) {
    enterdPassword = newValue!;
  },
),

                        const SizedBox(height:12),
                        if(isAuthenticating)
                         const  CircularProgressIndicator(),
                        
                        if(!isAuthenticating)
                          ElevatedButton(onPressed:_submit, style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer

                        ), child:Text(isLogin?'Login':'Signup') ),
                        
                        if(!isAuthenticating)
                          TextButton(onPressed:(){ 
                        setState(() {
                          isLogin=!isLogin;
                        });},
                         child: Text(isLogin? 'Create an account':'I already have an account'))
                      ],
                    ),
                  ),
                ),
                
              )

            ],
          ),
        ),
      ),
    );
  }
}
