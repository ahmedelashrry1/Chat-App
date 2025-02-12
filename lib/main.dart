
// ignore_for_file: prefer_const_constructors
import 'package:chat_app/model/firebase_options.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/screens/splach_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/chat': (context) => ChatPage(email: '',),
      },
      debugShowCheckedModeBanner: false,
      home:SplashScreen()
    );
  }
}
