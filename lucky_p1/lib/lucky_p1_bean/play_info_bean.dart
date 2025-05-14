class PlayInfoBean {
  PlayInfoBean({
      this.type, 
      this.playedNum, 
      this.unlock, 
      this.time,});

  PlayInfoBean.fromJson(dynamic json) {
    type = json['type'];
    playedNum = json['playedNum'];
    unlock = json['unlock'];
    time = json['time'];
  }
  String? type;
  int? playedNum;
  int? unlock;
  int? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['playedNum'] = playedNum;
    map['unlock'] = unlock;
    map['time'] = time;
    return map;
  }

  @override
  String toString() {
    return 'PlayInfoBean{type: $type, playedNum: $playedNum, unlock: $unlock, time: $time}';
  }
}