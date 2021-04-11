import 'package:flutter/material.dart';

import 'components/reusable_card.dart';
import 'constants.dart';
import 'model/brain_face.dart';

class FaceAnalysis extends StatelessWidget {
  final List mesuresFace;
  FaceAnalysis(this.mesuresFace);
  @override
  Widget build(BuildContext context) {
    BrainFace brainFace = BrainFace(mesures: mesuresFace);
    brainFace.initFaceMesures(); // voir brain face class
    return Scaffold(
      appBar: AppBar(
        title: Text('FACE READING ANALYSIS'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5.0,
        heroTag: null,
        backgroundColor: kBottomContainerColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
        tooltip: 'Face reading',
        icon: Icon(Icons.arrow_back_ios),
        label: Text('Re-Analyse'),
      ),
      body: ListView(
        children: <Widget>[
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Mental activity result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getConfidence(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultConfidence(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationConfidence(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sentiments result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getSentiment(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultSentiment(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationSentiment(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sport result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getSport(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultSport(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationSport(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Competence result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getCompetence(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultCompetence(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationCompetence(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Forgiveness result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getForgiveness(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultForgiveness(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationForgiveness(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Self-reliance result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getSelfReliance(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultSelfReliance(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationSelfReliance(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Generosity result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getlowerLip(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultLowerLip(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationLowerLip(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          ReusableCard(
            color: kActiveCardColor,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Redundancy & briefty result'.toUpperCase(),
                  style: kTitleStyle,
                ),
//                Text(
//                  brainFace.getUpperLip(),
//                  style: kMesureResult,
//                ),
                Text(
                  brainFace.getResultUpperLip(),
                  style: kBMIStyle,
                ),
                Text(
                  brainFace.getInterpretationUpperLip(),
                  style: kBodyStyle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
