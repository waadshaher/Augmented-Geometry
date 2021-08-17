import 'package:argeometry/Student/Lessons/cube_lesson.dart';
import 'package:argeometry/Widgets/appbar.dart';
import 'package:argeometry/Widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'Lessons/cone_lesson.dart';
import 'Lessons/cylinder_lesson.dart';
import 'Lessons/sphere_lesson.dart';

class ReadLesson extends StatelessWidget {
  final images = [
    'assets/images/cube/Cube copy.jfif',
    'assets/images/cylinder/Cylinder.jfif',
    'assets/images/cone/Cone.jfif',
    'assets/images/sphere/Sphere.jfif'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavDrawer(),
        appBar: headerNav(text: 'Read Lessons'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Select from a variety of shapes you can learn about",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    return Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        padding: new EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CubeLesson()),
                                );
                                break;
                              case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CylinderLesson()),
                                );
                                break;
                              case 2:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConeLesson()),
                                );
                                break;
                              case 3:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SphereLesson()),
                                );
                                break;
                              default:
                            }
                          },
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.purple[200],
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
