import 'package:flutter/cupertino.dart';

import '../constants.dart';

class MesuresData extends ChangeNotifier {
  double topRectangle;
  double leftRectangle;
  double buttomRectangle;
  double rightRectangle;

  List<Offset> allFacePoints = [];

  double _foreheadLength;
  double _sentimentLength;
  double _sportLength;
  double _competenceLength;

  double _forgivenessLength;
  double _selfRelianceLength;
  double _upperLipLength;
  double _lowerLipLength;

  void updateMesures(double newTopRectangle, double newLeftRectangle,
      List<Offset> newAllFacePoints) {
    topRectangle = newTopRectangle;
    leftRectangle = newLeftRectangle;
    allFacePoints = newAllFacePoints;
    notifyListeners();
  }

  List computeFaceMesures(
      double topFace, double leftFace, List<Offset> allPoints) {
    _foreheadLength = _distance(leftFace, allPoints[kBrowUp].dy);
    _sentimentLength =
        _distance(allPoints[kBrowUp].dy, allPoints[kBaseNoise].dy);
    _sportLength = _distance(allPoints[kBaseNoise].dy, allPoints[kBaseFace].dy);

    var a =
        _distance(allPoints[8].dx, allPoints[26].dx); // hada howwa 3rd lwajh
    var b = _distance(allPoints[kBrowUp].dy, allPoints[kBaseNoise].dy);
    if (b != 0) {
      _competenceLength = a / b;
    }

    if (a != 0) {
      _forgivenessLength =
          _distance(allPoints[kLeftEye].dx, allPoints[kRightEye].dx) / a;
      _selfRelianceLength = _distance(allPoints[128].dx, allPoints[130].dx) / a;
      _upperLipLength = _distance(allPoints[111].dy, allPoints[92].dy) / a;
      _lowerLipLength = _distance(allPoints[101].dy, allPoints[121].dy) / a;

//      print(
//          '_foreheadLength = $_foreheadLength, _sentimentLength = $_sentimentLength, _sportLength= $_sportLength');
//      print(
//          'a= $a, _forgivenessLength = $_forgivenessLength, _selfRelianceLength = $_selfRelianceLength, _upperLipLength= $_upperLipLength, _lowerLipLength= $_lowerLipLength');
//

    }

    return [
      _foreheadLength,
      _sentimentLength,
      _sportLength,
      _competenceLength,
      _forgivenessLength,
      _selfRelianceLength,
      _upperLipLength,
      _lowerLipLength
    ];
  }

  _distance(double x, double y) {
    double res = (x - y);
    return res.abs();
  }
}
