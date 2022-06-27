import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_login/net/auth.dart';
import 'package:home_login/screens/home_screen.dart';
import 'package:home_login/screens/signin_screen.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget currentPage = SignInScreen();
  final storage = new FlutterSecureStorage();
  AuthClass auth = AuthClass();

  @override
  void initState() {
    var d = const Duration(seconds: 3);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {

            return const SignInScreen();

            //return SignInScreen();
            return currentPage;

          },
        ),
        (route) => false,
      );
    });
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/chickenbg.jpeg'),
              fit: BoxFit.cover),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/ccc.png",
                fit: BoxFit.fitWidth,
                width: 300,
                height: 300,
              ),
              Text(
                "Poultry Master",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: mTitleTextColor),
              ),
            ]),
      ),
    );
  }

  void checklogin() async {
    String? token = await auth.getToken();
    // print("Shamod : " + token.toString());
    if (token != null) {
      // print("Shamod : login checking...");
      currentPage = HomeScreen();
      setState(() {});
    } else {
      currentPage = SignInScreen();
      setState(() {});
    }
  }
}
