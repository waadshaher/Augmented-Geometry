class Tracker {
  final int orderVal;
  final int scoreVal;
  var dateVal;
  int notScoreVal;
  final String colorVal;
  Tracker(this.orderVal, this.scoreVal, this.colorVal);

  Tracker.fromMap(Map<String, dynamic> map)
      : assert(map['orderVal'] != null),
        assert(map['scoreVal'] != null),
        assert(map['colorVal'] != null),
        orderVal = map['orderVal'],
        scoreVal = map['scoreVal'],
        colorVal = map['colorVal'];

  @override
  String toString() => "Record<$orderVal:$scoreVal:$colorVal>";

  int doCalc() {
    notScoreVal = 5 - scoreVal;
    return notScoreVal;
  }
}
