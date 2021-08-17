import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Teacher/add_question.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/button.dart';
import 'package:argeometry/Widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:async';
import 'dart:io';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDesc, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  bool checkedValue = false;
  bool fileUploaded = false;
  File _image;
  String uploadedFileURL;
  Map<String, String> quizMap;
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
        .child('quizImages/${Path.basename(_image.path)}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(text: "Creating New Quiz"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  validator: (val) => checker(val),
                  cursorColor: Colors.purple[300],
                  decoration: textInputDecoration2("Quiz Title"),
                  onChanged: (val) => quizTitle = val,
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  validator: (val) => checker(val),
                  cursorColor: Colors.purple[300],
                  decoration: textInputDecoration2("Quiz Description"),
                  onChanged: (val) => quizDesc = val,
                ),
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quiz Image",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(
                  height: 16,
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
                  height: 6,
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        if (fileUploaded) {
                          setState(() {});
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddQuestion(0,
                                        quizTitle, quizDesc, uploadedFileURL)));
                          });
                        }
                      }
                    },
                    child: submitButton(
                        context: context,
                        label: "Start creating quiz",
                        enabled: fileUploaded,
                        loading: _isLoading)),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
