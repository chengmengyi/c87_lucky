import 'dart:io';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/tttt/base_bean.dart';
import 'package:lucky_base/lucky_utils/tttt/header_bean.dart';
import 'package:lucky_base/lucky_utils/tttt/install_bean.dart';
import 'package:lucky_base/lucky_utils/tttt/query_bean.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_ad_bean.dart';

abstract class BaseTTT{

  Future<BaseBean> getBaseBean() async => BaseBean(
    dietrich: Dietrich(
      arrack: await FlutterTbaInfo.instance.getIdfv(),
      navel: await FlutterTbaInfo.instance.getAndroidId(),
      pyknotic: await FlutterTbaInfo.instance.getBundleId(),
      assuage: await FlutterTbaInfo.instance.getBrand(),
      krueger: await FlutterTbaInfo.instance.getOperator(),
      lusty: await FlutterTbaInfo.instance.getManufacturer(),
    ),
    monk: Monk(
      ambient: await FlutterTbaInfo.instance.getDistinctId(),
      quo: await FlutterTbaInfo.instance.getGaid(),
      horowitz: Platform.isAndroid?"carbonyl":"detach",
      silage: await FlutterTbaInfo.instance.getLogId(),
      buffet: await FlutterTbaInfo.instance.getOsCountry(),
      janice: await FlutterTbaInfo.instance.getAppVersion(),
    ),
    //BoomC38@123
    theorem: Theorem(
      qua: DateTime.now().millisecondsSinceEpoch,
      floc: await FlutterTbaInfo.instance.getIdfa(),
      chloe: await FlutterTbaInfo.instance.getSystemLanguage(),
      gondola: await FlutterTbaInfo.instance.getNetworkType(),
      cure: await FlutterTbaInfo.instance.getDeviceModel(),
      edward: await FlutterTbaInfo.instance.getOsVersion(),
    )
  );

  Future<HeaderBean> getHeaderBean(String? network,String? androidId) async => HeaderBean(
    gondola: network,
    navel: androidId,
  );

  Future<QueryBean> getQueryBean(String? idfa,String? logId) async => QueryBean(
    floc: idfa,
    silage: logId,
  );

  Future<InstallBean> getInstallBean() async{
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    return InstallBean(
      tony: referrerMap["build"],
      rutland: referrerMap["referrer_url"],
      giles: referrerMap["install_version"],
      downpour: referrerMap["user_agent"],
      stung: "wisdom",
      oclock: referrerMap["referrer_click_timestamp_seconds"],
      loris: referrerMap["install_begin_timestamp_seconds"],
      uterine: referrerMap["referrer_click_timestamp_server_seconds"],
      winemake: referrerMap["install_begin_timestamp_server_seconds"],
      malign: referrerMap["install_first_seconds"],
      splat: referrerMap["last_update_seconds"],
      reel: referrerMap["google_play_instant"],
      teapot: "khaki",
      baseBean: await getBaseBean(),
    );
  }

  Future<TtttAdBean> getAdBean(MaxAd? ad,AdPosId pointId,AdInfoData? adBean,)async => TtttAdBean(
    attain: (ad?.revenue??0)*1000000,
    cometary: "USD",
    mention: ad?.networkName??"",
    sterling: adBean?.adPlat??"",
    frigate: adBean?.adId??"",
    modish: pointId.name,
    eyeful: adBean?.adType.name,
    tear: ad?.revenuePrecision??"",
    baseBean: await getBaseBean(),
  );
}