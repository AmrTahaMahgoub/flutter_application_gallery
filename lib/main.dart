import 'package:flutter/material.dart';
import 'package:flutter_application_gallery/screens/login_screen.dart';
import 'package:flutter_application_gallery/screens/upload_image_screen.dart';


void main() {
  runApp(const GalleryApp());
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}