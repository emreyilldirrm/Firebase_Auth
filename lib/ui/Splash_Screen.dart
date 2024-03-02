import 'package:firebase_login/firebase_services/Splash_Services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<SplashScreen> {
  SplashServices splashscreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.islogin(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Firebase Tutorials",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    ));
  }
}
