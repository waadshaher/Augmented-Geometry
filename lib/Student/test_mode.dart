import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Student/new_tracker.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'attempt_quiz.dart';

class TestMode extends StatefulWidget {
  @override
  _TestModeState createState() => _TestModeState();
}

class _TestModeState extends State<TestMode> {
  Stream quizStream;
  bool _isClassRoomStudent = false;
  int _userRole;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    _getUserRole();
    super.initState();
  }

  Future<void> _getUserRole() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _userRole = value.data['userRole'];
        switch (_userRole) {
          case 1:
            _isClassRoomStudent = false;
            _userRole = 1;
            _visibility();
            break;
          case 2:
            _isClassRoomStudent = true;
            _userRole = 2;
            _visibility();
            break;

          default:
        }
      });
    });
  }

  _visibility() {
    if (!_isClassRoomStudent || _userRole == 1) {
      databaseService.getQuizDataVisibilityFalse().then((value) {
        setState(() {
          quizStream = value;
        });
      });
    } else if (_isClassRoomStudent || _userRole == 2) {
      databaseService.getQuizDataVisibilityTrue().then((value) {
        setState(() {
          quizStream = value;
        });
      });
    }
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.purple[300]),
              )),
            );
          } else if (snapshot.data.documents.isEmpty) {
            return NoStat(
              "Oops. Sorry, but there are no quizzes created by teacher right now.",
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return QuizTile(
                    imgUrl: snapshot.data.documents[index].data["quizImgUrl"],
                    title: snapshot.data.documents[index].data["quizTitle"],
                    desc: snapshot.data.documents[index].data["quizDesc"],
                    quizId: snapshot.data.documents[index].data["quizId"],
                  );
                });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavDrawer(),
        appBar: headerNav(text: 'Test Mode'),
        body: quizList(),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl, title, desc, quizId;
  QuizTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    QuizAttempt(quizId, title, imgUrl, desc)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8, top: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
