import 'dart:ui' as ui;
import 'dart:ui';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'model/mesures_data.dart';

List<Offset> allFacePoints = [];
double topFace;
double leftFace;

class FaceContourPainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  final facePaint = Paint()
    ..color = kFacePaintColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  final mesuresPaint = Paint()
    ..strokeWidth = 7.0
    ..color = Colors.green;

  BuildContext context;

  FaceContourPainter(this.image, this.faces, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
    //print('faces number = ${faces.length}');
    final Size imageSize = size;

    for (var i = 0; i < faces.length; i++) {
      allFacePoints =
          faces[i].getContour(FaceContourType.allPoints).positionsList;

      paintFaceFeatures(faces[i], canvas, size);

      // plot traits measures
      paintTraitsMesures(canvas, size);

      saveMesures(
          topFace: faces[i].boundingBox.top,
          leftFace: faces[i].boundingBox.left,
          allFacePoints: allFacePoints);

      //     _showPoints(allFacePoints, 'allFacePoints');
      //     _showPoints(facePoints, 'facePoints');

      //      _showPointsBox(faces[i]);
//      _showPoints(leftEyebrowTop, 'leftEyebrowTop');
//      _showPoints(leftEyebrowTop, 'leftEyebrowTop');
//      _showPoints(noseBridge, 'noseBridge');
//     _showPoints(noseBottom, 'noseBottom');
//      _showPoints(upperLipTop, 'upperLipTop');
//      _showPoints(upperLipBottom, 'upperLipBottom');
//      _showPoints(lowerLipTop, 'lowerLipTop');
//      _showPoints(lowerLipBottom, 'lowerLipBottom');

    }
  }

  Offset _scalePoint({
    Offset offset,
    @required Size imageSize,
    @required Size widgetSize,
  }) {
    final double scaleX = widgetSize.width / imageSize.width;
    final double scaleY = widgetSize.height / imageSize.height;
//    if(cameraLensDirection == CameraLensDirection.front){
//      return Offset(widgetSize.width - (offset.dx * scaleX), offset.dy * scaleY);
//    }
    return Offset(offset.dx * scaleX, offset.dy * scaleY);
  }

  List<Offset> _scalePoints({
    List<Offset> offsets,
    @required Size imageSize,
    @required Size widgetSize,
  }) {
    final double scaleX = widgetSize.width / imageSize.width;
    final double scaleY = widgetSize.height / imageSize.height;

//    if(cameraLensDirection == CameraLensDirection.front){
//      return offsets
//          .map((offset) => Offset(widgetSize.width - (offset.dx * scaleX), offset.dy * scaleY))
//          .toList();
//    }
    return offsets
        .map((offset) => Offset(offset.dx * scaleX, offset.dy * scaleY))
        .toList();
  }

  Rect _scaleRect({
    @required Rect rect,
    @required Size imageSize,
    @required Size widgetSize,
  }) {
    final double scaleX = widgetSize.width / imageSize.width;
    final double scaleY = widgetSize.height / imageSize.height;

//    if(cameraLensDirection == CameraLensDirection.front){
//      print("qui");
//      return Rect.fromLTRB(
//        widgetSize.width - rect.left.toDouble() * scaleX,
//        rect.top.toDouble() * scaleY,
//        widgetSize.width - rect.right.toDouble() * scaleX,
//        rect.bottom.toDouble() * scaleY,
//      );
//    }

    return Rect.fromLTRB(
      rect.left.toDouble() * scaleX,
      rect.top.toDouble() * scaleY,
      rect.right.toDouble() * scaleX,
      rect.bottom.toDouble() * scaleY,
    );
  }

  @override
  bool shouldRepaint(FaceContourPainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }

  void saveMesures(
      {double topFace, double leftFace, List<ui.Offset> allFacePoints}) {
    Provider.of<MesuresData>(context, listen: false)
        .updateMesures(topFace, leftFace, allFacePoints);
  }

  void paintTraitsMesures(Canvas canvas, Size size) {
    final Size imageSize = size;

    // largueur visage
    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(offsets: [
          Offset(allFacePoints[6].dx, allFacePoints[39].dy),
          Offset(allFacePoints[28].dx, allFacePoints[38].dy)
        ], imageSize: imageSize, widgetSize: size),
        mesuresPaint);

    // man l7ajb l assfal nnif

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(offsets: [
          allFacePoints[kBrowUp],
          Offset(allFacePoints[kBrowUp].dx, allFacePoints[kBaseNoise].dy)
        ], imageSize: imageSize, widgetSize: size),
        mesuresPaint);

// attassmuh min assfal nnif l chafat l3olya
    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: [allFacePoints[kBaseNoise], allFacePoints[kUpperLipTop]],
            imageSize: imageSize,
            widgetSize: size),
        mesuresPaint);
//attassamuh measure here between eyses

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: [allFacePoints[kLeftEye], allFacePoints[kRightEye]],
            imageSize: imageSize,
            widgetSize: size),
        mesuresPaint);
    // end face adjucemets
  }

  void paintFaceFeatures(Face face, Canvas canvas, Size size) {
    final rect = _scaleRect(
      rect: face.boundingBox,
      imageSize: size,
      widgetSize: size,
    );
    final Size imageSize = size;
    final List<Offset> facePoints =
        face.getContour(FaceContourType.face).positionsList;

    final List<Offset> lowerLipBottom =
        face.getContour(FaceContourType.lowerLipBottom).positionsList;
    final List<Offset> lowerLipTop =
        face.getContour(FaceContourType.lowerLipTop).positionsList;
    final List<Offset> upperLipBottom =
        face.getContour(FaceContourType.upperLipBottom).positionsList;
    final List<Offset> upperLipTop =
        face.getContour(FaceContourType.upperLipTop).positionsList;
    final List<Offset> leftEyebrowBottom =
        face.getContour(FaceContourType.leftEyebrowBottom).positionsList;
    final List<Offset> leftEyebrowTop =
        face.getContour(FaceContourType.leftEyebrowTop).positionsList;
    final List<Offset> rightEyebrowBottom =
        face.getContour(FaceContourType.rightEyebrowBottom).positionsList;
    final List<Offset> rightEyebrowTop =
        face.getContour(FaceContourType.rightEyebrowTop).positionsList;
    final List<Offset> leftEye =
        face.getContour(FaceContourType.leftEye).positionsList;
    final List<Offset> rightEye =
        face.getContour(FaceContourType.rightEye).positionsList;
    final List<Offset> noseBottom =
        face.getContour(FaceContourType.noseBottom).positionsList;
    final List<Offset> noseBridge =
        face.getContour(FaceContourType.noseBridge).positionsList;

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: lowerLipBottom, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: lowerLipTop, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: upperLipBottom, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: upperLipTop, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: leftEyebrowBottom, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: leftEyebrowTop, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: rightEyebrowBottom,
            imageSize: imageSize,
            widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: rightEyebrowTop, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(offsets: leftEye, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(offsets: rightEye, imageSize: imageSize, widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: noseBottom, imageSize: imageSize, widgetSize: size),
        facePaint);

//    canvas.drawPoints(
//        PointMode.polygon,
//        _scalePoints(
//            offsets: noseBridge, imageSize: imageSize, widgetSize: size),
//        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: facePoints, imageSize: imageSize, widgetSize: size),
        facePaint);

    //bach nkmlo ddoura d lwjah
    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: [allFacePoints[0], allFacePoints[35]],
            imageSize: imageSize,
            widgetSize: size),
        facePaint);

    canvas.drawRect(rect, facePaint);
  }
}
