import 'dart:io';
import 'package:argeometry/Services/auth.dart';
import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Widgets/button.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:argeometry/Widgets/signin.dart';
import 'package:argeometry/Widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class UserProfile extends StatefulWidget {
  String fullName, email, userID, pfp, newEmail, password;
  int userRole;
  bool loaded = false;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File _image;
  dynamic uploadedFileURL;
  String userID;
  final _formKey = GlobalKey<FormState>();
  String _currentFullName;
  String _currentEmail;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();

  void startInputAction(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: 350,
            decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1.0, color: Colors.white70)),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Update your personal information',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: widget.fullName,
                          decoration: textInputDecoration,
                          validator: (val) =>
                              val.isEmpty ? 'This is a required field' : null,
                          onChanged: (val) =>
                              setState(() => _currentFullName = val),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          initialValue: widget.email,
                          decoration: textInputDecoration,
                          validator: (val) =>
                              val.isEmpty ? 'This is a required field' : null,
                          onChanged: (val) =>
                              setState(() => _currentEmail = val),
                        ),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              final FirebaseUser user =
                                  await auth.currentUser();
                              final uid = user.uid;
                              userID = uid;
                              await DatabaseService(uid: userID).updateUserData(
                                userID,
                                _currentFullName ?? widget.fullName,
                                _currentEmail ?? widget.email,
                                widget.userRole,
                                widget.pfp,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: submitButton(
                              buttonWidth: MediaQuery.of(context).size.width,
                              context: context,
                              label: "Save"),
                        ),
                      ],
                    )),
              ],
            ),
          );
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
        inputData();
      } else {
        print('No image selected.');
      }
    });
  }

  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    userID = uid;
    uploadFile(userID);
  }

  Future uploadFile(String hello) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('quizImages/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        uploadedFileURL = fileURL;
        var collection = Firestore.instance.collection("users");
        collection
            .document(hello)
            .updateData({"profilePic": uploadedFileURL}).whenComplete(() async {
          print("done update picture");
        }).catchError((e) => print("error: " + e));
      });
    });
  }

  imageUpdated(bool val, String newImage) {
    if (val) {
      return CircleAvatar(
        radius: 70,
        child: ClipOval(
          child: Image.network(
            newImage,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  getUser() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        widget.userID = value.data['userID'].toString();
        widget.fullName = value.data['fullName'].toString();
        widget.email = value.data['email'].toString();
        widget.userRole = value.data['userRole'];
        widget.pfp = value.data['profilePic'].toString();
        widget.loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    checkRole() {
      switch (widget.userRole) {
        case 1:
          return Text(
            'I am a student in a classroom setting',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
          );
          break;
        case 2:
          return Text(
            'I am an independent learner',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
          );
          break;
        case 3:
          return Text(
            'I am a teacher',
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
          );
          break;
        default:
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Edit Profile',
            onPressed: () {
              startInputAction(context);
            },
          ),
        ],
        title: Text("My Profile"),
      ),
      drawer: NavDrawer(),
      body: widget.loaded
          ? Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(height: 24, width: 24),
                      Text(
                        'Profile Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(height: 24, width: 24)
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 70,
                      child: ClipOval(
                        child: Image.network(
                          widget.pfp,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            onPressed: () {
                              getImage();
                            },
                            icon: Icon(Icons.add_a_photo),
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.purple[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.purple[200], Colors.black26])),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                        child: Container(
                          height: 60,
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Full name:",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    widget.fullName,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                        child: Container(
                          height: 60,
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Email:",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    widget.email,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                        child: Container(
                          height: 60,
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "User role:",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: checkRole(),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Router router;
                                  await databaseService.deleteAccount();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()),
                                      (Route<dynamic> route) => false);
                                },
                                child: Center(
                                    child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    "Delete Account",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.purple[300]),
              ),
            ),
    );
  }
}

class NoProfile extends StatelessWidget {
  final String errorMsg;
  NoProfile(this.errorMsg);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorMsg,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
