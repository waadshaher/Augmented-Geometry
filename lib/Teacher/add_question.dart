import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/button.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:argeometry/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AddQuestion extends StatefulWidget {
  String quizId;
  int _number;
  Map<String, String> quizMap;
  String quizTitle, quizDesc, uploadedFileURL;
  AddQuestion(
      this._number, this.quizTitle, this.quizDesc, this.uploadedFileURL);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      widget._number++;
    });
    if (widget._number <= 5) {
      return Scaffold(
        appBar: headerNav(text: "Adding question ${widget._number}"),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : AddQuestionForm(widget._number, widget.quizTitle, widget.quizDesc,
                widget.uploadedFileURL),
      );
    }
    return null;
  }
}

class AddQuestionForm extends StatefulWidget {
  int number;
  Map<String, dynamic> quizMap;
  String quizTitle, quizDesc, uploadedFileURL;
  AddQuestionForm(
      this.number, this.quizTitle, this.quizDesc, this.uploadedFileURL);
  @override
  _AddQuestionFormState createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDesc, quizId;
  String question, option1, option2, option3, option4;
  static Map<String, dynamic> questionMap1,
      questionMap2,
      questionMap3,
      questionMap4,
      questionMap5;

  static var list1 = [];
  static var list2 = [];
  static var list3 = [];
  static var list4 = [];
  static var list5 = [];
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();
  printValue(int index) {
    switch (widget.number) {
      case 1:
        return list1[index];
        break;
      case 2:
        return list2[index];
        break;
      case 3:
        return list3[index];
        break;
      case 4:
        return list4[index];
        break;
      case 5:
        return list5[index];
        break;
      default:
    }
  }

  bool checkSavedAnswers() {
    switch (widget.number) {
      case 1:
        if (list1.isEmpty) {
          return true;
        } else {
          return false;
        }
        break;
      case 2:
        if (list2.isEmpty) {
          return true;
        } else {
          return false;
        }
        break;
      case 3:
        if (list3.isEmpty) {
          return true;
        } else {
          return false;
        }
        break;
      case 4:
        if (list4.isEmpty) {
          return true;
        } else {
          return false;
        }
        break;
      case 5:
        if (list5.isEmpty) {
          return true;
        } else {
          return false;
        }
        break;
      default:
    }
  }

  createQuiz(String quizTitle, String quizDesc, String theUrl) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      widget.quizMap = {
        "quizId": quizId,
        "quizImgUrl": theUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc,
        "visibility": true
      };
      await databaseService
          .addQuizData(widget.quizMap, quizId)
          .then((value) async {
        await uploadQuizData();
        showAlertDialog(context);
      });
    } else {}
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Return to home screen  ",
        style: TextStyle(
          color: Colors.purple[300],
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Quiz uploaded"),
      content: Text(
          "Quiz is successfully created and uploaded. Prompt students to answer the quiz."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  saveQuizData() {
    if (_formKey.currentState.validate()) {
      switch (widget.number) {
        case 1:
          setState(() {
            questionMap1 = {
              "question": question,
              "option1": option1,
              "option2": option2,
              "option3": option3,
              "option4": option4
            };
          });
          list1 = questionMap1.values.toList();
          break;

        case 2:
          setState(() {
            questionMap2 = {
              "question": question,
              "option1": option1,
              "option2": option2,
              "option3": option3,
              "option4": option4
            };
          });
          list2 = questionMap2.values.toList();
          break;

        case 3:
          setState(() {
            questionMap3 = {
              "question": question,
              "option1": option1,
              "option2": option2,
              "option3": option3,
              "option4": option4
            };
          });
          list3 = questionMap3.values.toList();
          break;

        case 4:
          setState(() {
            questionMap4 = {
              "question": question,
              "option1": option1,
              "option2": option2,
              "option3": option3,
              "option4": option4
            };
          });
          list4 = questionMap4.values.toList();
          break;

        case 5:
          setState(() {
            questionMap5 = {
              "question": question,
              "option1": option1,
              "option2": option2,
              "option3": option3,
              "option4": option4
            };
          });
          list5 = questionMap5.values.toList();
          break;
        default:
      }
    }
  }

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (widget.number == 5) {
        databaseService.addQuestionData(questionMap1, quizId);
        databaseService.addQuestionData(questionMap2, quizId);
        databaseService.addQuestionData(questionMap3, quizId);
        databaseService.addQuestionData(questionMap4, quizId);
        databaseService.addQuestionData(questionMap5, quizId).then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                initialValue: checkSavedAnswers() ? "" : printValue(0),
                validator: (val) => checker(val),
                cursorColor: Colors.purple[300],
                decoration: textInputDecoration2("Question"),
                onChanged: (val) => question = val,
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                initialValue: checkSavedAnswers() ? "" : printValue(1),
                validator: (val) => checker(val),
                cursorColor: Colors.purple[300],
                decoration: textInputDecoration2("Option 1 (Correct Answer)"),
                onChanged: (val) => option1 = val,
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                initialValue: checkSavedAnswers() ? "" : printValue(2),
                validator: (val) => checker(val),
                cursorColor: Colors.purple[300],
                decoration: textInputDecoration2("Option 2"),
                onChanged: (val) => option2 = val,
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                initialValue: checkSavedAnswers() ? "" : printValue(3),
                validator: (val) => checker(val),
                cursorColor: Colors.purple[300],
                decoration: textInputDecoration2("Option 3"),
                onChanged: (val) => option3 = val,
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                initialValue: checkSavedAnswers() ? "" : printValue(4),
                validator: (val) => checker(val),
                cursorColor: Colors.purple[300],
                decoration: textInputDecoration2("Option 4"),
                onChanged: (val) => option4 = val,
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  widget.number == 5
                      ? Padding(
                          padding: const EdgeInsets.only(left: 28),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  setState(() {
                                    Navigator.pop(context, --widget.number);
                                  });
                                },
                                child: submitButton(
                                    context: context,
                                    label: "Back",
                                    buttonWidth: 100.0),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  saveQuizData();
                                  createQuiz(widget.quizTitle, widget.quizDesc,
                                      widget.uploadedFileURL);
                                },
                                child: submitButton(
                                    context: context,
                                    label: "Upload Quiz",
                                    buttonWidth:
                                        MediaQuery.of(context).size.width / 2 -
                                            36),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 28),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  setState(() {
                                    Navigator.pop(context, --widget.number);
                                  });
                                },
                                child: submitButton(
                                    context: context,
                                    label: "Back",
                                    buttonWidth: 100.0),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  setState(() {
                                    saveQuizData();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddQuestion(
                                                widget.number,
                                                widget.quizTitle,
                                                widget.quizDesc,
                                                widget.uploadedFileURL)));
                                  });
                                },
                                child: submitButton(
                                    context: context,
                                    label: "Next Question",
                                    buttonWidth:
                                        MediaQuery.of(context).size.width / 2 -
                                            36),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    width: 24,
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StopAdding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
