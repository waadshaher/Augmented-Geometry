import 'package:argeometry/Services/auth.dart';
import 'package:argeometry/Student/select_stat.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:argeometry/Student/read_lesson.dart';
import 'package:argeometry/Student/test_mode.dart';
import 'package:argeometry/Widgets/signin.dart';
import 'package:argeometry/Teacher/create_quiz.dart';
import 'package:argeometry/Teacher/select_student.dart';
import 'package:argeometry/Widgets/user_profile.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Augmented Geometry',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.purple[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.book_rounded),
            title: Text('Read Geometry Lessons'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadLesson()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Switch to Test Mode'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestMode()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.assessment_rounded),
            title: Text('View My Progress'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectStat()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          )
        ],
      ),
    );
  }
}

class NavDrawerTeacher extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Augmented Geometry',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.purple[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Create New Quiz'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateQuiz()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.assessment_rounded),
            title: Text('View Student Progress'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectStudent()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          )
        ],
      ),
    );
  }
}
