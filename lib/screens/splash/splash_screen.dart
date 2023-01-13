// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:group_software/screens/home_screen.dart';
import 'package:group_software/utils/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
    _loadWidget();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fieldbackground,
      body: Center(
        child: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo_group.png',
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
