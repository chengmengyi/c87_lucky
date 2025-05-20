import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/voice_play_utils.dart';

class LuckyAdUtils{
  static final LuckyAdUtils _instance = LuckyAdUtils();
  static LuckyAdUtils get instance => _instance;

  initAd(){
    FlutterIosAdHep.instance.initMax(
      maxKey: maxKey.base64(),
      data: ConfigAdData(
        maxShowNum: 1000,
        maxClickNum: 1000,
        oneRewardList: [AdInfoData(adId: "694dcb478476f5b1", adPlat: "max", adType: AdType.reward, expireTime: 100000, sort: 1,)],
        oneInterList: [],
        twoRewardList: [],
        twoInterList: [],
      ),
    );
  }

  showP1Ad({
    required Function() closeAd,
  }){
    var resultData = FlutterIosAdHep.instance.getCacheResultData(AdType.reward);
    if(null==resultData){
      showToast("Advertisement display failed, please try again later");
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: AdType.reward, 
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          VoicePlayUtils.instance.pauseBg();
        },
        showFail: (ad){
          showToast("Advertisement display failed, please try again later");
        }, 
        closeAd: (){
          VoicePlayUtils.instance.playBg();
          closeAd.call();
        }, 
        onAdRevenuePaidCallback: (ad,info){

        },
      ),
    );
  }
}