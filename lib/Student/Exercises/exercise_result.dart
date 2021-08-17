import 'package:argeometry/Widgets/button.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:flutter/material.dart';

class ExerciseResults extends StatefulWidget {
  final int correct, incorrect, total;
  final String quizId, title;
  List<String> questions;
  ExerciseResults({
    @required this.correct,
    @required this.incorrect,
    @required this.total,
    @required this.quizId,
    @required this.title,
  });
  @override
  _ExerciseResultsState createState() => _ExerciseResultsState();
}

class _ExerciseResultsState extends State<ExerciseResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Go back to main menu',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
        title: Text("Results"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
                style: TextStyle(fontSize: 15, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 150,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: submitButton(
                      context: context,
                      buttonWidth: 300.0,
                      label: "Take the exercise again"),
                ),
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
