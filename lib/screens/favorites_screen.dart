import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/message_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: InkWell(
                child: Text(
                  'Following',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: InkWell(
                child: Text('You',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal)),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.48,
                    color: Colors.white24,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.48,
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Follow Requests',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.94,
                    color: Colors.white24,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'New',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: const [
                                    Text(
                                      'kohli liked your photo.',
                                    ),
                                    Text(
                                      '1h',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        ClipRect(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 1,
                              heightFactor: 1,
                              child: Image.asset('assets/images/virat3.jpg'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.94,
                    color: Colors.white24,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Today',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Stack(
                          children: const [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/images/virat3.jpg'),
                            ),
                            Positioned(
                                bottom: -13,
                                left: 13,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 17,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundImage:
                                        AssetImage('assets/images/virat6.jpg'),
                                  ),
                                ))
                          ],
                          clipBehavior: Clip.none,
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: const [
                                    Text(
                                      'kohli & 26 others liked your photo.',
                                    ),
                                    Text(
                                      '3h',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        ClipRect(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 1,
                              heightFactor: 1,
                              child: Image.asset('assets/images/virat3.jpg'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.94,
                    color: Colors.white24,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'This Week',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Anushka mentioned you in comment.. ',
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                    Text(
                                      '2d',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        ClipRect(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 1,
                              heightFactor: 1,
                              child: Image.asset('assets/images/virat3.jpg'),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isLiked == true) {
                                    isLiked = false;
                                  } else {
                                    isLiked = true;
                                  }
                                });

                                if (isLiked) {
                                  showSnackBar(
                                      "You Liked the comment", context);
                                }
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.grey,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Reply',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: const [
                                    Text(
                                      'kohli started following you.',
                                    ),
                                    Text(
                                      '3d',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MessageScreen()));
                          },
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Text('Message'),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: const [
                                    Text(
                                      'kohli started following you.',
                                    ),
                                    Text(
                                      '3d',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MessageScreen()));
                          },
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Text('Message'),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: const [
                                    Text(
                                      'kohli started following you.',
                                    ),
                                    Text(
                                      '3d',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        Container(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 4),
                            child: Text('Follow'),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * 0.94,
                    color: Colors.white24,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'This Month',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: const [
                                    Text(
                                      'kohli started following you.',
                                    ),
                                    Text(
                                      '3d',
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ))),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MessageScreen()));
                          },
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              child: Text('Message'),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
