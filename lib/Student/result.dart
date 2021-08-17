import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Widgets/home_page.dart';
import 'package:argeometry/Widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  final String quizId, title, userID, imgUrl, description;
  List<String> questions;
  Results({
    @required this.correct,
    @required this.incorrect,
    @required this.total,
    @required this.quizId,
    @required this.title,
    @required this.userID,
    @required this.imgUrl,
    @required this.description,
  });
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String statId;
  DatabaseService databaseService = new DatabaseService();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('stats').getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    DocumentSnapshot exitingDocument = documents.firstWhere(
        (document) => widget.quizId == document.documentID,
        orElse: () => null);
    var documentExists = exitingDocument != null;
    int _myDocCount = 1;
    if (documentExists) {
      QuerySnapshot _myDoc = await Firestore.instance
          .collection('stats')
          .document(widget.quizId)
          .collection('singleStat')
          .getDocuments();
      _myDocCount = _myDoc.documents.length + 1;
    }
    statId = randomAlphaNumeric(16);
    Map<String, String> statMap = {
      "statId": statId,
      "quizId": widget.quizId,
      "userID": widget.userID,
      "quizTitle": widget.title,
      "imgUrl": widget.imgUrl,
      "quizDesc": widget.description
    };
    await databaseService.addStatData(statMap, widget.quizId);
    Map<String, dynamic> singleStatMap = {
      "colorVal": "0xffaed581",
      "orderVal": _myDocCount,
      "scoreVal": widget.correct,
      "incorrectVal": widget.incorrect,
      "userID": widget.userID
    };
    await databaseService.addSingleStatData(singleStatMap, widget.quizId);
  }

  @override
  Widget build(BuildContext context) {
    // getData();
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
