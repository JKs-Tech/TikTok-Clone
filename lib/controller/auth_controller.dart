import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/view/screens/bottomnavigation.dart';
import 'package:tiktok_clone/view/screens/authentication_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  late Rx<File?> _pickedImage;
  File? get ProfilePhoto => _pickedImage.value;
  late Rx<User?> _user;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _initialScreen);
  }

  User get user => _user.value!;

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const AuthenticationScreen());
    } else {
      Get.offAll(() => const BottomNavigationScreen());
    }
  }

  void selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      Fluttertoast.showToast(msg: "Image Selected Successfully");
    } else {
      Fluttertoast.showToast(msg: "Please Select Image");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //Uplod user profile image to firebase Storage
  Future<String> _uploadProfilePicToStorage(File image) async {
    Reference reference = _firebaseStorage
        .ref()
        .child("userProfile")
        .child(_auth.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  // Create Methoud to Register User

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // user Authentication an save firebase datastore

        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String DownlodURL = await _uploadProfilePicToStorage(image);
        UserModel userModel = UserModel(
            email: email,
            uid: _auth.currentUser!.uid,
            profilePhoto: DownlodURL,
            name: username);
        //uplod data on firestore
        await _firebaseFirestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(userModel.toJson());
        Fluttertoast.showToast(msg: "Sign Up Successfully");
      } else {
        Fluttertoast.showToast(msg: "Enter All fields & choose Profile Pic");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

// to login user

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) =>
                Fluttertoast.showToast(msg: "Logged in Successfully"));
      } else {
        Fluttertoast.showToast(msg: "Enter All fields");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void forgetPassword(String email, BuildContext context) async {
    if (email.isNotEmpty) {
      try {
        await _auth
            .sendPasswordResetEmail(email: email)
            .then((value) => Navigator.pop(context));
        Fluttertoast.showToast(msg: "Email Sent Successfully");
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Please Enter a Valid Email");
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
