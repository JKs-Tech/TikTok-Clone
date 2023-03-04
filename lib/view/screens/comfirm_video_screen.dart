import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/config.dart';

import 'package:tiktok_clone/controller/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class ComfirmVideoScreen extends StatefulWidget {
  final File VideoFile;
  final String videopath;
  const ComfirmVideoScreen(
      {super.key, required this.VideoFile, required this.videopath});

  @override
  State<ComfirmVideoScreen> createState() => _ComfirmVideoScreenState();
}

class _ComfirmVideoScreenState extends State<ComfirmVideoScreen> {
  late VideoPlayerController controller;
  TextEditingController _songNameController = TextEditingController();
  TextEditingController _captionNameController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.VideoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    _songNameController.dispose();
    _captionNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgrouncolor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: VideoPlayer(controller),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextFormField(
                        controller: _songNameController,
                        decoration: InputDecoration(
                            labelText: " Song Name",
                            prefixIcon: const Icon(Icons.music_note),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16))),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextFormField(
                        controller: _captionNameController,
                        decoration: InputDecoration(
                            labelText: "Caption",
                            prefixIcon: const Icon(Icons.closed_caption),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16))),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Fluttertoast.showToast(
                                msg:
                                    "uploading Start please Wait while second");
                          });
                          uploadVideoController.uploadVideo(
                              _songNameController.text,
                              _captionNameController.text,
                              widget.videopath);
                        },
                        child: uploadVideoController.isLoadin
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              )
                            : const Text("Share!",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)))
                  ],
                ),
              )
            ],
          )),
        ));
  }
}
