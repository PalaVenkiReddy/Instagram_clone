import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/login_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/signup_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 90,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Image.asset(
                          'assets/images/insta_logo.png',
                          color: Colors.white,
                          height: 75,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(200.0, 20.0, 200.0, 20.0),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    // adding sign up button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(190.0, 20.0, 190.0, 20.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
