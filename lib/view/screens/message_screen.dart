import 'package:flutter/material.dart';
import 'package:tiktok_clone/config.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgrouncolor,
      body: const Center(
          child: Text(
        "We are Working on this Function, it will be live ASAP ",
        style: TextStyle(color: Colors.white, fontSize: 15),
      )),
    );
  }
}
