import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';

import 'package:get/get.dart';
import 'package:tiktok_clone/view/screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => {Get.put(AuthController())});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'TikTok clone',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
