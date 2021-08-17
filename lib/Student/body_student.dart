import 'package:argeometry/Student/read_lesson.dart';
import 'package:argeometry/Student/select_stat.dart';
import 'package:argeometry/Student/test_mode.dart';
import 'package:flutter/material.dart';
import 'read_lesson.dart';

class BodyLayoutStudentNew extends StatelessWidget {
  final titles = ['Read Lessons', 'Test Mode', 'Tracker'];
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemExtent: 150,
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shadowColor: Colors.purple[200],
          child: ListTile(
            leading: Icon(icons[index]),
            title: Text(
              titles[index],
              style:
                  new TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
            ),
            subtitle: Text(
              subtitles[index],
              style:
                  new TextStyle(fontWeight: FontWeight.normal, fontSize: 18.0),
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
        );
      },
    );
  }
}
