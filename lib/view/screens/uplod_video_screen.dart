import 'package:flutter/material.dart';
import 'package:tiktok_clone/config.dart';
import 'package:tiktok_clone/view/widgets/alertdilog.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgrouncolor,
      body: Center(
          child: InkWell(
        onTap: () {
          showVideoPicDialogBox(context);
        },
        child: Container(
          width: 190,
          height: MediaQuery.of(context).size.height / 17,
          decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
            child: Text(
              "Add Video",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )),
    );
  }
}
