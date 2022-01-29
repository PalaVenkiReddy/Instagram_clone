import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_flutter_firebase/models/posts.dart';
import 'package:instagram_clone_flutter_firebase/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error occurred";
    try {
      String photourl =
          await StorageMethods().uploadImagetoStorage('posts', file, true);

      // to create the postid
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          likes: [],
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photourl,
          profImage: profImage);

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // updating likes
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      // if user is already liked the post, then onclicking like icon we dislike the post and viceversa

      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      // ignore: avoid_print
      print(error.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }
}
