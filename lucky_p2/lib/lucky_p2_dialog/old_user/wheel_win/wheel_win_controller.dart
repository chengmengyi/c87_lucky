import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/ad_pos_id.dart';
import 'package:lucky_base/lucky_utils/ad_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class WheelWinController extends LuckyBaseController{
  clickDouble(double allReward,Function(double addNum) dismiss){
    LuckyRouters.instance.back();
    dismiss.call(mulTwoNums(allReward, 2));
  }

  clickSingle(double allReward,Function(double addNum) dismiss){
    LuckyRouters.instance.back();
    dismiss.call(allReward);
  }
}