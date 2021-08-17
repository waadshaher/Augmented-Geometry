import 'package:argeometry/Services/auth.dart';
import 'package:argeometry/Services/helper_functions.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/reset_password.dart';
import 'package:argeometry/Widgets/sign_up.dart';
import 'package:argeometry/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password, errorMsg;
  bool _isHidden = true;
  String error = "Username or password may be invalid";
  bool _isLoading = false;
  AuthService authService = new AuthService();
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  signIn() async {
    if (_formKey.currentState.validate()) {
      await authService.signInEmailAndPass(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          setState(() {
            errorMsg = error;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 3), content: Text(errorMsg)));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(text: 'User Sign In'),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      cursorColor: Colors.purple[300],
                      validator: (val) => checker(val),
                      decoration: textInputDecoration2("Email"),
                      onChanged: (val) => email = val,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.purple[300],
                      obscureText: _isHidden,
                      validator: (val) => checker(val),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple[300],
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.purple[300],
                            width: 2.0,
                          ),
                        ),
                        hintText: "Password",
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        padding: EdgeInsets.all(1),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()),
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () => signIn(),
                      child: submitButton(context: context, label: "Sign in"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? ',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Container(
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Colors.black87,
                                    decoration: TextDecoration.underline,
                                    fontSize: 17)),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
