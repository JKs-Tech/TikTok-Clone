import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/view/screens/comfirm_video_screen.dart';
import 'dart:io';
//pic Video Function

pickVideo(ImageSource src, BuildContext context) async {
  final video = await ImagePicker().pickVideo(source: src);
  if (video != null) {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ComfirmVideoScreen(
              VideoFile: File(video.path), videopath: video.path),
        ));
  } else {
    Fluttertoast.showToast(msg: "Please Select the Video");
  }
}

showVideoPicDialogBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: const Color.fromARGB(255, 91, 89, 89),
        children: [
          SimpleDialogOption(
            onPressed: () {
              pickVideo(ImageSource.gallery, context);
            },
            child: Row(children: const [
              Icon(
                Icons.image,
                size: 21,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Gallery",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              )
            ]),
          ),
          SimpleDialogOption(
            onPressed: () {
              pickVideo(ImageSource.camera, context);
            },
            child: Row(children: const [
              Icon(
                Icons.camera_alt,
                size: 21,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Camera",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              )
            ]),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(children: const [
              Icon(
                Icons.cancel,
                size: 21,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              )
            ]),
          )
        ],
      );
    },
  );
}
