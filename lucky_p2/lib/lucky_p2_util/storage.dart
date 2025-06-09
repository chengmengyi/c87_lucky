import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_steps.dart';


class StorageName{
  static const p2UserCoins="p2UserCoins";
  static const p2UserPlayNum="p2UserPlayNum";
  static const p2UserGuideStep="p2UserGuideStep";
  static const p2OldUserGuideTimer="p2OldUserGuideTimer";
  static const p2LastPlayType="p2LastPlayType";
  static const p2BoxPro="p2BoxPro";
  static const p2FirstBoxGuide="p2FirstBoxGuide";
  static const p2KeyNum="p2KeyNum";
  static const p2FirstGetCoins="p2FirstGetCoins";
  static const p2ShowComment="p2LoadAppShowComment";
  static const p2CashRankWatchAdNum="p2CashRankWatchAdNum";
  static const p2LastCoinsLevel="p2LastCoinsLevel";
}


StorageData<double> p2UserCoins=StorageData<double>(key: StorageName.p2UserCoins, defaultValue: 0.0);
StorageData<int> p2UserPlayNum=StorageData<int>(key: StorageName.p2UserPlayNum, defaultValue: 0);
StorageData<int> p2BoxPro=StorageData<int>(key: StorageName.p2BoxPro, defaultValue: 0);
StorageData<int> p2KeyNum=StorageData<int>(key: StorageName.p2KeyNum, defaultValue: 0);
StorageData<int> p2CashRankWatchAdNum=StorageData<int>(key: StorageName.p2CashRankWatchAdNum, defaultValue: 0);
StorageData<int> p2LastCoinsLevel=StorageData<int>(key: StorageName.p2LastCoinsLevel, defaultValue: 0);


StorageData<String> p2UserGuideStep=StorageData<String>(key: StorageName.p2UserGuideStep, defaultValue: UserGuideSteps.firstPlayGuide);
StorageData<String> p2OldUserGuideTimer=StorageData<String>(key: StorageName.p2OldUserGuideTimer, defaultValue: "");
StorageData<String> p2LastPlayType=StorageData<String>(key: StorageName.p2LastPlayType, defaultValue: "");

StorageData<bool> p2FirstBoxGuide=StorageData<bool>(key: StorageName.p2LastPlayType, defaultValue: true);
StorageData<bool> p2FirstGetCoins=StorageData<bool>(key: StorageName.p2FirstGetCoins, defaultValue: true);
StorageData<bool> p2ShowComment=StorageData<bool>(key: StorageName.p2ShowComment, defaultValue: true);
