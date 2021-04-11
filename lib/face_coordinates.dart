import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

//    return Container(
//      child: Column(
//        children: <Widget>[
//          Flexible(
//            flex: 1,
//            child: Container(
//              constraints: BoxConstraints.expand(),
//              child: Image.file(
//                imageFile,
//                fit: BoxFit.cover,
//              ),
//            ),
//          ),
//          Flexible(
//            flex: 1,
//            child: ListView(
//              children: faces.map<Widget>((f) => FaceCoordinates(f)).toList(),
//            ),
//          ),
//        ],
//      ),
//    );

class FaceCoordinates extends StatelessWidget {
  final Face face;
  FaceCoordinates(this.face);

  @override
  Widget build(BuildContext context) {
    final pos = face.boundingBox;
    return ListTile(
      title: Text(
          'topf = ${pos.top}, left = ${pos.left}, bottom=${pos.bottom}, right=${pos.right}'),
    );
  }
}
