import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Teacher/view_tracker.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectStatTeacher extends StatefulWidget {
  final String userId, fullName;
  DatabaseService databaseService = new DatabaseService();
  Future<List<QuizStudent>> quizList;
  SelectStatTeacher(this.userId, this.fullName) {
    quizList = databaseService.getListOfQuizStudentData(userId);
  }
  @override
  _SelectStatTeacherState createState() => _SelectStatTeacherState();
}

class _SelectStatTeacherState extends State<SelectStatTeacher> {
  Widget newStatList() {
    return Container(
        child: FutureBuilder<List<QuizStudent>>(
      future: widget.quizList,
      builder:
          (BuildContext context, AsyncSnapshot<List<QuizStudent>> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          snapshot.data.forEach((element) {
            children.add(StatTile(
              imgUrl: element.imgUrl,
              title: element.name,
              results: element.results,
            ));
          });
        } else if (snapshot.hasError) {
          children = <Widget>[
            Text("Oops. Sorry, something went wrong. Please try again later.")
          ];
        } else {
          children = const <Widget>[CircularProgressIndicator()];
        }
        return Container(
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: headerNav(text: 'Select Quiz'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Quizzes the student has completed",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          newStatList(),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String title, imgUrl;
  List<DocumentSnapshot> results;
  StatTile(
      {@required this.title, @required this.results, @required this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewTracker(title, results)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8, top: 8),
        height: 150,
        child: Stack(
          children: [
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgUrl,
                    width: MediaQuery.of(context).size.width - 48,
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 6),
                  Text(
                    "this quiz is created by teacher",
                    style: Theme.of(context).textTheme.headline6,
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
