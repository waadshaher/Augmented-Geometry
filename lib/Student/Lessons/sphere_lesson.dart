import 'package:argeometry/Student/Exercises/exercise.dart';
import 'package:argeometry/Student/Lessons/SampleAR.dart';
import 'package:argeometry/Student/Lessons/my_unity_widget.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/audio.dart';
import 'package:argeometry/Widgets/cards.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class SphereLesson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavDrawer(),
        appBar: headerNav(text: 'Sphere'),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _content(context);
  }
}

Widget _content(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          Container(
              width: 355,
              height: 260,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Center(
                      child: Container(
                        width: 350,
                        height: 260,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/sphere/blue-sphere.jpg'))),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Lesson Audio",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                      Center(child: Player('audio/new/sphere.mp3')),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "About",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(
                                "A sphere is the set of all points in space equidistant from a given point. This point is called the center of the sphere. A radius of a sphere is a segment from the center to a point on the sphere. A chord of a sphere is a segment whose endpoints are on the sphere. A diameter of a sphere is a chord that contains the center.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Check the figure below of the sphere shape demonstrating its center, radius, along with the sphere's chord and diameter.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 411,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/sphere/demonstration.png'))),
                            ),
                            Center(
                              child: Text(
                                "Diagram representing a sphere's center, radius, chord and diameter",
                                style: Theme.of(context).textTheme.caption,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "As with circles, the terms radius and diameter also represent distances, and the diameter is twice the radius.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Equations",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "The surface area S of a sphere is",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.purple[200],
                        child: Text("S = 4πr²,",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("where r is the radius of the sphere.",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18.0)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 411,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/sphere/surface_area.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Surface area of a sphere",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Solved Example",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Find the surface area of the sphere. Follow through this example using the learning cards below.",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 411,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/sphere/example.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Example of a sphere with radius 8in",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlippingCard(
                          textFront:
                              "Step 1. Read the problem. Draw the figure and label it with the given information.",
                          imagePath: 'assets/images/sphere/example.png'),
                      FlippingCard(
                        textFront: "Step 2. Identify what you are looking for.",
                        textBack: "The surface area of the sphere",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 3. Name. Choose a variable to represent it.",
                        textBack: "Let S = surface area",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 4. Translate. Write the appropriate formula.",
                        textBack: "S = 4πr²",
                      ),
                      FlippingCard(
                        textFront: "Step 5. Substitute. (Use 3.14 for π)",
                        textBack: "S = 4π(8²)",
                      ),
                      FlippingCard(
                        textFront: "Step 6. Solve using your calculator",
                        textBack: "S ≈ 804.25",
                      ),
                      FlippingCard(
                        textFront: "Step 7. Answer the question.",
                        textBack:
                            "The surface area of the sphere is approximately 804.25 square inches.",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.purple[300])),
                              child: Text('Switch to AR'),
                              onPressed: () {
                                MyUnityWidget().init(6);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SampleAR()),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.purple[300])),
                              child: Text('Solve exercises'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExerciseAttempt(
                                          "A9hCzoJYHanGRE6Jpn1X",
                                          "Sphere Exercise")),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
