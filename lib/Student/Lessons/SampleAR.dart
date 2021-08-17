import 'package:argeometry/Student/Lessons/cone_lesson.dart';
import 'package:argeometry/Student/Lessons/sphere_lesson.dart';
import 'package:flutter/material.dart';
import 'cube_lesson.dart';
import 'cylinder_lesson.dart';
import 'my_unity_widget.dart';

class SampleAR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UnityScreen(
        key: GlobalKey(debugLabel: "Unity"),
      ),
    );
  }
}

class UnityScreen extends StatefulWidget {
  UnityScreen({Key key}) : super(key: key);

  @override
  _UnityScreenState createState() => _UnityScreenState();
}

class _UnityScreenState extends State<UnityScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          Future.delayed(Duration(milliseconds: 100));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple[300],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  if (MyUnityWidget().getIndex() == 0) {
                    return CubeLesson();
                  } else if (MyUnityWidget().getIndex() == 2) {
                    return CylinderLesson();
                  } else if (MyUnityWidget().getIndex() == 4) {
                    return ConeLesson();
                  } else {
                    return SphereLesson();
                  }
                }));
              },
            ),
            title: const Text('AR Scene'),
          ),
          body: Card(
            margin: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: MyUnityWidget().unityWidget),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Rotate across X-axis"),
                        Text(
                            'Speed: ${(MyUnityWidget().sliderValueX).round()}'),
                        Slider(
                          activeColor: Colors.purple[300],
                          inactiveColor: Colors.purple[100],
                          onChanged: (value) {
                            setState(() {
                              MyUnityWidget().sliderValueX = value;
                            });
                            MyUnityWidget().setRotationSpeedX(value.toString());
                          },
                          value: MyUnityWidget().sliderValueX,
                          min: 0,
                          max: 20,
                        ),
                        Text("Rotate across Y-axis"),
                        Text(
                            'Speed: ${(MyUnityWidget().sliderValueY).round()}'),
                        Slider(
                          activeColor: Colors.purple[300],
                          inactiveColor: Colors.purple[100],
                          onChanged: (value) {
                            setState(() {
                              MyUnityWidget().sliderValueY = value;
                            });
                            MyUnityWidget().setRotationSpeedY(value.toString());
                          },
                          value: MyUnityWidget().sliderValueY,
                          min: 0,
                          max: 20,
                        ),
                        Text("Rotate across Z-axis"),
                        Text(
                            'Speed: ${(MyUnityWidget().sliderValueZ).round()}'),
                        Slider(
                          activeColor: Colors.purple[300],
                          inactiveColor: Colors.purple[100],
                          onChanged: (value) {
                            setState(() {
                              MyUnityWidget().sliderValueZ = value;
                            });
                            MyUnityWidget().setRotationSpeedZ(value.toString());
                          },
                          value: MyUnityWidget().sliderValueZ,
                          min: 0,
                          max: 20,
                        ),
                        Text("Figure : ${MyUnityWidget().getTitle}"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
