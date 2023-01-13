// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:group_software/screens/splash/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Agenda Eletrônica',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
