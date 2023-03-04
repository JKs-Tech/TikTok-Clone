import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/config.dart';
import 'package:tiktok_clone/view/screens/HomeScreen.dart';
import 'package:tiktok_clone/view/screens/message_screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/screens/search_screen.dart';
import 'package:tiktok_clone/view/screens/uplod_video_screen.dart';
import 'package:tiktok_clone/view/widgets/centerDegineButton.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final pages = [
    HomeVideoScreen(),
    const MessageScreen(),
    const UploadVideoScreen(),
    SearchScreen(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgrouncolor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          pageIndex = value;
          setState(() {});
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        unselectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 220, 200, 200)),
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 62, 62)),
        selectedFontSize: 15,
        selectedLabelStyle: const TextStyle(color: Colors.deepOrange),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
              ),
              label: "Message"),
          BottomNavigationBarItem(icon: CenterCustomeButton(), label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search_outlined,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: "Person")
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
