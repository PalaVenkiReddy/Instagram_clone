import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_fun.dart';
import 'package:instagram_clone_flutter_firebase/responsive/mobile_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/responsive_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/web_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/welcome_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/login_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';
import 'package:instagram_clone_flutter_firebase/widgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();
  final TextEditingController usernameEditingController =
      TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    usernameEditingController.dispose();
    descriptionEditingController.dispose();
  }

  // to select image from gallery
  Future<void> selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // to sign up user function
  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    // ignore: unused_local_variable
    String res = await AuthFunctions().signUpUser(
        email: emailEditingController.text,
        password: passwordEditingController.text,
        username: usernameEditingController.text,
        description: descriptionEditingController.text,
        file: _image!);

    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveScreen(
              WebScreen: WebScreen(), MobileScreen: MobileScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InitialScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/insta_logo.png',
                color: Colors.white,
                height: 75,
              ),
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
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/images/virat3.jpg'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 75,
                      child: IconButton(
                        color: Colors.pink,
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              const SizedBox(height: 20),
              TextInput(
                  hintText: 'Email',
                  isObscure: false,
                  textEditingController: emailEditingController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                  hintText: 'Password',
                  isObscure: true,
                  textEditingController: passwordEditingController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                  hintText: 'Username',
                  isObscure: false,
                  textEditingController: usernameEditingController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                  hintText: 'Description',
                  isObscure: false,
                  textEditingController: descriptionEditingController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * .230,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .30,
                    color: const Color(0xffA2A2A2),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .040,
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .30,
                    color: const Color(0xffA2A2A2),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account?",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .040,
                              fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text('Log in.'),
                        ),
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
