import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_fun.dart';
import 'package:instagram_clone_flutter_firebase/responsive/mobile_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/responsive_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/web_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/initial_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/signup_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';
import 'package:instagram_clone_flutter_firebase/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailEditingController.dispose();
    passwordEditingController.dispose();
  }

  // loginuser
  void loginUser() async {
    String res = await AuthFunctions().loginUser(
        email: emailEditingController.text,
        password: passwordEditingController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveScreen(
              WebScreen: WebScreen(), MobileScreen: MobileScreen())));
    } else {
      showSnackBar(res, context);
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
                height: 50,
              ),
              Image.asset(
                'assets/images/insta_logo.png',
                color: Colors.white,
                height: 75,
              ),
              const SizedBox(
                height: 20,
              ),
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
              SizedBox(
                height: MediaQuery.of(context).size.width * .00,
              ),
              Container(
                padding: const EdgeInsets.all(28.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: const Text(
                    'Log in',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
                  const Text(
                    'OR',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
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
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text(
                            'Sign Up.',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18),
                          ),
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
