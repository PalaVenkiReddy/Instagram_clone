import 'package:flutter/cupertino.dart';
import 'package:instagram_clone_flutter_firebase/models/users.dart';
import 'package:instagram_clone_flutter_firebase/resources/auth_fun.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthFunctions _authFunctions = AuthFunctions();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authFunctions.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
