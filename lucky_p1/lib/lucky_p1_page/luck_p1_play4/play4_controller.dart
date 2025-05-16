import 'dart:math';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_bean/your_bean.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart';
import 'package:lucky_p1/lucky_p1_util/play_utils.dart';
import 'package:lucky_p1/lucky_p1_util/value_utils.dart';

class Play4Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card4);

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