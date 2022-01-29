import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  final int index;
  const MessageCard({Key? key, required this.snap, required this.index})
      : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    // to get some random minutes to show in message of person
    DateTime now = DateTime.now();

    return widget.snap['uid'] != FirebaseAuth.instance.currentUser!.uid
        ? Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(widget.snap['photoUrl']),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: const TextStyle(fontStyle: FontStyle.normal),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.snap['description'],
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          Text(
                            widget.index == 0 || widget.index == 1
                                ? '.now'
                                : widget.index == 2 || widget.index == 3
                                    ? '.${now.minute.toString()}m'
                                    : '.${now.hour.toString()}h',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: const Text('Take a Photo'),
                            children: [
                              SimpleDialogOption(
                                padding: const EdgeInsets.all(20),
                                child: const Text('Photo from Camera'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                              ),
                              SimpleDialogOption(
                                padding: const EdgeInsets.all(20),
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }),
                    icon: const Icon(Icons.camera_alt_outlined))
              ],
            ),
          )
        : const SizedBox(
            height: 1,
          );
  }
}
