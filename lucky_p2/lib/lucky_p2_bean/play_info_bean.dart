class PlayInfoBean {
  PlayInfoBean({
      this.type, 
      this.playedNum, 
      this.unlock, 
      this.time,
      this.watchVideoNum,
  });

  PlayInfoBean.fromJson(dynamic json) {
    type = json['type'];
    playedNum = json['playedNum'];
    unlock = json['unlock'];
    time = json['time'];
    watchVideoNum = json['watchVideoNum'];
  }
  String? type;
  int? playedNum;
  int? unlock;
  int? time;
  int? watchVideoNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['playedNum'] = playedNum;
    map['unlock'] = unlock;
    map['time'] = time;
    map['watchVideoNum'] = watchVideoNum;
    return map;
  }

  @override
  String toString() {
    return 'PlayInfoBean{type: $type, playedNum: $playedNum, unlock: $unlock, time: $time, watchVideoNum: $watchVideoNum}';
  }
}