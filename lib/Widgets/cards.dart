import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlippingCard extends StatelessWidget {
  String textFront, textBack, imagePath;
  FlippingCard({this.textFront, this.textBack, this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        front: Container(
          width: 411,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.purple[200],
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(textFront,
                    style: Theme.of(context).textTheme.headline),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Click to view the answer',
                  style: Theme.of(context).textTheme.body2),
            ],
          ),
        ),
        back: imagePath == null
            ? Container(
                width: 411,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(textBack,
                          style: Theme.of(context).textTheme.headline),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Click to go back to the step',
                        style: Theme.of(context).textTheme.body2),
                  ],
                ),
              )
            : Container(
                width: 411,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Container(
                  width: 411,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.contain)),
                ),
              ),
      ),
    );
  }
}
