import 'package:applovin_max/applovin_max.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';
import 'package:flutter_check_af/dio/dio_hep.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/tttt/base_ttt.dart';

StorageData<bool> p2InstallEvent=StorageData<bool>(key: "p2InstallEvent", defaultValue: false);


class TTTTUtils extends BaseTTT{
  static final TTTTUtils _instance = TTTTUtils();
  static TTTTUtils get instance => _instance;

  install({int tryNum=5})async{
    if(p2InstallEvent.getData()){
      return;
    }
    pointEvent(customId: CustomId.install);
    var installBean = await getInstallBean();
    var headerBean = await getHeaderBean(installBean.baseBean?.theorem?.gondola, installBean.baseBean?.dietrich?.navel);
    var queryBean = await getQueryBean(installBean.baseBean?.theorem?.floc, installBean.baseBean?.monk?.silage);
    var installMap = installBean.toJson();
    FlutterCheckAf.instance.log("tba--->install--->params:$installMap");
    var dioResult = await DioHep.instance.requestPost(
      path: tbaUrl+queryBean.toStr(),
      header: headerBean.toJson(),
      data: installMap,
    );
    FlutterCheckAf.instance.log("tba--->install--->result:${dioResult.success}--->$installMap");
    if(dioResult.success){
      p2InstallEvent.saveData(true);
    }else{
      if(tryNum>0){
        Future.delayed(const Duration(milliseconds: 2000));
        install(tryNum: tryNum-1);
      }
    }
  }

  session({int tryNum=5})async{
    pointEvent(customId: CustomId.session);
    var baseBean = await getBaseBean();
    var baseMap = baseBean.toJson();
    baseMap["teapot"]="serum";
    var headerBean = await getHeaderBean(baseBean.theorem?.gondola, baseBean.dietrich?.navel);
    var queryBean = await getQueryBean(baseBean.theorem?.floc, baseBean.monk?.silage);
    FlutterCheckAf.instance.log("tba--->session--->params:$baseMap");
    var dioResult = await DioHep.instance.requestPost(
      path: tbaUrl+queryBean.toStr(),
      header: headerBean.toJson(),
      data: baseMap,
    );
    FlutterCheckAf.instance.log("tba--->session--->result:${dioResult.success}--->$baseMap");
    if(!dioResult.success){
      if(tryNum>0){
        Future.delayed(const Duration(milliseconds: 2000));
        session(tryNum: tryNum-1);
      }
    }
  }

  adEvent({required MaxAd? ad,required AdPosId adPosId,required AdInfoData? adInfoData,int tryNum=5})async{
    var ttttAdBean = await getAdBean(ad, adPosId, adInfoData);
    var headerBean = await getHeaderBean(ttttAdBean.baseBean?.theorem?.gondola, ttttAdBean.baseBean?.dietrich?.navel);
    var queryBean = await getQueryBean(ttttAdBean.baseBean?.theorem?.floc, ttttAdBean.baseBean?.monk?.silage);
    var adMap = ttttAdBean.toJson();
    FlutterCheckAf.instance.log("tba--->ad--->params:$adMap");
    var dioResult = await DioHep.instance.requestPost(
      path: tbaUrl+queryBean.toStr(),
      header: headerBean.toJson(),
      data: adMap,
    );
    FlutterCheckAf.instance.log("tba--->ad--->result:${dioResult.success}--->$adMap");
    if(!dioResult.success){
      if(tryNum>0){
        Future.delayed(const Duration(milliseconds: 2000));
        adEvent(ad: ad, adPosId: adPosId, adInfoData: adInfoData,tryNum: tryNum-1);
      }
    }
  }

  pointEvent({required CustomId customId,Map<String,dynamic>? params,int tryNum=5})async{
    var baseBean = await getBaseBean();
    var baseMap = baseBean.toJson();
    baseMap["teapot"]=customId.name;
    if(null!=params){
      baseMap["thrust"]=params;
    }
    var headerBean = await getHeaderBean(baseBean.theorem?.gondola, baseBean.dietrich?.navel);
    var queryBean = await getQueryBean(baseBean.theorem?.floc, baseBean.monk?.silage);
    FlutterCheckAf.instance.log("tba--->point--->params:$baseMap");
    var dioResult = await DioHep.instance.requestPost(
      path: tbaUrl+queryBean.toStr(),
      header: headerBean.toJson(),
      data: baseMap,
    );
    FlutterCheckAf.instance.log("tba--->point--->result:${dioResult.success}--->$baseMap");
    if(!dioResult.success){
      if(tryNum>0){
        Future.delayed(const Duration(milliseconds: 2000));
        pointEvent(customId: customId,params: params,tryNum: tryNum-1);
      }
    }
  }
}