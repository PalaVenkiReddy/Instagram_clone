import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/message_screen.dart';
import 'package:instagram_clone_flutter_firebase/widgets/postcard.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt_outlined),
        ),
        title: Image.asset(
          'assets/images/insta_logo.png',
          color: Colors.white,
          height: 40,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.live_tv_rounded,
                      )),
                  Positioned(
                      top: -5,
                      right: -10,
                      //left: 75,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 10,
                          )))
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MessageScreen()));
                  },
                  icon: const Icon(
                    Icons.message_outlined,
                  ))
            ],
          )
        ],
      ),
      body: Column(
        children: [
          //const Text('data'),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                UserWidget(
                  username: 'Your Story',
                  pic: 'virat1.jpg',
                ),
                UserWidget(
                  username: 'craig_love',
                  pic: 'virat3.jpg',
                ),
                UserWidget(
                  username: 'zackjohn',
                  pic: 'virat4.jpg',
                ),
                UserWidget(
                  username: 'kieron_d',
                  pic: 'virat5.jpg',
                ),
                UserWidget(
                  username: 'Rohit Sharma',
                  pic: 'virat6.jpg',
                ),
                UserWidget(
                  username: 'Rohit',
                  pic: 'virat2.png',
                ),
                UserWidget(
                  username: 'kohli',
                  pic: 'virat7.jpg',
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => PostCard(
                          snap: snapshot.data!.docs[index].data(),
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({Key? key, required this.username, required this.pic})
      : super(key: key);

  final String username;
  final String pic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(45),
            ),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  image: DecorationImage(
                      image: AssetImage('assets/images/$pic'),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          username,
          style: const TextStyle(fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
