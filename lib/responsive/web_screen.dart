import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/favorites_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/posts_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/profile_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/search_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  // to get user details
  var userData = {};
  bool isLoading = false;
  // to control the pages from bottomnavigationbar

  int page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getUserdetails();
  }

  getUserdetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
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
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void tappedIcon(int _page) {
    pageController.jumpToPage(_page);
  }

  void onPageChanged(int _page) {
    setState(() {
      page = _page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: PageView(
              children: [
                //Text('Home Screen'),
                const PostScreen(),
                //Text('Search screen'),
                const SearchPage(),
                //Text('addpost screen'),
                const AddPostScreen(),
                //const Text('Favorites screen'),
                const FavoritesScreen(),
                //Text('Profile screen'),
                ProfilePage(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                ),
              ],
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                        color: page == 0 ? Colors.white : Colors.grey),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,
                        color: page == 1 ? Colors.white : Colors.grey),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_box_outlined,
                        color: page == 2 ? Colors.white : Colors.grey),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border,
                        color: page == 3 ? Colors.red : Colors.grey),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                    ),
                    backgroundColor: Colors.white)
              ],
              onTap: tappedIcon,
            ),
          );
  }
}
