//order selon ordre de mesures ... voir class mesure data
// ... return [_foreheadLength, _sentimentLength, _sportLength, _competenceLength];

enum mesureType {
  foreheadLength,
  sentimentLength,
  sportLength,
  competenceLength,

  forgivenessLength, // 4 distance between eyses
  selfRelianceLength, // 5 tkabi nnif
  upperLipLength, // 6
  lowerLipLength, // 7

}

class BrainFace {
  final List mesures;
  double foreheadLength;
  double sentimentLength;
  double sportLength;
  double competenceLength;
  double forgivenessLength;
  double selfRelianceLength;
  double upperLipLength;
  double lowerLipLength;

  double _confidence;
  double _ahassis;
  double _sport;
  double _competence;
  double _forgiveness;
  double _selfReliance;
  double _upperLip;
  double _lowerLip;

  BrainFace({this.mesures}) {
    if (mesures.length > 0) {
      foreheadLength = mesures[mesureType.foreheadLength.index];
      sentimentLength = mesures[mesureType.sentimentLength.index];
      sportLength = mesures[mesureType.sportLength.index];
      competenceLength = mesures[mesureType.competenceLength.index];

      forgivenessLength = mesures[mesureType.forgivenessLength.index];
      selfRelianceLength = mesures[mesureType.selfRelianceLength.index];
      upperLipLength = mesures[mesureType.upperLipLength.index];
      lowerLipLength = mesures[mesureType.lowerLipLength.index];
    }
  }

  initFaceMesures() {
    var faceLength = foreheadLength + sentimentLength + sportLength;
    _confidence = foreheadLength / faceLength;
    _ahassis = sentimentLength / faceLength;
    _sport = sportLength / faceLength;
    _competence = competenceLength;
    _forgiveness = forgivenessLength;
    _selfReliance = selfRelianceLength;
    _upperLip = upperLipLength;
    _lowerLip = lowerLipLength;
  }

  String getConfidence() {
    var faceLength = foreheadLength + sentimentLength + sportLength;
    _confidence = foreheadLength / faceLength;
    return _confidence.toStringAsFixed(2);
  }

  String getResultConfidence() {
    if (_confidence > 0.3)
      return 'High confidence';
    else if (_confidence > 0.2)
      return 'Confidence normal';
    else
      return 'Under confidence';
  }

  String getInterpretationConfidence() {
    if (_confidence > 0.3)
      return 'Ohh ! You have much confidence than that of a normal person.';
    else if (_confidence > 0.2)
      return 'Your confidence is normal';
    else
      return 'Ohh! It seems your face tells you do not have mutch confidence';
  }

  String getSentiment() {
    var faceLength = foreheadLength + sentimentLength + sportLength;
    _ahassis = sentimentLength / faceLength;
    return _ahassis.toStringAsFixed(2);
  }

  String getResultSentiment() {
    if (_ahassis > 0.3)
      return 'Very sensitive';
    else if (_ahassis > 0.2)
      return 'Your senssitivity is normal';
    else
      return 'Not too sensitive';
  }

  String getInterpretationSentiment() {
    if (_ahassis > 0.3)
      return 'Yes! You have much sensitivity than that of a normal person.';
    else if (_ahassis > 0.2)
      return 'Your sensitivity is normal';
    else
      return 'It seems your face tells you you are not too senssitive';
  }

  String getSport() {
    var faceLength = foreheadLength + sentimentLength + sportLength;
    _sport = sportLength / faceLength;
    return _sport.toStringAsFixed(2);
  }

  String getResultSport() {
    if (_sport > 0.3)
      return 'Very sportif';
    else if (_sport > 0.2)
      return 'Sportif';
    else
      return 'Not very sportif';
  }

  String getInterpretationSport() {
    if (_sport > 0.3)
      return 'Ohh No! You are very sportif than that of a normal person.';
    else if (_sport > 0.2)
      return 'Your are sportif';
    else
      return 'Your face tells you do are not sportif';
  }

  String getCompetence() {
    _competence = competenceLength;
    return _competence.toStringAsFixed(2);
  }

  String getResultCompetence() {
    if (_competence > 1.85)
      return 'Very competent';
    else if (_competence > 1.6)
      return 'Competence normal';
    else
      return 'Not competent';
  }

  String getInterpretationCompetence() {
    if (_competence > 1.85)
      return 'Ohh! You face tells you are very competent.';
    else if (_competence > 1.6)
      return 'You face tells you are competent';
    else
      return 'Ohh! It seems your face tells you are not competent';
  }

  String getForgiveness() {
    _forgiveness = forgivenessLength;
    return forgivenessLength.toStringAsFixed(2);
  }

  String getResultForgiveness() {
    if (_forgiveness > 0.25)
      return 'Very tolerant';
    else if (_forgiveness > 0.20)
      return 'Forgiveness normal';
    else
      return 'low tolerance';
  }

  String getInterpretationForgiveness() {
    if (_forgiveness > 0.25) {
      return 'Your eyes tell you are very tolerent';
    } else if (_forgiveness > 0.20) {
      return 'Your eyes tell your tollerance is like a normal person';
    } else {
      return 'Your face tells you are not so much tolerant';
    }
  }

  String getSelfReliance() {
    _selfReliance = selfRelianceLength;
    return selfRelianceLength.toStringAsFixed(2);
  }

  String getResultSelfReliance() {
    if (_selfReliance > 0.25)
      return 'Very self-reliant';
    else
      return 'Self-reliance normal';
  }

  String getInterpretationSelfReliance() {
    if (_selfReliance > 0.25)
      return 'Your nose tells your are very self-reliant';
    else
      return 'Your nose tells your self-reliance is normal';
  }

  String getUpperLip() {
    _upperLip = upperLipLength;
    return _upperLip.toStringAsFixed(2);
  }

  String getResultUpperLip() {
    if (_upperLip > 0.1) {
      return 'Redundant';
    } else if (_upperLip > 0.07) {
      return 'Brief';
    } else
      return 'Very brief';
  }

  String getInterpretationUpperLip() {
    if (_upperLip > 0.1) {
      return 'Your lips say you like to explain things very good';
    } else if (_upperLip > 0.07) {
      return 'Your lips say you are brief';
    } else
      return 'Your lips say you are very brief';
  }

  String getlowerLip() {
    _lowerLip = lowerLipLength;
    return _lowerLip.toStringAsFixed(2);
  }

  String getResultLowerLip() {
    if (_lowerLip > 0.1) {
      return 'Very geneours';
    } else if (_lowerLip > 0.08)
      return 'Geneours';
    else
      return 'Provident';
  }

  String getInterpretationLowerLip() {
    if (_lowerLip > 0.1) {
      return 'Your lower lip says you are very generous';
    } else if (_lowerLip > 0.08) {
      return 'Your lips say  you are generous';
    } else
      return 'Your lips say you are provident';
  }
}
