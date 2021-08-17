import 'package:argeometry/Services/auth.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:argeometry/Widgets/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  dynamic user;
  AuthService authService = new AuthService();

  getUser() async {
    user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    if (user == null) {
      return SignIn();
    } else {
      return HomePage();
    }
  }
}
