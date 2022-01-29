import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_fun.dart';
import 'package:instagram_clone_flutter_firebase/resources/follow_methods.dart';
import 'package:instagram_clone_flutter_firebase/screens/change_password.dart';
import 'package:instagram_clone_flutter_firebase/screens/editprofile_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/initial_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  int postLen = 0;
  // if we want to see others profile from search page
  int postsUser = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      var post = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      postsUser = post.docs.length;
      postLen = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      userData = userSnap.data()!;
      setState(() {});
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            //backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser!.uid != widget.uid) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: FirebaseAuth.instance.currentUser!.uid == widget.uid
                      ? const Icon(
                          Icons.lock_rounded,
                          color: Colors.white,
                        )
                      : const Icon(Icons.arrow_back)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    userData['username'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                        size: 20,
                      ))
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_box_outlined,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  alignment: Alignment.center,
                                  backgroundColor: Colors.grey[850],
                                  children: [
                                    SimpleDialogOption(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.logout_rounded),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("LOG OUT")
                                        ],
                                      ),
                                      onPressed: () async {
                                        await AuthFunctions().signOut();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const InitialScreen()));
                                      },
                                    ),
                                    SimpleDialogOption(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.security_sharp),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Change Password")
                                        ],
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PasswordChange()));
                                      },
                                    ),
                                    SimpleDialogOption(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.clear),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("CANCEL")
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }),
                          icon: const Icon(
                            Icons.menu_rounded,
                            size: 25,
                          )),
                    ],
                  ),
                )
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      FirebaseAuth.instance.currentUser!.uid ==
                                              widget.uid
                                          ? postLen.toString()
                                          : postsUser.toString(),
                                    ),
                                    const Text(
                                      'Posts',
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      followers.toString(),
                                    ),
                                    const Text(
                                      'Followers',
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      following.toString(),
                                    ),
                                    const Text(
                                      'Following',
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15, left: 10),
                        child: Text(
                          userData['username'],
                          style: const TextStyle(fontStyle: FontStyle.normal),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 2, left: 10),
                        child: Text(
                          userData['description'],
                          style: const TextStyle(fontStyle: FontStyle.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FirebaseAuth.instance.currentUser!.uid == widget.uid
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  //onSurface: Colors.black,
                                  fixedSize: const Size(500, 50),
                                  side: const BorderSide(
                                      color: Colors.white, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile(
                                          description: userData['description'],
                                          email: userData['email'],
                                          uid: userData['uid'],
                                          username: userData['username'],
                                          photoUrl: userData['photoUrl'],
                                        )));
                              },
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(
                                    150.0, 10.0, 150.0, 10.0),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            )
                          : isFollowing
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      //onSurface: Colors.black,
                                      //fixedSize: const Size(450, 50),
                                      side: const BorderSide(
                                          color: Colors.white, width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  onPressed: () async {
                                    await FollowMethods().followUser(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        userData['uid']);
                                    showSnackBar("unfollow", context);
                                    setState(() {
                                      isFollowing = false;
                                      followers--;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        170.0, 10.0, 170.0, 10.0),
                                    child: Text(
                                      'UnFollow',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      //onSurface: Colors.black,
                                      //fixedSize: const Size(450, 50),
                                      side: const BorderSide(
                                          color: Colors.white, width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  onPressed: () async {
                                    await FollowMethods().followUser(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        userData['uid']);
                                    showSnackBar('Follow', context);
                                    setState(() {
                                      isFollowing = true;
                                      followers++;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        170.0, 10.0, 170.0, 10.0),
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 0.25,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white24,
                    ),
                  ],
                ),
                const Divider(),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            //crossAxisSpacing: 1,
                            //mainAxisSpacing: 1,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];

                            return Container(
                              padding: const EdgeInsets.all(1),
                              child: Image(
                                image: NetworkImage(snap['postUrl']),
                                fit: BoxFit.cover,
                              ),
                            );
                          });
                    })
              ],
            ),
          );
  }
}
