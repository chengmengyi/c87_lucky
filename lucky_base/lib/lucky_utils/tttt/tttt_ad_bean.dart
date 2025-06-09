import 'package:lucky_base/lucky_utils/tttt/base_bean.dart';

class TtttAdBean {
  TtttAdBean({
    this.attain,
    this.cometary,
    this.mention,
    this.sterling,
    this.frigate,
    this.modish,
    this.eyeful,
    this.tear,
    this.baseBean,
  });

  double? attain;
  String? cometary;
  String? mention;
  String? sterling;
  String? frigate;
  String? modish;
  String? eyeful;
  String? tear;
  BaseBean? baseBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attain'] = attain;
    map['cometary'] = cometary;
    map['mention'] = mention;
    map['sterling'] = sterling;
    map['frigate'] = frigate;
    map['modish'] = modish;
    map['eyeful'] = eyeful;
    map['tear'] = tear;
    map['teapot'] = "mechanic";
    var baseMap = baseBean?.toJson()??{};
    for (var value in baseMap.keys) {
      map[value]=baseMap[value];
    }
    return map;
  }

}