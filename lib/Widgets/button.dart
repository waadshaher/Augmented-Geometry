import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget submitButton(
    {BuildContext context,
    String label,
    buttonWidth,
    bool enabled = true,
    bool loading = false}) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: enabled ? Colors.purple[300] : Colors.grey[400],
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      width:
          buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width,
      child: enabled
          ? Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          : Row(
              children: [
                if (!loading)
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Text(
                      "Fill the form first",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                if (loading)
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Row(
                      children: [
                        Text(
                          "Loading",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CupertinoActivityIndicator(
                          animating: true,
                        ),
                      ],
                    ),
                  ),
              ],
            ));
}
