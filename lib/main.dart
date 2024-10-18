
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_/Home/home_page.dart';
import 'package:flutter_app_/authentication/Login_Screen.dart';


import 'package:flutter_app_/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Activate Firebase App Check in Debug mode
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug, // Use debug provider during development
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'Flutter_App',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx,snapshot){
       
        if(snapshot.hasData){
            return  MainScreen();
        }
        return const LoginScreen();
      }),
    );
  }
}