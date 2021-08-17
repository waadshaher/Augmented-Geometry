import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class MyUnityWidget {
  static final MyUnityWidget _widget = MyUnityWidget._internal();
  factory MyUnityWidget() => _widget;
  MyUnityWidget._internal();

  UnityWidgetController unityWidgetController;
  Widget unityWidget;
  int index;
  double sliderValueX = 0.0, sliderValueY = 0.0, sliderValueZ = 0.0;

  var figures = [
    "Cube",
    "Cube-exercises",
    "Cylinder",
    "Cylinder-exercises",
    "Cone",
    "Cone-exercises",
    "Sphere",
    "Sphere-exercises",
  ];
  String asset = "AR Session Origin";
  String get getTitle => index != null ? figures[index] : '';

  void init(int index) {
    this.index = index;
    if (unityWidget == null && unityWidgetController == null) {
      unityWidget = UnityWidget(
        onUnityCreated: onUnityCreated,
        onUnityMessage: onUnityMessage,
      );
    }
  }

  void refresh() {
    unityWidgetController.postMessage(asset, "refreshObject", "");
  }

  void adjustCameraFocus() {
    unityWidgetController.postMessage(
      asset,
      'SetIndex',
      index.toString(),
    );
  }

  // Communcation from Flutter to Unity
  void setRotationSpeedX(String speed) {
    unityWidgetController.postMessage(
      asset,
      'SetRotationSpeedX',
      speed,
    );
  }

  // Communcation from Flutter to Unity
  void setRotationSpeedY(String speed) {
    unityWidgetController.postMessage(
      asset,
      'SetRotationSpeedY',
      speed,
    );
  }

  // Communcation from Flutter to Unity
  void setRotationSpeedZ(String speed) {
    unityWidgetController.postMessage(
      asset,
      'SetRotationSpeedZ',
      speed,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    var ret = json.decode(message.toString());
    print('Received from Unity: $ret');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    unityWidgetController = controller;
    adjustCameraFocus();
    refresh();
  }

  int getIndex() => index;
}
