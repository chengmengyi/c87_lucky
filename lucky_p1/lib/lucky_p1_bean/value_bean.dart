class ValueBean {
  ValueBean({
      this.cardFruit, 
      this.cardNumber, 
      this.cardTiger, 
      this.card77hot, 
      this.cardEmoji, 
      this.card8rich,});

  ValueBean.fromJson(dynamic json) {
    cardFruit = json['card_fruit'] != null ? CardFruit.fromJson(json['card_fruit']) : null;
    cardNumber = json['card_number'] != null ? CardNumber.fromJson(json['card_number']) : null;
    cardTiger = json['card_tiger'] != null ? CardTiger.fromJson(json['card_tiger']) : null;
    card77hot = json['card_77hot'] != null ? Card77hot.fromJson(json['card_77hot']) : null;
    cardEmoji = json['card_emoji'] != null ? CardEmoji.fromJson(json['card_emoji']) : null;
    card8rich = json['card_8rich'] != null ? Card8rich.fromJson(json['card_8rich']) : null;
  }
  CardFruit? cardFruit;
  CardNumber? cardNumber;
  CardTiger? cardTiger;
  Card77hot? card77hot;
  CardEmoji? cardEmoji;
  Card8rich? card8rich;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cardFruit != null) {
      map['card_fruit'] = cardFruit?.toJson();
    }
    if (cardNumber != null) {
      map['card_number'] = cardNumber?.toJson();
    }
    if (cardTiger != null) {
      map['card_tiger'] = cardTiger?.toJson();
    }
    if (card77hot != null) {
      map['card_77hot'] = card77hot?.toJson();
    }
    if (cardEmoji != null) {
      map['card_emoji'] = cardEmoji?.toJson();
    }
    if (card8rich != null) {
      map['card_8rich'] = card8rich?.toJson();
    }
    return map;
  }

}

class Card8rich {
  Card8rich({
      this.winupNumber, 
      this.point3match, 
      this.point8bet, 
      this.prize,});

  Card8rich.fromJson(dynamic json) {
    winupNumber = json['winup_number'];
    point3match = json['point_3match'];
    point8bet = json['point_8bet'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  int? winupNumber;
  int? point3match;
  int? point8bet;
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['point_3match'] = point3match;
    map['point_8bet'] = point8bet;
    map['prize'] = prize;
    return map;
  }

}

class CardEmoji {
  CardEmoji({
      this.winupNumber, 
      this.pointFace, 
      this.prize,});

  CardEmoji.fromJson(dynamic json) {
    winupNumber = json['winup_number'];
    pointFace = json['point_face'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  int? winupNumber;
  int? pointFace;
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['point_face'] = pointFace;
    map['prize'] = prize;
    return map;
  }

}

class Card77hot {
  Card77hot({
      this.winupNumber, 
      this.point7, 
      this.point77, 
      this.prize,});

  Card77hot.fromJson(dynamic json) {
    winupNumber = json['winup_number'];
    point7 = json['point_7'];
    point77 = json['point_77'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  int? winupNumber;
  int? point7;
  int? point77;
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['point_7'] = point7;
    map['point_77'] = point77;
    map['prize'] = prize;
    return map;
  }

}

class CardTiger {
  CardTiger({
      this.winupNumber, 
      this.tiger0, 
      this.tiger3, 
      this.tiger4, 
      this.tiger5, 
      this.tiger6, 
      this.tiger7, 
      this.tiger8, 
      this.tiger9, 
      this.tiger10, 
      this.prize,});

  CardTiger.fromJson(dynamic json) {
    winupNumber = json['winup_number'];
    tiger0 = json['tiger0'];
    tiger3 = json['tiger3'];
    tiger4 = json['tiger4'];
    tiger5 = json['tiger5'];
    tiger6 = json['tiger6'];
    tiger7 = json['tiger7'];
    tiger8 = json['tiger8'];
    tiger9 = json['tiger9'];
    tiger10 = json['tiger10'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  int? winupNumber;
  int? tiger0;
  int? tiger3;
  int? tiger4;
  int? tiger5;
  int? tiger6;
  int? tiger7;
  int? tiger8;
  int? tiger9;
  int? tiger10;
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['tiger0'] = tiger0;
    map['tiger3'] = tiger3;
    map['tiger4'] = tiger4;
    map['tiger5'] = tiger5;
    map['tiger6'] = tiger6;
    map['tiger7'] = tiger7;
    map['tiger8'] = tiger8;
    map['tiger9'] = tiger9;
    map['tiger10'] = tiger10;
    map['prize'] = prize;
    return map;
  }

}

class CardNumber {
  CardNumber({
      this.winupNumber, 
      this.point, 
      this.prize,});

  CardNumber.fromJson(dynamic json) {
    winupNumber = json['winup_number'];
    point = json['point'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  int? winupNumber;
  int? point;
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['point'] = point;
    map['prize'] = prize;
    return map;
  }

}

class CardFruit {
  CardFruit({
      this.winupNumber, 
      this.point, 
      this.prize,});

  CardFruit.fromJson(dynamic json) {
    winupNumber = json['winup_number'];
    point = json['point'];
    prize = json['prize'] != null ? json['prize'].cast<int>() : [];
  }
  int? winupNumber;
  int? point;
  List<int>? prize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['winup_number'] = winupNumber;
    map['point'] = point;
    map['prize'] = prize;
    return map;
  }

}