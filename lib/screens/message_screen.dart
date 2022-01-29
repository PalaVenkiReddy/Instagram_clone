import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';
import 'package:instagram_clone_flutter_firebase/widgets/message_card.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  getUsername() async {
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
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userData['username'],
                    style: const TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Icon(Icons.keyboard_arrow_down_sharp)
                ],
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    /*
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PostScreen()));*/
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                  )),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      size: 25,
                    ))
              ],
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.grey[300],
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      iconColor: Colors.black,
                      //filled: true,
                      hintText: 'Search',
                      labelText: 'Search',
                      border: OutlineInputBorder(
                          borderSide: Divider.createBorderSide(context)),
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                            //physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => MessageCard(
                                  snap: snapshot.data!.docs[index].data(),
                                  index: index,
                                ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 25,
                  ),
                  Text(
                    ' Camera',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  )
                ],
              ),
            ),
          );
  }
}
