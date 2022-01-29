// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/providers/user_provider.dart';
import 'package:instagram_clone_flutter_firebase/utils/dimensions.dart';
import 'package:provider/provider.dart';

class ResponsiveScreen extends StatefulWidget {
  final Widget WebScreen;
  final Widget MobileScreen;
  const ResponsiveScreen(
      {Key? key, required this.WebScreen, required this.MobileScreen})
      : super(key: key);

  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  // add data
  addData() async {
    // ignore: unused_local_variable
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.WebScreen;
      }
      return widget.MobileScreen;
    });
  }
}
