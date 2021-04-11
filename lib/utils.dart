import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

Future<ui.Image> loadImage(File imageFile) async {
  final data = await imageFile.readAsBytes();
  return decodeImageFromList(data);
}

//
////la foction suivante donne le même result
//Future<ui.Image> load(String asset) async {
//  ByteData data = await rootBundle.load(asset);
//  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
//  ui.FrameInfo fi = await codec.getNextFrame();
//  return fi.image;
//}

void _showAllPoints(List<Offset> faceContour) {
  print('${faceContour}');
}

void _showPoints(List<Offset> faceContour, String name) {
  print('$name length = ${faceContour.length}');
  if (faceContour != null) {
    for (var i = 0; i < faceContour.length; i++) {
      print(' point $i= ${faceContour[i]}');
    }
  }
}

void _showPointsBox(Face face) {
  final pos = face.boundingBox;
  print(
      'Box data top = ${pos.top}, left = ${pos.left}, bottom=${pos.bottom}, right=${pos.right}');

  final double res = pos.top - pos.bottom;
  print('toul lwajh howwa = $res');
}
