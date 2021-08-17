import 'package:argeometry/Services/database.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'new_tracker.dart';

class SelectStat extends StatefulWidget {
  @override
  _SelectStatState createState() => _SelectStatState();
}

class _SelectStatState extends State<SelectStat> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  Widget statList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.purple[300]),
              )),
            );
          } else if (snapshot.data.documents.isEmpty) {
            return NoStat(
                "Oops. Sorry, but there are no attempted quizzes made by you. Please attempt at least one quiz.");
          } else {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return StatTile(
                    title: snapshot.data.documents[index].data["quizTitle"],
                    statId: snapshot.data.documents[index].data["statId"],
                    quizId: snapshot.data.documents[index].data["quizId"],
                    imgUrl: snapshot.data.documents[index].data["imgUrl"],
                    description:
                        snapshot.data.documents[index].data["quizDesc"],
                  );
                });
          }
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseService.getStatData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: viewDrawer(true),
      appBar: headerNav(text: 'Select quiz'),
      body: statList(),
    );
  }
}

class StatTile extends StatelessWidget {
  final String title, statId, quizId, imgUrl, description;
  StatTile(
      {@required this.title,
      @required this.statId,
      @required this.quizId,
      @required this.imgUrl,
      @required this.description});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewTracker(statId, title, quizId)));
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
