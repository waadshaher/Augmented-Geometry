import 'package:argeometry/Student/Exercises/exercise.dart';
import 'package:argeometry/Student/Lessons/SampleAR.dart';
import 'package:argeometry/Student/Lessons/my_unity_widget.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/audio.dart';
import 'package:argeometry/Widgets/cards.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class CubeLesson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavDrawer(),
        appBar: headerNav(text: 'Cube'),
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
                          image: AssetImage('assets/images/cube/blue-cube.jpg'),
                        )),
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
                      Center(child: Player('audio/new/cube.mp3')),
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
                                "A cube is a 3-D solid shape, which has 6 faces. A cube is one of the simplest shapes in three-dimensional space. All the six faces of a cube are squares, a two-dimensional shape.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "The definition of surface area of a given cube states that if the total surface area is equal to the sum of all the areas of the faces of the cube. Since the cube has six faces, therefore, the total surface area of the cube will be equal to sum of all six faces of cube since, the surface of the cube is in square shape. Hence, area of each face of the cube is equal to square of edge. The lateral surface area of cube is the total surface area of the cube, which is equal to sum of areas of all its sides.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Check the figure below of the cube shape demonstrating its six faces, along with the cube's length, breadth, and height.",
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
                                          'assets/images/cube/diagram2.jpg'),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              "Diagram of cube",
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                "In the above figure, you can see, edge, face and vertex of the cube. Here, L stands for length, B stands for breadth and H stands for height. We can see the length, breadth and height of the cube, which represents the edges of the cube, connected at a single point which is the vertex. The faces of the cube are connected by four vertices.",
                                style: new TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 411,
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/cube/cube-net.png'),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              "Cube net",
                              style: Theme.of(context).textTheme.caption,
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
                            "The surface area S of a cube is ",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.purple[200],
                        child: Text("S = 6s²",
                            style: new TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18.0)),
                      ),
                      SizedBox(
                        height: 30, //20
                      ),
                      Container(
                        width: 411,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/cube/download.jpg'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Surface area and lateral area of a cube",
                        style: Theme.of(context).textTheme.caption,
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
                            "A cube is 2.5 inches on each side. Find its surface area. Follow through this example using the learning cards below.",
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
                                    'assets/images/cube/example.png'),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Example of a cube with each side equals to 2.5 inches",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlippingCard(
                        textFront:
                            "Step 1. Read the problem. Draw the figure and label it with the given information.",
                        imagePath: 'assets/images/cube/example.png',
                      ),
                      FlippingCard(
                        textFront: "Step 2. Identify what you are looking for.",
                        textBack: "The surface area of the cube",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 3. Name. Choose a variable to represent it.",
                        textBack: "Let S = surface area",
                      ),
                      FlippingCard(
                        textFront:
                            "Step 4. Translate. Write the appropriate formula.",
                        textBack: "S = 6s²",
                      ),
                      FlippingCard(
                        textFront: "Step 5. Substitute.",
                        textBack: "S = 6(2.5)²",
                      ),
                      FlippingCard(
                          textFront: "Step 6. Solve using your calculator.",
                          textBack: "S = 37.5"),
                      FlippingCard(
                        textFront: "Step 7. Answer the question.",
                        textBack:
                            "The surface area of the cube is 37.5 square inches.",
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
                                MyUnityWidget().init(0);
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
                                          "Epw6A4lPYgcSsor0GcMd",
                                          "Cube Exercise")),
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
