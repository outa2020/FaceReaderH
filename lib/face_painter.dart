import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  FacePainter(this.image, this.faces);

  //image test A charger ensuite placer un dessin !!!

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
    print('faces number = ${faces.length}');
    for (Face face in faces) {
      final pos = face.boundingBox;
      print(
          'top = ${pos.top}, left = ${pos.left}, bottom=${pos.bottom}, right=${pos.right}');
      final facePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5;

//      final eyeOP = face.smilingProbability;
//      print('SmileProba = $eyeOP');
//      final FaceLandmark noseBase = face.getLandmark(FaceLandmarkType.noseBase);
//      print(
//          'nose base dx, dy = ${noseBase.position.dx} ---${noseBase.position.dy}');
////test cercle landmark OK
//      canvas.drawOval(
//          Rect.fromPoints(
//              Offset(noseBase.position.dx - 20, noseBase.position.dy - 20),
//              Offset(noseBase.position.dx + 20, noseBase.position.dy + 10)),
//          facePaint);

      //test contour

      canvas.drawRect(
          Rect.fromPoints(
              Offset(pos.left, pos.top), Offset(pos.right, pos.bottom)),
          facePaint);

      //canvas.drawImage(image, Offset(100, 100), Paint());
      TextSpan span = TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 48),
          text: 'Face fnan!');
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(pos.left, pos.top));

      //landmarks

    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
