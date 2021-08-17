import 'package:argeometry/Services/auth.dart';
import 'package:argeometry/Student/read_lesson.dart';
import 'package:argeometry/Student/test_mode.dart';
import 'package:argeometry/Teacher/create_quiz.dart';
import 'package:argeometry/Student/select_stat.dart';
import 'package:argeometry/Teacher/select_student.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Student/read_lesson.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _userName = "";
  var _userRole;
  bool _isLoading = false;
  bool _isStudent = false;
  AuthService authService = new AuthService();
  _getUserName() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data['fullName'].toString();
      });
    });
  }

  Future<void> _getUserRole() async {
    Firestore.instance
        .collection('users')
        .document((await FirebaseAuth.instance.currentUser()).uid)
        .get()
        .then((value) {
      setState(() {
        _isLoading = true;
        _userRole = value.data['userRole'];
        switch (_userRole) {
          case 1:
            _isStudent = true;
            break;
          case 2:
            _isStudent = true;
            break;
          case 3:
            _isStudent = false;
            break;
          default:
        }
      });
    });
  }

  void initState() {
    _getUserName();
    _getUserRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: _isStudent ? viewDrawer(_isStudent) : viewDrawer(!_isStudent),
        appBar: headerNav(text: 'Welcome $_userName'),
        body: _isLoading
            ? viewHome(_isStudent)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.purple[300]),
                    ),
                    Text("Fetching user data...",
                        style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}

class BodyLayoutStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

class BodyLayoutTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myTeacherListView(context);
  }
}

Widget _myListView(BuildContext context) {
  final titles = [
    'Read Geometry Lessons',
    'Switch to Test Mode',
    'View My Progress'
  ];
  final icons = [
    Icons.book_rounded,
    Icons.assignment,
    Icons.assessment_rounded
  ];
  final subtitles = [
    'Enjoy reading about a veriety of selection of shapes and experince them with augmented reality!',
    'Test your knowledge in solving a set of quizzes',
    'Track your progress in learning geometry'
  ];

  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemExtent: 150,
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 5,
        shadowColor: Colors.purple[200],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
          child: ListTile(
            leading: Icon(icons[index]),
            title: Text(
              titles[index],
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                subtitles[index],
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadLesson()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestMode()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectStat()),
                  );
                  break;
                default:
              }
            },
          ),
        ),
      );
    },
  );
}

Widget _myTeacherListView(BuildContext context) {
  final titles = ['Create New Quiz', 'View Student Progress'];
  final icons = [Icons.assignment, Icons.assessment_rounded];
  final subtitles = [
    'Test your student\'s knowledge by creating a set of quizzes',
    'Track your student\'s progress in learning geometry'
  ];

  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemExtent: 150,
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 5,
        shadowColor: Colors.purple[200],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
          child: ListTile(
            leading: Icon(icons[index]),
            title: Text(
              titles[index],
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                subtitles[index],
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateQuiz()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectStudent()),
                  );
                  break;
                default:
              }
            },
          ),
        ),
      );
    },
  );
}
