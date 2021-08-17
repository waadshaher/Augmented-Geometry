import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(90.0)),
    borderSide: BorderSide(color: Colors.purple, width: 2.0),
  ),
);

textInputDecoration2(String text) {
  return InputDecoration(
    hintText: text,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.purple[300],
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.purple[300],
        width: 2.0,
      ),
    ),
  );
}

checker(String val) {
  if (val.isEmpty) {
    return "This is a required field";
  }
}
