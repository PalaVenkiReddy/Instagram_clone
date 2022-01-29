import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String description;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.description,
    required this.followers,
    required this.following,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      description: snapshot['description'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      username: snapshot['username'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "username": username,
        "description": description,
        "followers": followers,
        "following": following,
      };
}
