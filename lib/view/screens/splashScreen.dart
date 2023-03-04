import 'package:flutter/material.dart';
import 'package:tiktok_clone/config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgrouncolor,
      body: Center(
          child: Image.asset(
        "assets/tiktok.png",
        height: 250,
        width: double.infinity,
      )),
    );
  }
}
