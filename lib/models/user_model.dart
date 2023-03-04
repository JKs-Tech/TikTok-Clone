import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserModel {
  String name;
  String profilePhoto;
  String email;
  String uid;

  UserModel(
      {required this.email,
      required this.uid,
      required this.profilePhoto,
      required this.name});

  Map<String, dynamic> toJson() =>
      {"name": name, "uid": uid, "email": email, "profilePhoto": profilePhoto};

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        email: snap['email'],
        uid: snap['uid'],
        profilePhoto: snap["profilePhoto"],
        name: snap['name']);
  }
}
