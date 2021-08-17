import 'package:argeometry/Student/Exercises/exercise.dart';
import 'package:argeometry/Student/Lessons/SampleAR.dart';
import 'package:argeometry/Student/Lessons/my_unity_widget.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/audio.dart';
import 'package:argeometry/Widgets/cards.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class ConeLesson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavDrawer(),
        appBar: headerNav(text: 'Cone'),
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
                                    'assets/images/cone/blue-cone.jpg'))),
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
                      Center(child: Player('audio/new/cone.mp3')),
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
                                "A cone has a circular base and a vertex that is not in the same plane as the base. The radius of the base is the radius of the cone. The height is the perpendicular distance between the vertex and the base.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "In a right cone, the segment joining the vertex and the center of the base is perpendicular to the base and the slant height is the distance between the vertex and a point on the base edge.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "The surface area of a cone is the sum of the base area, πr², and the lateral area, πrℓ. The lateral surface of a cone consists of all segments that connect the vertex with points on the base edge.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Check the figure below of the cylinder shape demonstrating its two bases, along with the base's radius and cylinder's height.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 350,
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cone/demonstration.png'),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              "Demonstration of lateral area of a right cone",
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center,
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
                            "The surface area S of a right cone is ",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.purple[200],
                        child: Text("S = B + ½Cℓ = πr² + πrℓ,",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "where B is the area of the base, C is the circumference of the base, r is the radius of the base, and l is the slant height.",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18.0)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/cone/cone_surface_area.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Surface area of a right cone",
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
                            "What is the surface area of the right cone? Follow through this example using the learning cards below.",
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
                                    'assets/images/cone/example.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Example of a cone with height 8cm and radius 6cm",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlippingCard(
                          textFront:
                              "Step 1. Read the problem. Draw the figure and label it with the given information.",
                          imagePath: "assets/images/cone/example.png"),
                      FlippingCard(
                          textFront:
                              "Step 2. Identify what you are looking for.",
                          textBack: "The surface area of the right cone"),
                      FlippingCard(
                          textFront:
                              "Step 3. Name. Choose a variable to represent it.",
                          textBack: "Let S = surface area"),
                      FlippingCard(
                          textFront:
                              "Step 4. Translate. Write the appropriate formula.",
                          textBack: "S = πr² + πrℓ"),
                      FlippingCard(
                        textFront:
                            "Step 5. To find the slant height ℓ of the right cone, use the Pythagorean Theorem.",
                        textBack: "ℓ² = h² + r²",
                      ),
                      FlippingCard(
                        textFront: "Step 6. Substitute.",
                        textBack: "ℓ² = 8² + 6²",
                      ),
                      FlippingCard(
                        textFront: "Step 7. Find positive square root.",
                        textBack: "ℓ = 10",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 8. Use the formula for the surface area of a right cone",
                        textBack: "S = πr² + πrℓ",
                      ),
                      FlippingCard(
                        textFront: "Step 9. Substitute. (Use 3.14 for π)",
                        textBack: "S = (3.14)6² + (3.14)(6)(10)",
                      ),
                      FlippingCard(
                        textFront: "Step 10. Solve using your calculator",
                        textBack: "96π",
                      ),
                      FlippingCard(
                        textFront: "Step 11. Answer the question",
                        textBack:
                            "The surface area of the right cone is 96π m².",
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
                                MyUnityWidget().init(4);
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
                                          "PLSYzd49j9HAPokMJiYX",
                                          "Cone Exercise")),
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
