class BaseBean {
  BaseBean({
      this.dietrich, 
      this.monk, 
      this.theorem,});

  BaseBean.fromJson(dynamic json) {
    dietrich = json['dietrich'] != null ? Dietrich.fromJson(json['dietrich']) : null;
    monk = json['monk'] != null ? Monk.fromJson(json['monk']) : null;
    theorem = json['theorem'] != null ? Theorem.fromJson(json['theorem']) : null;
  }
  Dietrich? dietrich;
  Monk? monk;
  Theorem? theorem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dietrich != null) {
      map['dietrich'] = dietrich?.toJson();
    }
    if (monk != null) {
      map['monk'] = monk?.toJson();
    }
    if (theorem != null) {
      map['theorem'] = theorem?.toJson();
    }
    return map;
  }

}

class Theorem {
  Theorem({
      this.qua, 
      this.floc, 
      this.chloe, 
      this.gondola, 
      this.cure, 
      this.edward,});

  Theorem.fromJson(dynamic json) {
    qua = json['qua'];
    floc = json['floc'];
    chloe = json['chloe'];
    gondola = json['gondola'];
    cure = json['cure'];
    edward = json['edward'];
  }
  int? qua;
  String? floc;
  String? chloe;
  String? gondola;
  String? cure;
  String? edward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['qua'] = qua;
    map['floc'] = floc;
    map['chloe'] = chloe;
    map['gondola'] = gondola;
    map['cure'] = cure;
    map['edward'] = edward;
    return map;
  }

}

class Monk {
  Monk({
      this.ambient, 
      this.quo, 
      this.horowitz, 
      this.silage, 
      this.buffet, 
      this.janice,});

  Monk.fromJson(dynamic json) {
    ambient = json['ambient'];
    quo = json['quo'];
    horowitz = json['horowitz'];
    silage = json['silage'];
    buffet = json['buffet'];
    janice = json['janice'];
  }
  String? ambient;
  String? quo;
  String? horowitz;
  String? silage;
  String? buffet;
  String? janice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ambient'] = ambient;
    map['quo'] = quo;
    map['horowitz'] = horowitz;
    map['silage'] = silage;
    map['buffet'] = buffet;
    map['janice'] = janice;
    return map;
  }

}

class Dietrich {
  Dietrich({
      this.arrack, 
      this.navel, 
      this.pyknotic, 
      this.assuage, 
      this.krueger, 
      this.lusty,});

  Dietrich.fromJson(dynamic json) {
    arrack = json['arrack'];
    navel = json['navel'];
    pyknotic = json['pyknotic'];
    assuage = json['assuage'];
    krueger = json['krueger'];
    lusty = json['lusty'];
  }
  String? arrack;
  String? navel;
  String? pyknotic;
  String? assuage;
  String? krueger;
  String? lusty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arrack'] = arrack;
    map['navel'] = navel;
    map['pyknotic'] = pyknotic;
    map['assuage'] = assuage;
    map['krueger'] = krueger;
    map['lusty'] = lusty;
    return map;
  }

}