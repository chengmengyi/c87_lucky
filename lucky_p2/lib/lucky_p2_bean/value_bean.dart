class ValueBean {
  ValueBean({
    this.winupNumber,
    this.cardRange,
    this.newPrize,
    this.queueNumberAll,
    this.queueNumberCurrent,
    this.intadPoint,
    this.floatPrize,
    this.wheelPoint,
    this.keyOut,
    this.cardFruitPlay1,
    this.cardNumberPlay2,
    this.cardTigerPlay3,
    this.card77hotPlay4,
    this.cardDiamondPlay5,
    this.card9betPlay6,
    this.wtdTask,
    this.checkReward,
    this.boxPrize,
  });

  ValueBean.fromJson(dynamic json) {
    winupNumber = json['winup_number'] != null ? json['winup_number'].cast<int>() : [];
    cardRange = json['card_range'] != null ? json['card_range'].cast<int>() : [];
    newPrize = json['new_prize'];
    queueNumberAll = json['queue_number_all'] != null ? QueueNumberAll.fromJson(json['queue_number_all']) : null;
    queueNumberCurrent = json['queue_number_current'] != null ? QueueNumberCurrent.fromJson(json['queue_number_current']) : null;
    if (json['intad_point'] != null) {
      intadPoint = [];
      json['intad_point'].forEach((v) {
        intadPoint?.add(IntadPoint.fromJson(v));
      });
    }
    if (json['float_prize'] != null) {
      floatPrize = [];
      json['float_prize'].forEach((v) {
        floatPrize?.add(FloatPrize.fromJson(v));
      });
    }
    wheelPoint = json['wheel_point'] != null ? WheelPoint.fromJson(json['wheel_point']) : null;
    if (json['key_out'] != null) {
      keyOut = [];
      json['key_out'].forEach((v) {
        keyOut?.add(IntadPoint.fromJson(v));
      });
    }
    cardFruitPlay1 = json['card_fruit_play1'] != null ? CardFruitPlay1.fromJson(json['card_fruit_play1']) : null;
    cardNumberPlay2 = json['card_number_play2'] != null ? CardFruitPlay1.fromJson(json['card_number_play2']) : null;
    cardTigerPlay3 = json['card_tiger_play3'] != null ? CardFruitPlay1.fromJson(json['card_tiger_play3']) : null;
    card77hotPlay4 = json['card_77hot_play4'] != null ? CardFruitPlay1.fromJson(json['card_77hot_play4']) : null;
    cardDiamondPlay5 = json['card_diamond_play5'] != null ? CardFruitPlay1.fromJson(json['card_diamond_play5']) : null;
    card9betPlay6 = json['card_9bet_play6'] != null ? CardFruitPlay1.fromJson(json['card_9bet_play6']) : null;
    if (json['wtd_task'] != null) {
      wtdTask = [];
      json['wtd_task'].forEach((v) {
        wtdTask?.add(WtdTask.fromJson(v));
      });
    }
    checkReward = json['check_reward'] != null ? json['check_reward'].cast<int>() : [];
    if (json['box_prize'] != null) {
      boxPrize = [];
      json['box_prize'].forEach((v) {
        boxPrize?.add(FloatPrize.fromJson(v));
      });
    }
  }
  List<int>? winupNumber;
  List<int>? cardRange;
  int? newPrize;
  QueueNumberAll? queueNumberAll;
  QueueNumberCurrent? queueNumberCurrent;
  List<IntadPoint>? intadPoint;
  List<FloatPrize>? floatPrize;
  WheelPoint? wheelPoint;
  List<IntadPoint>? keyOut;
  CardFruitPlay1? cardFruitPlay1;
  CardFruitPlay1? cardNumberPlay2;
  CardFruitPlay1? cardTigerPlay3;
  CardFruitPlay1? card77hotPlay4;
  CardFruitPlay1? cardDiamondPlay5;
  CardFruitPlay1? card9betPlay6;
  List<WtdTask>? wtdTask;
  List<int>? checkReward;
  List<FloatPrize>? boxPrize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['card_range'] = cardRange;
    map['new_prize'] = newPrize;
    if (queueNumberAll != null) {
      map['queue_number_all'] = queueNumberAll?.toJson();
    }
    if (queueNumberCurrent != null) {
      map['queue_number_current'] = queueNumberCurrent?.toJson();
    }
    if (intadPoint != null) {
      map['intad_point'] = intadPoint?.map((v) => v.toJson()).toList();
    }
    if (floatPrize != null) {
      map['float_prize'] = floatPrize?.map((v) => v.toJson()).toList();
    }
    if (wheelPoint != null) {
      map['wheel_point'] = wheelPoint?.toJson();
    }
    if (keyOut != null) {
      map['key_out'] = keyOut?.map((v) => v.toJson()).toList();
    }
    if (cardFruitPlay1 != null) {
      map['card_fruit_play1'] = cardFruitPlay1?.toJson();
    }
    if (cardNumberPlay2 != null) {
      map['card_number_play2'] = cardNumberPlay2?.toJson();
    }
    if (cardTigerPlay3 != null) {
      map['card_tiger_play3'] = cardTigerPlay3?.toJson();
    }
    if (card77hotPlay4 != null) {
      map['card_77hot_play4'] = card77hotPlay4?.toJson();
    }
    if (cardDiamondPlay5 != null) {
      map['card_diamond_play5'] = cardDiamondPlay5?.toJson();
    }
    if (card9betPlay6 != null) {
      map['card_9bet_play6'] = card9betPlay6?.toJson();
    }
    if (wtdTask != null) {
      map['wtd_task'] = wtdTask?.map((v) => v.toJson()).toList();
    }
    map['check_reward'] = checkReward;
    if (boxPrize != null) {
      map['box_prize'] = boxPrize?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class WtdTask {
  WtdTask({
      this.type, 
      this.num,});

  WtdTask.fromJson(dynamic json) {
    type = json['type'];
    num = json['num'];
  }
  String? type;
  int? num;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['num'] = num;
    return map;
  }

}

class RewardMoney {
  RewardMoney({
      this.type, 
      this.scale,});

  RewardMoney.fromJson(dynamic json) {
    type = json['type'];
    scale = json['scale'];
  }
  int? type;
  int? scale;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['scale'] = scale;
    return map;
  }

}

class RewardNumber {
  RewardNumber({
      this.number, 
      this.scale,});

  RewardNumber.fromJson(dynamic json) {
    number = json['number'];
    scale = json['scale'];
  }
  int? number;
  int? scale;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = number;
    map['scale'] = scale;
    return map;
  }

}

class CardFruitPlay1 {
  CardFruitPlay1({
      this.rewardNormal, 
      this.bigwinNumber, 
      this.rewardNumber, 
      this.rewardMoney,});

  CardFruitPlay1.fromJson(dynamic json) {
    rewardNormal = json['reward_normal'];
    bigwinNumber = json['bigwin_number'];
    if (json['reward_number'] != null) {
      rewardNumber = [];
      json['reward_number'].forEach((v) {
        rewardNumber?.add(RewardNumber.fromJson(v));
      });
    }
    if (json['reward_money'] != null) {
      rewardMoney = [];
      json['reward_money'].forEach((v) {
        rewardMoney?.add(RewardMoney.fromJson(v));
      });
    }
  }
  int? rewardNormal;
  int? bigwinNumber;
  List<RewardNumber>? rewardNumber;
  List<RewardMoney>? rewardMoney;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reward_normal'] = rewardNormal;
    map['bigwin_number'] = bigwinNumber;
    if (rewardNumber != null) {
      map['reward_number'] = rewardNumber?.map((v) => v.toJson()).toList();
    }
    if (rewardMoney != null) {
      map['reward_money'] = rewardMoney?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class WheelPoint {
  WheelPoint({
      this.point20, 
      this.point50, 
      this.point80, 
      this.point100, 
      this.iphonePoint,});

  WheelPoint.fromJson(dynamic json) {
    point20 = json['point_20'];
    point50 = json['point_50'];
    point80 = json['point_80'];
    point100 = json['point_100'];
    iphonePoint = json['iphone_point'];
  }
  int? point20;
  int? point50;
  int? point80;
  int? point100;
  int? iphonePoint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['point_20'] = point20;
    map['point_50'] = point50;
    map['point_80'] = point80;
    map['point_100'] = point100;
    map['iphone_point'] = iphonePoint;
    return map;
  }

}

class FloatPrize {
  FloatPrize({
      this.firstNumber, 
      this.prize, 
      this.endNumber,});

  FloatPrize.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  List<int>? prize;
  int? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['prize'] = prize;
    map['end_number'] = endNumber;
    return map;
  }

}

class IntadPoint {
  IntadPoint({
      this.firstNumber, 
      this.point, 
      this.endNumber,});

  IntadPoint.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    point = json['point'];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  int? point;
  int? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['point'] = point;
    map['end_number'] = endNumber;
    return map;
  }

}

class QueueNumberCurrent {
  QueueNumberCurrent({
      this.intCurrent, 
      this.intCurrentDelete,});

  QueueNumberCurrent.fromJson(dynamic json) {
    intCurrent = json['int_current'];
    intCurrentDelete = json['int_current_delete'] != null ? json['int_current_delete'].cast<int>() : [];
  }
  int? intCurrent;
  List<int>? intCurrentDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['int_current'] = intCurrent;
    map['int_current_delete'] = intCurrentDelete;
    return map;
  }

}

class QueueNumberAll {
  QueueNumberAll({
      this.intAll, 
      this.intAllDelete,});

  QueueNumberAll.fromJson(dynamic json) {
    intAll = json['int_all'];
    intAllDelete = json['int_all_delete'] != null ? json['int_all_delete'].cast<int>() : [];
  }
  int? intAll;
  List<int>? intAllDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['int_all'] = intAll;
    map['int_all_delete'] = intAllDelete;
    return map;
  }

}