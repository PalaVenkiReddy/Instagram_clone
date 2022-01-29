import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> updateProfile(String uid, String username, String description,
      String email, String photoUrl) async {
    String res = "some error occurred";
    try {
      await _firestore.collection('users').doc(uid).update({
        'username': username,
        'email': email,
        'description': description,
        'photoUrl': photoUrl,
      });
      /*
      await FirebaseFirestore.instance.collection('posts').get().then(
          (QuerySnapshot querySnapshot) =>
              {querySnapshot.docs.forEach((doc) {
                if(doc.data()!.uid == uid)
              })});
       */

      StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            int count = snapshot.data!.docs.length;

            for (int i = 0; i < count; i++) {
              if (snapshot.data!.docs[i].data()['uid'] == uid) {
                snapshot.data!.docs[i].data()['username'] = username;
                snapshot.data!.docs[i].data()['profImage'] = photoUrl;
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
