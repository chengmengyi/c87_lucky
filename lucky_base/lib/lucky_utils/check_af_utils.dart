import 'dart:io';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:flutter_check_af/request_af/request_af_callback.dart';
import 'package:flutter_check_af/request_cloak/request_cloak_callback.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';

StorageData<bool> p1HomeShowing=StorageData<bool>(key: "p1HomeShowing", defaultValue: false);


class CheckAfUtils{
  static final CheckAfUtils _instance = CheckAfUtils();
  static CheckAfUtils get instance => _instance;

  initAf()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var cloakData=CloakBean(
      pyknotic: await FlutterTbaInfo.instance.getBundleId(),
      horowitz: Platform.isAndroid?"carbonyl":"detach",
      janice: await FlutterTbaInfo.instance.getAppVersion(),
      ambient: await FlutterTbaInfo.instance.getDistinctId(),
      qua: DateTime.now().millisecondsSinceEpoch,
      cure: await FlutterTbaInfo.instance.getDeviceModel(),
      edward: await FlutterTbaInfo.instance.getOsVersion(),
      arrack: await FlutterTbaInfo.instance.getIdfv(),
      quo: await FlutterTbaInfo.instance.getGaid(),
      navel: await FlutterTbaInfo.instance.getAndroidId(),
      floc: await FlutterTbaInfo.instance.getIdfa(),
      krueger: await FlutterTbaInfo.instance.getOperator(),
    );
    FlutterCheckAf.instance.init(
      afKey: afKey.base64(),
      afAppId: afAppId.base64(),
      afSwitch: FirebaseUtils.instance.afSwitch,
      distinctId: distinctId,
      clockUrl: cloakUrl,
      cloakWhiteKey: "bedevil",
      cloakData: cloakData.toJson(),
      requestAfCallback: RequestAfCallback(
        startRequestAf: (){
          TTTTUtils.instance.pointEvent(customId: CustomId.af_req);
        },
        requestSuccess: (bool isB){
          //adj_user:[0] [1]   【0】为A包用户、【1】为B包用户
          TTTTUtils.instance.pointEvent(customId: CustomId.af_suc,params: {"adj_user":isB?1:0});
          _checkUserDelay();
        },
        firstRequestAfB: (){
          TTTTUtils.instance.pointEvent(customId: CustomId.organic_to_buy);
        },
        startAfSuccess: (){},
        startAfFail: (int code,String msg){},
      ),
      requestCloakCallback: RequestCloakCallback(
        startRequestCloak: (){
          TTTTUtils.instance.pointEvent(customId: CustomId.cloak_req);
        },
        requestSuccess: (bool isWhite){
          //cloak_user：【0】【1】，对应【黑名单用户】【自然量用户】
          TTTTUtils.instance.pointEvent(customId: CustomId.cloak_suc,params: {"cloak_user":isWhite?1:0});
          _checkUserDelay();
        },
      ),
    );
  }

  _checkUserDelay(){
    if(p1HomeShowing.getData()&&FlutterCheckAf.instance.checkUser()){
      p1HomeShowing.saveData(false);
      LuckyRouters.instance.openNextPage(routersName: "/luckyP2/home");
    }
  }
}

class CloakBean{
  String? pyknotic;
  String? horowitz;
  String? janice;
  String? ambient;
  int? qua;
  String? cure;
  String? edward;
  String? arrack;
  String? quo;
  String? navel;
  String? floc;
  String? krueger;
  CloakBean({
    this.pyknotic,
    this.horowitz,
    this.janice,
    this.ambient,
    this.qua,
    this.cure,
    this.edward,
    this.arrack,
    this.quo,
    this.navel,
    this.floc,
    this.krueger,
});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pyknotic'] = pyknotic;
    map['horowitz'] = horowitz;
    map['janice'] = janice;
    map['ambient'] = ambient;
    map['qua'] = qua;
    map['cure'] = cure;
    map['edward'] = edward;
    map['arrack'] = arrack;
    map['quo'] = quo;
    map['navel'] = navel;
    map['floc'] = floc;
    map['krueger'] = krueger;
    return map;
  }
}