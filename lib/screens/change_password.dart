import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/screens/welcome_screen.dart';
import 'package:instagram_clone_flutter_firebase/utils/utils.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({Key? key}) : super(key: key);

  @override
  _PasswordChangeState createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  // to check validations
  final _formkey = GlobalKey<FormState>();

  var newPassword = " ";

  // password controller
  final TextEditingController _passwordController = TextEditingController();

  // dispose
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  // to change the password
  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const InitialScreen()));
      // to show the message your password changed
      showSnackBar('Your password changed, Login again', context);
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.clear_outlined)),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Update Password'),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.security),
          ),
        ],
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter new password',
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.white)),
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      showSnackBar('Please enter password', context);
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        newPassword = _passwordController.text;
                      });
                      changePassword();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text('Change Password'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
