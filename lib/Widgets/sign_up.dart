import 'dart:io';
import 'package:argeometry/Widgets/button.dart';
import 'package:argeometry/Widgets/widgets.dart';
import 'package:path/path.dart' as Path;
import 'package:argeometry/Services/auth.dart';
import 'package:argeometry/Services/helper_functions.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:argeometry/Widgets/signin.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

int radioItem;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String userID, name, email, password, errorMsg;
  bool _isLoading = false;
  bool fileUploaded = false;
  bool _isHidden = true;
  AuthService authService = new AuthService();
  File _image;
  String uploadedFileURL;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    uploadFile();
  }

  Future uploadFile() async {
    setState(() {
      _isLoading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profilePics/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;

    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
        fileUploaded = true;
        _isLoading = false;
      });
    });
  }

  signUp(String theUrl) async {
    if (_formKey.currentState.validate()) {
      await authService
          .signUpWithEmailAndPass(email, password, name, radioItem, theUrl)
          .then((value) {
        if (value != null) {
          setState(() => _isLoading = false);
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (value == null) {
          setState(() {
            errorMsg =
                "There was a problem signing you up. Pleaase review your credentials.";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 4), content: Text(errorMsg)));
          });
        }
      });
    } else {
      setState(() {
        String error = "Please review your sign up form";
        errorMsg = error;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(duration: Duration(seconds: 4), content: Text(errorMsg)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(text: 'User Registeration'),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              registerForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Form registerForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              "Account Information",
              style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              cursorColor: Colors.purple[300],
              validator: (val) => checker(val),
              decoration: textInputDecoration2("Full Name"),
              onChanged: (val) => name = val,
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              cursorColor: Colors.purple[300],
              validator: (val) => checker(val),
              decoration: textInputDecoration2("Email"),
              onChanged: (val) => email = val,
            ),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              onChanged: (val) => password = val,
              cursorColor: Colors.purple[300],
              validator: (val) {
                return val.length < 6
                    ? "Passswords should be more than 6 characters"
                    : null;
              },
              obscureText: _isHidden,
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
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Tell us about yourself",
              style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            RadioButton(),
            SizedBox(
              height: 30,
            ),
            Text(
              "Upload your profile picture",
              style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            _image != null
                ? Image.file(_image)
                : Container(
                    height: 250,
                    width: 250,
                    child: RawMaterialButton(
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white,
                      ),
                      elevation: 8,
                      fillColor: Colors.purple[100],
                      onPressed: () {
                        getImage();
                      },
                      padding: EdgeInsets.all(15),
                    ),
                  ),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
                onTap: () {
                  if (fileUploaded) {
                    signUp(uploadedFileURL);
                  }
                },
                child: submitButton(
                    label: "Sign Up",
                    context: context,
                    enabled: fileUploaded,
                    loading: _isLoading)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ',
                    style: TextStyle(color: Colors.black87, fontSize: 17)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Container(
                    child: Text('Sign In',
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
    );
  }
}

class RadioButton extends StatefulWidget {
  @override
  RadioButtonWidget createState() => RadioButtonWidget();
}

class RadioButtonWidget extends State {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          activeColor: Colors.purple[300],
          groupValue: radioItem,
          title: Text('I am an independent learner'),
          value: 1,
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          activeColor: Colors.purple[300],
          groupValue: radioItem,
          title: Text('I am a student in a classroom setting'),
          value: 2,
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
        RadioListTile(
          activeColor: Colors.purple[300],
          groupValue: radioItem,
          title: Text('I am a teacher'),
          value: 3,
          onChanged: (val) {
            setState(() {
              radioItem = val;
            });
          },
        ),
      ],
    );
  }
}
