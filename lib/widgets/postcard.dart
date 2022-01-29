import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.snap['profImage']),
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
                    const Text('Guwahati, India'),
                  ],
                ),
              )),
              IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('Delete a Post'),
                          children: [
                            SimpleDialogOption(
                              padding: const EdgeInsets.all(20),
                              child: const Text('Delete post'),
                              onPressed: () async {
                                FirestoreMethods()
                                    .deletePost(widget.snap['postId']);
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
                  icon: const Icon(
                    Icons.more_vert,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // image section
          SizedBox(
            //height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['postUrl'],
              fit: BoxFit.fill,
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    await FirestoreMethods().likePost(widget.snap['postId'],
                        widget.snap['uid'], widget.snap['likes']);
                    widget.snap['likes'].contains(widget.snap['uid'])
                        ? showSnackBar('You have disliked The Post', context)
                        : showSnackBar('You have Liked The Post', context);
                  },
                  icon: widget.snap['likes'].contains(widget.snap['uid'])
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border_outlined)),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.snap['likes'].length} likes',
                  style: const TextStyle(fontStyle: FontStyle.normal),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          children: [
                        TextSpan(
                            text: widget.snap['username'],
                            style:
                                const TextStyle(fontStyle: FontStyle.normal)),
                        TextSpan(
                            text: '  ${widget.snap['description']}',
                            style: const TextStyle(fontStyle: FontStyle.normal))
                      ])),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
