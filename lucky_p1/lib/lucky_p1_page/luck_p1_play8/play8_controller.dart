import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/play_utils.dart';
import 'package:lucky_p1/lucky_p1_util/value_utils.dart';

class Play8Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card8);

  @override
  void onReady() {
    super.onReady();
    playUtils.initPlay(this);
    _initYourList();
  }

  clickRevealAll(){
    playUtils.startAutoScratch(
      offsetCallback: (offset){

      }
    );
  }

  onThreshold(){
    playUtils.onThreshold(
      resetCallback: (){
        _initYourList();
      }
    );
  }

  _initYourList(){

    update(["your_widget"]);
  }

  @override
  void onClose() {
    playUtils.onClose();
    super.onClose();
  }
}