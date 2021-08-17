import 'package:argeometry/Models/question.dart';
import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Student/result.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Exercises/exercise_play_widgets.dart';

class QuizAttempt extends StatefulWidget {
  final String quizId;
  final String title;
  final String imgUrl;
  final String desc;
  QuizAttempt(this.quizId, this.title, this.imgUrl, this.desc);

  @override
  _QuizAttemptState createState() => _QuizAttemptState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

Stream infoStream;

class _QuizAttemptState extends State<QuizAttempt> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();
  var _userID = "";
  bool isLoading = true;

  @override
  void initState() {
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot.documents.length;
      setState(() {});
    });

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        return [_correct, _incorrect];
      });
    }

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());
    print(_notAttempted);

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  _getUserID() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _userID = value.data['userID'].toString();
        goToNextPage(_userID);
      });
    });
  }

  goToNextPage(String userID) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Results(
                correct: _correct,
                incorrect: _incorrect,
                total: total,
                quizId: widget.quizId,
                title: widget.title,
                userID: _userID,
                imgUrl: widget.imgUrl,
                description: widget.desc,
              )),
    ).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(text: "${widget.title}"),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    InfoHeader(
                      length: questionSnaphot.documents.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    questionSnaphot.documents == null
                        ? Container(
                            child: Center(
                              child: Text("No Data"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: questionSnaphot.documents.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return QuizPlayTile(
                                questionModel: getQuestionModelFromDatasnapshot(
                                    questionSnaphot.documents[index]),
                                index: index,
                              );
                            }),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[300],
        child: Icon(Icons.check),
        onPressed: () {
          if (_notAttempted != 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 3),
                content: Text("Please answer all questions")));
          } else {
            _getUserID();
          }
        },
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 14),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      NoOfQuestionTile(
                        text: "Total",
                        number: widget.length,
                      ),
                      NoOfQuestionTile(
                        text: "Correct",
                        number: _correct,
                      ),
                      NoOfQuestionTile(
                        text: "Incorrect",
                        number: _incorrect,
                      ),
                      NoOfQuestionTile(
                        text: "Not Attempted",
                        number: _notAttempted,
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  bool optionWasSelected = false;
  bool wrongSelected = false;
  bool correctSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Q${widget.index + 1}) ${widget.questionModel.question}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option1 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                      _correct = _correct + 1;
                      if (wrongSelected == false) {
                        _notAttempted = _notAttempted - 1;
                      } else if (wrongSelected == true) {
                        _incorrect = _incorrect - 1;
                      }
                      if (_incorrect == 0) {}
                      if (_notAttempted == 0) {}
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                      if (_notAttempted == 0) {}
                      if (wrongSelected) {
                      } else {
                        _notAttempted = _notAttempted - 1;
                        _incorrect = _incorrect + 1;
                        wrongSelected = true;
                      }
                    });
                  }
                }
              },
              child: OptionTile(
                option: "A",
                description: "${widget.questionModel.option1}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option2 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option2;
                      widget.questionModel.answered = true;
                      _correct = _correct + 1;
                      if (wrongSelected == false) {
                        _notAttempted = _notAttempted - 1;
                      } else if (wrongSelected == true) {
                        _incorrect = _incorrect - 1;
                      }
                      if (_incorrect == 0) {}
                      if (_notAttempted == 0) {}
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option2;
                      widget.questionModel.answered = true;
                      if (_notAttempted == 0) {}
                      if (wrongSelected) {
                      } else {
                        _incorrect = _incorrect + 1;
                        wrongSelected = true;
                        _notAttempted = _notAttempted - 1;
                      }
                    });
                  }
                }
              },
              child: OptionTile(
                option: "B",
                description: "${widget.questionModel.option2}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option3 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option3;
                      widget.questionModel.answered = true;
                      _correct = _correct + 1;
                      if (wrongSelected == false) {
                        _notAttempted = _notAttempted - 1;
                      } else if (wrongSelected == true) {
                        _incorrect = _incorrect - 1;
                      }
                      if (_incorrect == 0) {}
                      if (_notAttempted == 0) {}
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option3;
                      widget.questionModel.answered = true;
                      if (_notAttempted == 0) {}
                      if (wrongSelected) {
                      } else {
                        _incorrect = _incorrect + 1;
                        wrongSelected = true;
                        _notAttempted = _notAttempted - 1;
                      }
                    });
                  }
                }
              },
              child: OptionTile(
                option: "C",
                description: "${widget.questionModel.option3}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  if (widget.questionModel.option4 ==
                      widget.questionModel.correctOption) {
                    setState(() {
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                      _correct = _correct + 1;
                      if (wrongSelected == false) {
                        _notAttempted = _notAttempted - 1;
                      } else if (wrongSelected == true) {
                        _incorrect = _incorrect - 1;
                      }
                      if (_incorrect == 0) {}
                      if (_notAttempted == 0) {}
                    });
                  } else {
                    setState(() {
                      optionSelected = widget.questionModel.option4;
                      widget.questionModel.answered = true;
                      if (_notAttempted == 0) {}
                      if (wrongSelected) {
                      } else {
                        _incorrect = _incorrect + 1;
                        wrongSelected = true;
                        _notAttempted = _notAttempted - 1;
                      }
                    });
                  }
                }
              },
              child: OptionTile(
                option: "D",
                description: "${widget.questionModel.option4}",
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
