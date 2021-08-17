import 'package:argeometry/Student/Lessons/SampleAR.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/audio.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:argeometry/Student/Exercises/exercise.dart';
import 'package:argeometry/Widgets/cards.dart';
import 'my_unity_widget.dart';

class CylinderLesson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavDrawer(),
        appBar: headerNav(text: 'Cylinder'),
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
                                    'assets/images/cylinder/blue-cylinder.jpg'))),
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
                      Center(child: Player('audio/new/cylinder.mp3')),
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
                                "A cylinder is a solid with congruent circular bases that lie in parallel planes. The height of a cylinder is the perpendicular distance between its bases. The radius of a base is the radius of the cylinder. In a right cylinder, the segment joining the centers of the bases is perpendicular to the bases.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Check the figure below of the cylinder shape demonstrating its two bases, along with the base's radius and cylinder height.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 411,
                              height: 260,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cylinder/CylinderFig1.png'),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              "Diagram of cylinder demonstrating its two bases, radius, and height",
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "The lateral area of a cylinder is the area of its curved surface. It is equal to the product of the circumference and the height, or 2πrh. The surface area of a cylinder is equal to the sum of the lateral area and the areas of the two bases.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 411,
                              height: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cylinder/CylinderFig2.png'),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              "Demonstration of surface area and lateral area of cylinder",
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                            "The surface area S of a right cylinder is ",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.purple[200],
                        child: Text("S = 2B + Ch = 2πr² + 2πrh,",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "where B is the area of a base, C is the circumference of a base, r is the radius of a base, and h is the height. ",
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
                                    'assets/images/cylinder/CylinderFig3.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Surface area of a right cylinder",
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
                            "A cylinder has height 10 centimeters and radius 6 centimeters. Find the surface area. Follow through this example using the learning cards below.",
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
                                    'assets/images/cylinder/CylinderFig4.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Example of a right cylinder with height 10cm and radius 6cm",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlippingCard(
                        textFront:
                            "Step 1. Read the problem. Draw the figure and label it with the given information.",
                        imagePath: "assets/images/cylinder/CylinderFig4.png",
                      ),
                      FlippingCard(
                        textFront: "Step 2. Identify what you are looking for.",
                        textBack: "The surface area of the cylinder",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 3. Name. Choose a variable to represent it.",
                        textBack: "Let S = surface area",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 4. Translate. Write the appropriate formula.",
                        textBack: "S = 2πr² + 2πrh",
                      ),
                      FlippingCard(
                        textFront: "Step 5. Substitute. (Use 3.14 for π)",
                        textBack: "S = 2(3.14)6² + 2(3.14)(6)10",
                      ),
                      FlippingCard(
                          textFront: "Step 6. Solve using your calculator.",
                          textBack: "S ≈ 602.88"),
                      FlippingCard(
                        textFront: "Step 7. Answer the question.",
                        textBack:
                            "The surface area of the cylinder is approximately 602.88 square inches.",
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
                                MyUnityWidget().init(2);
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
                                          "09915uM08835d078",
                                          "Cylinder Exercise")),
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
