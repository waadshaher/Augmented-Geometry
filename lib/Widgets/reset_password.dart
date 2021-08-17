import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String email, newPassword, newPasswordConfirm;
  String success = "A password reset link has been sent to your email";
  String error = "Your Email seems to be invalid. Please try again";
  bool errorExist = false;
  DatabaseService databaseService = new DatabaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 6), content: Text(message)));
  }

  snackBarSuccess() {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 6), content: Text(success)));
  }

  Future<void> resetPassword(String email) async {
    bool checker = true;
    await _firebaseAuth
        .sendPasswordResetEmail(email: email)
        .catchError((onError) {
      if (onError.toString().contains("ERROR_USER_NOT_FOUND")) {
        snackBar(
            "There is no user record corresponding to this identifier. The user may have been deleted.");
        checker = false;
      } else if (onError
          .toString()
          .contains("An internal error has occurred")) {
        snackBar("An internal error has occurred");
        checker = false;
      } else if (onError.toString().contains("ERROR_INVALID_EMAIL")) {
        snackBar("The email address is badly formatted.");
        checker = false;
      }
    });
    if (checker) {
      snackBar("A password reset link has been sent to your Email");
    }
  }

  resetPass() async {
    if (_formKey.currentState.validate()) {
      dynamic result;
      resetPassword(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: headerNav(text: "Reset Password"),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Enter your Email address and a reset password link will be sent to you",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? "This is a required field" : null;
                  },
                  decoration: InputDecoration(hintText: "Email"),
                  onChanged: (val) {
                    email = val;
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    padding: EdgeInsets.all(1),
                    onPressed: () {},
                    child: Text(
                      "",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    resetPass();
                  },
                  child: submitButton(
                      context: context,
                      buttonWidth: MediaQuery.of(context).size.width,
                      label: "Send Reset Link"),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ));
  }
}
