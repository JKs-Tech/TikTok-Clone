import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  bool isLoadin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

// compress video before upload
  _compressVideo(String videopath) async {
    final compressVideo = await VideoCompress.compressVideo(videopath,
        quality: VideoQuality.DefaultQuality);
    return compressVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videopath) async {
    Reference ref = _firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videopath));
    TaskSnapshot snapshot = await uploadTask;
    String DownloadURL = await snapshot.ref.getDownloadURL();
    return DownloadURL;
  }
  //get thumbnail

  _getThumbnail(String videopath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videopath);
    return thumbnail;
  }

  // upload thumbnail to storage

  Future<String> _UplodThumbnailToStorage(String id, String videopath) async {
    Reference ref = _firebaseStorage.ref().child("thumbnail").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videopath));
    TaskSnapshot snapshot = await uploadTask;
    String DownloadURL = await snapshot.ref.getDownloadURL();
    return DownloadURL;
  }

//upload video
  uploadVideo(String songname, String caption, String videopath) async {
    try {
      isLoadin = true;
      String uid = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firebaseFirestore.collection('users').doc(uid).get();
      // get id

      var allDocs = await _firebaseFirestore.collection('videos').get();
      int len = allDocs.docs.length;

      String videoURL = await _uploadVideoToStorage("Video $len", videopath);

      String thumbnail =
          await _UplodThumbnailToStorage("Video $len", videopath);

      VideoModel videoModel = VideoModel(
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songname,
          caption: caption,
          videoUrl: videoURL,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
          thumbnail: thumbnail);

      await _firebaseFirestore
          .collection("videos")
          .doc("video $len")
          .set(videoModel.toJson());
      isLoadin = false;
      Fluttertoast.showToast(msg: "Video Uploaded Successfully");
      Get.back();
    } catch (e) {
      isLoadin = false;
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
