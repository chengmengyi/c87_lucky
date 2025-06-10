import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_widget/key_widget.dart';

class KeyAnimatorWidget extends LuckyBaseStateful{
  @override
  State<StatefulWidget> createState() => KeyAnimatorWidgetState();
}

class KeyAnimatorWidgetState extends LuckyBaseState<KeyAnimatorWidget> with TickerProviderStateMixin{
  var showKey=false;
  Animation<Offset>? keyAnimation;
  late AnimationController _animationController;
  late BuildContext ctx;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget build(BuildContext context) {
    ctx=context;
    if(!showKey){
      return Container();
    }
    var value = keyAnimation?.value;
    var dx = value?.dx??0;
    var dy = value?.dy??0;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: dx<=0?0:dx,top: dy<=0?0:dy),
          child: Stack(
            alignment: Alignment.bottomRight,
            key: GlobalKey(),
            children: [
              LuckyImageWidget(name: "icon_key",width: 55.w,height: 55.h,),
              LuckyTextWidget(text: "x1", size: 10.sp, color: "#FFFFFF",shadowsColor: "#000000",fontWeight: FontWeight.bold,).marginOnly(right: 10.w,bottom: 10.h)
            ],
          ),
        )
      ],
    );
  }

  _initAnimator(){
    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1300))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          setState(() {
            showKey=false;
          });
        }
      });
  }

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.startKeyAnimator:
        _startKeyAnimator(luckyEvent.dynamicValue as Offset);
        break;
    }
  }

  _startKeyAnimator(Offset startOffset){
    keyAnimation=Tween<Offset>(
      begin: startOffset,
      end: Offset(0, MediaQuery.of(ctx).size.height-80.h,)
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut));
    setState(() {
      showKey=true;
    });
    _animationController..reset()..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}