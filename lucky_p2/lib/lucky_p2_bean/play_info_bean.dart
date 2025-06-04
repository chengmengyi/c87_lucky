class PlayInfoBean {
  PlayInfoBean({
    this.type,
    this.playedNum,
    this.hasNum,
    this.secondsNum,
    this.showFinger,
  });

  PlayInfoBean.fromJson(dynamic json) {
    type = json['type'];
    playedNum = json['playedNum'];
    hasNum = json['hasNum'];
    secondsNum = json['secondsNum'];
  }
  String? type;
  int? playedNum;
  int? hasNum;
  int? secondsNum;
  bool? showFinger;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['playedNum'] = playedNum;
    map['hasNum'] = hasNum;
    map['secondsNum'] = secondsNum;
    return map;
  }

  @override
  String toString() {
    return 'PlayInfoBean{type: $type, playedNum: $playedNum, hasNum: $hasNum, secondsNum: $secondsNum, showFinger: $showFinger}';
  }
}