import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/ui/auth/Login_Screen.dart';
import 'package:firebase_login/ui/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostScreen(),
              )));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              )));
    }
  }
}
