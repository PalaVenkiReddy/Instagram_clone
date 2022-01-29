import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter_firebase/providers/user_provider.dart';
import 'package:instagram_clone_flutter_firebase/resources/firestore_methods.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _commentsController = TextEditingController();

  // to post the image
  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    try {
      String res = await FirestoreMethods().uploadPost(
          _commentsController.text, _file!, uid, username, profImage);

      if (res == "success") {
        showSnackBar("posted", context);
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (error) {
      showSnackBar(error.toString(), context);
    }
  }

  // to show dialog box on clicking upload icon
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Add a New Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
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
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _commentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add a post'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.camera_alt_rounded),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.photo_library))
        ],
      ),
      body: _file == null
          ? Center(
              child: IconButton(
                  onPressed: () => _selectImage(context),
                  icon: const Icon(Icons.file_upload_outlined)),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        //backgroundImage: AssetImage('assets/images/virat3.jpg'),
                        backgroundImage:
                            NetworkImage(userProvider.getUser.photoUrl),
                        radius: 75.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: MemoryImage(_file!),
                        radius: 75,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: _commentsController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: false,
                        hintText: 'write a comment',
                        labelText: 'comment',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () => postImage(
                            userProvider.getUser.uid,
                            userProvider.getUser.username,
                            userProvider.getUser.photoUrl),
                        child: const Text('Post')),
                  )
                ],
              ),
            ),
    );
  }
}
