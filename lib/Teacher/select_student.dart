import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Teacher/select_stat_by_teacher.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/drawer.dart';
import 'package:argeometry/Widgets/no_stat.dart';
import 'package:flutter/material.dart';

class SelectStudent extends StatefulWidget {
  @override
  _SelectStudentState createState() => _SelectStudentState();
}

class _SelectStudentState extends State<SelectStudent> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  @override
  void initState() {
    // TODO: implement initState
    databaseService.getStudentsData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  Widget studentList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          checkStudents() {
            if (snapshot.data.documents.isEmpty) {
              return NoStat(
                "Oops. Sorry, but there are no attempted quizzes made by you. Please attempt at least one quiz.",
              );
            }
          }

          if (snapshot.data == null) {
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple[300]),
            );
          } else if (snapshot.data.documents.isEmpty) {
            NoStat(
              "Oops. Sorry, but there are no students associated to you.",
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return StudentTile(
                    fullName: snapshot.data.documents[index].data["fullName"],
                    email: snapshot.data.documents[index].data["email"],
                    userRole: snapshot.data.documents[index].data["userRole"],
                    uid: snapshot.data.documents[index].data["userID"],
                    pfp: snapshot.data.documents[index].data["profilePic"],
                  );
                });
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: headerNav(text: 'Select Student'),
      drawer: viewDrawer(false),
      body: studentList(),
    );
  }
}

class StudentTile extends StatelessWidget {
  final String fullName, email, uid, pfp;
  final int userRole;
  StudentTile(
      {@required this.fullName,
      @required this.email,
      @required this.userRole,
      @required this.pfp,
      @required this.uid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SelectStatTeacher(uid, fullName)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8, top: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  pfp,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(fullName, style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 6),
                  Text(
                    "Student within a classroom setting",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 6),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
