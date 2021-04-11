import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'face_analysis.dart';
import 'model/mesures_data.dart';
import 'utils.dart';

class FacePage extends StatefulWidget {
  @override
  _FacePageState createState() => _FacePageState();
}

bool loading = true;
ui.Image Fimage;

class _FacePageState extends State<FacePage> {
  File _imageFile;
  List<Face> _faces;

  //from Camera
  Future getImageCamera() async {
    var imageCamera = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = imageCamera;
    });
  }

  void _getImageAndDetectFacesCamera() async {
    await getImageCamera();
    final image = FirebaseVisionImage.fromFile(
        _imageFile); //fromFilePath(imageFile.path);
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        //    mode: FaceDetectorMode.accurate,
        enableClassification: false,
        enableLandmarks: false,
        enableContours: true,
        enableTracking: false,
      ),
    );
    final faces = await faceDetector.processImage(image);

    Fimage = await loadImage(_imageFile);

    if (mounted) {
      setState(() {
        loading = false;
        _faces = faces;
      });
    }
  }

  Future pickImageGallery() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = imageFile;
    });
  }

  void _getImageAndDetectFacesGallery() async {
    await pickImageGallery();
    //print(' path file = ${imageFile.path}');
    final image = FirebaseVisionImage.fromFile(
        _imageFile); //fromFilePath(imageFile.path);
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        //    mode: FaceDetectorMode.accurate,
        enableClassification: false,
        enableLandmarks: false,
        enableContours: true,
        enableTracking: false,
      ),
    );
    final faces = await faceDetector.processImage(image);

    Fimage = await loadImage(_imageFile);

    if (mounted) {
      setState(() {
        loading = false;
        _faces = faces;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //loading = true;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onAfterBuild(context);
    });

    return Consumer<MesuresData>(
      builder: (context, MesuresData, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Face Scanner'),
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                        child: Text(
                      'Use this app to have an idea about your face or your friends faces using photos',
                      style: kTitleStyle,
                    )),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_photo_alternate),
                    title: Text('Image from Gallery'),
                    onTap: () {
                      _getImageAndDetectFacesGallery();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Use your Camera'),
                    onTap: () {
                      _getImageAndDetectFacesCamera();
                      Navigator.pop(context);
                    },
                  ), //use the Camera
                  ListTile(
                    leading: Icon(Icons.face),
                    title: Text('Face reader'),
                    onTap: () async {
                      if (loading == false) {
                        var mesuresList = MesuresData.computeFaceMesures(
                            MesuresData.topRectangle,
                            MesuresData.leftRectangle,
                            MesuresData.allFacePoints);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FaceAnalysis(mesuresList),
                          ),
                        );
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Choose image first !",
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                  "Pick an image from your gallery or take a photo with your Camera!"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ), //Face Analysis
                  ListTile(
                    leading: Icon(Icons.close),
                    title: Text('Close'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: (_imageFile == null)
                ? Container(
                    child: Center(
                      child: Text(
                        'Pick an image from gallery OR use the Camera',
                        style: kTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : loading
                    ? ProcessingContainer()
                    : Wrap(
                        children: <Widget>[
//                        BottomButton(
//                          buttonTitle: 'FACE ANALYSIS',
//                          onTap: () {
//                            var mesuresList = MesuresData.computeFaceMesures(
//                                MesuresData.topRectangle,
//                                MesuresData.leftRectangle,
//                                MesuresData.allFacePoints);
//
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (BuildContext context) =>
//                                    FaceAnalysis(mesuresList),
//                              ),
//                            );
//                          },
//                        ),
                          ImagesAndFaces(imageFile: _imageFile, faces: _faces),
                        ],
                      ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  elevation: 5.0,
                  heroTag: null,
                  backgroundColor: kBottomContainerColor,
                  foregroundColor: Colors.white,
                  onPressed: _getImageAndDetectFacesCamera,
                  tooltip: 'Take a photo',
                  child: Icon(Icons.camera),
                ),
                FloatingActionButton(
                  elevation: 5.0,
                  heroTag: null,
                  backgroundColor: kBottomContainerColor,
                  foregroundColor: Colors.white,
                  onPressed: _getImageAndDetectFacesGallery,
                  tooltip: 'Pick an image from the Gallery',
                  child: Icon(Icons.add_photo_alternate),
                ),
                (_imageFile != null)
                    ? FloatingActionButton.extended(
                        elevation: 5.0,
                        heroTag: null,
                        backgroundColor: kBottomContainerColor,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          var mesuresList = MesuresData.computeFaceMesures(
                              MesuresData.topRectangle,
                              MesuresData.leftRectangle,
                              MesuresData.allFacePoints);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FaceAnalysis(mesuresList),
                            ),
                          );
                        },
                        tooltip: 'Face reading',
                        icon: Icon(Icons.arrow_forward_ios),
                        label: Text('Analyse'),
                      )
                    : SizedBox.shrink(),
              ],
            ));
      },
    );
  }

  Container ProcessingContainer() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text('Image selected the model is processing its features'),
          CircularProgressIndicator(),
        ],
      )),
    );
  }

  void onAfterBuild(BuildContext context) {
    // I can now safely get the faces ...
    Provider.of<MesuresData>(context, listen: false)
        .updateMesures(topFace, leftFace, allFacePoints);
  }
}

class ImagesAndFaces extends StatelessWidget {
  final File imageFile;
  final List<Face> faces;

  ImagesAndFaces({this.imageFile, this.faces});

  @override
  Widget build(BuildContext context) {
    var faceContoursPaint;
    try {
      faceContoursPaint = CustomPaint(
        painter: FaceContourPainter(Fimage, faces, context),
      );
    } catch (e) {
      print('Error = $e');
    }

    return Center(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
            height: Fimage.height.toDouble(),
            width: Fimage.width.toDouble(),
            child: faceContoursPaint),
      ),
    );
  }
}

//face contour class
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
    ..strokeWidth = 5.0
    ..color = Colors.green;

  BuildContext context;

  FaceContourPainter(this.image, this.faces, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      topFace = faces[i].boundingBox.top;
      leftFace = faces[i].boundingBox.left;
      allFacePoints =
          faces[i].getContour(FaceContourType.allPoints).positionsList;

      //paint face features
      paintFaceFeatures(faces[i], canvas, size);
      // plot traits measures
      paintTraitsMesures(canvas, size);
    }
  }

  List<Offset> _scalePoints({
    List<Offset> offsets,
    @required Size imageSize,
    @required Size widgetSize,
  }) {
    final double scaleX = widgetSize.width / imageSize.width;
    final double scaleY = widgetSize.height / imageSize.height;

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

  void paintTraitsMesures(Canvas canvas, Size size) {
    final Size imageSize = size;

    /*
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

     */
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
    // nssddo l7ajb man lfou9
    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: [allFacePoints[40], allFacePoints[45]],
            imageSize: imageSize,
            widgetSize: size),
        facePaint);

    canvas.drawPoints(
        PointMode.polygon,
        _scalePoints(
            offsets: [allFacePoints[50], allFacePoints[55]],
            imageSize: imageSize,
            widgetSize: size),
        facePaint);

    canvas.drawRect(rect, facePaint);
  }
}
