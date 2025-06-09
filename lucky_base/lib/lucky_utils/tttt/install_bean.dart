import 'package:lucky_base/lucky_utils/tttt/base_bean.dart';

class InstallBean {
  InstallBean({
    this.tony,
    this.rutland,
    this.giles,
    this.downpour,
    this.stung,
    this.oclock,
    this.loris,
    this.uterine,
    this.winemake,
    this.malign,
    this.splat,
    this.reel,
    this.teapot,
    this.baseBean
  });

  String? tony;
  String? rutland;
  String? giles;
  String? downpour;
  String? stung;
  int? oclock;
  int? loris;
  int? uterine;
  int? winemake;
  int? malign;
  int? splat;
  bool? reel;
  String? teapot;
  BaseBean? baseBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tony'] = tony;
    map['rutland'] = rutland;
    map['giles'] = giles;
    map['downpour'] = downpour;
    map['stung'] = stung;
    map['oclock'] = oclock;
    map['loris'] = loris;
    map['uterine'] = uterine;
    map['winemake'] = winemake;
    map['malign'] = malign;
    map['splat'] = splat;
    map['reel'] = reel;
    map['teapot'] = teapot;
    var baseMap = baseBean?.toJson()??{};
    for (var value in baseMap.keys) {
      map[value]=baseMap[value];
    }
    return map;
  }

}