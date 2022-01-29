import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter_firebase/resources/storage_methods.dart';
import 'package:instagram_clone_flutter_firebase/resources/update_methods.dart';
import 'package:instagram_clone_flutter_firebase/responsive/mobile_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/responsive_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/web_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';

class EditProfile extends StatefulWidget {
  final String username;
  final String email;
  final String uid;
  final String description;
  final String photoUrl;
  const EditProfile(
      {Key? key,
      required this.description,
      required this.email,
      required this.uid,
      required this.username,
      required this.photoUrl})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;

  // controllers for fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();

  // creating firebase instance
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _photoUrl;
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    usernameController.text = widget.username;
    descriptionController.text = widget.description;
    _photoUrl = widget.photoUrl;
  }

  Future<void> selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResponsiveScreen(
                            WebScreen: WebScreen(),
                            MobileScreen: MobileScreen())));
                  },
                  icon: const Icon(
                    Icons.clear_rounded,
                    size: 30,
                  )),
              title: const Text('Edit Profile'),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IconButton(
                      onPressed: () async {
                        // ignore: unused_local_variable
                        String res = await UpdateMethods().updateProfile(
                            //FirebaseAuth.instance.currentUser!.uid,
                            widget.uid,
                            usernameController.text,
                            descriptionController.text,
                            widget.email,
                            _image != null
                                ? await StorageMethods().uploadImagetoStorage(
                                    'ProfilePics', _image!, false)
                                : _photoUrl);
                        showSnackBar('Successfully Edited', context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ResponsiveScreen(
                                WebScreen: WebScreen(),
                                MobileScreen: MobileScreen())));
                      },
                      icon: const Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.blue,
                      )),
                )
              ],
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: MemoryImage(_image!),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(_photoUrl),
                                  ),
                          ],
                          clipBehavior: Clip.none,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: selectImage,
                          child: const Center(
                            child: Text(
                              'Change profile photo',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          //controller: usernameController,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Website',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          cursorColor: Colors.green[200],
                          controller: descriptionController,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Bio',
                              labelStyle: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          'Switch to professional account',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontStyle: FontStyle.normal),
                        ),
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
                  const SizedBox(
                    height: 10,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          'Personal information settings',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontStyle: FontStyle.normal),
                        ),
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
                ],
              ),
            )),
          );
  }
}
