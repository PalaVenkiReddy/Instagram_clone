import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_flutter_firebase/models/users.dart' as model;
import 'package:instagram_clone_flutter_firebase/resources/storage_methods.dart';

class AuthFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // to sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String description,
    required Uint8List file,
  }) async {
    String res = "Some Error occured";

    try {
      // check all the fields are filled first
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          description.isNotEmpty ||
          // ignore: unnecessary_null_comparison
          file != null) {
        // then register the user using user given information
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // to get the auto-generated id
        // ignore: avoid_print
        //print(credentials.user!.uid);

        // to get url of uploaded profile pic in firebase storage
        String photoUrl = await StorageMethods()
            .uploadImagetoStorage('ProfilePics', file, false);
        // to add user to firebase storage

        // another approach
        model.User user = model.User(
          username: username,
          uid: credentials.user!.uid,
          email: email,
          description: description,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore.collection('users').doc(credentials.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  // logging user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = "please fill the details";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
