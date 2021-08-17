import 'package:argeometry/Models/tracker.dart';
import 'package:argeometry/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ViewTracker extends StatefulWidget {
  final String title;
  List<DocumentSnapshot> results;
  ViewTracker(this.title, this.results);
  @override
  _ViewTrackerState createState() => _ViewTrackerState();
}

class _ViewTrackerState extends State<ViewTracker> {
  List<charts.Series<Tracker, String>> _seriesBarData;
  List<Tracker> mydata;
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Tracker, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Tracker tracker, _) => tracker.orderVal.toString(),
        measureFn: (Tracker tracker, _) => tracker.scoreVal,
        colorFn: (Tracker tracker, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(tracker.colorVal))),
        id: 'Tracker',
        data: mydata,
        labelAccessorFn: (Tracker row, _) => "${row.dateVal}",
      ),
    );
    _seriesBarData.add(
      charts.Series(
        domainFn: (Tracker tracker, _) => tracker.orderVal.toString(),
        measureFn: (Tracker tracker, _) => tracker.doCalc(),
        displayName: 'Wrong answers',
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Tracker tracker, _) =>
            charts.ColorUtil.fromDartColor(Colors.red), //this is one series
        id: 'Tracker',
        data: mydata,
        labelAccessorFn: (Tracker row, _) => "${row.dateVal}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(text: "Student Performance"),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Tracker> sales = widget.results
        .map((documentSnapshot) => Tracker.fromMap(documentSnapshot.data))
        .toList();
    return _buildChart(context, sales);
  }

  Widget _buildChart(BuildContext context, List<Tracker> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      "Score",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: charts.BarChart(
                    _seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds: 2),
                  ),
                ),
                Text(
                  "Trial",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
