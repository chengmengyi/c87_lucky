import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_stateful.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_text_widget.dart';
import 'package:lucky_p2/lucky_p2_util/storage.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/box_guide_overlay.dart';
import 'package:lucky_p2/lucky_p2_util/user_guide/user_guide_utils.dart';
import 'package:lucky_p2/lucky_p2_widget/finger_widget.dart';

class BoxWidget extends LuckyBaseStateful{
  @override
  State<StatefulWidget> createState() => BoxWidgetState();
}

class BoxWidgetState extends LuckyBaseState<BoxWidget>{
  var showFinger=false;
  GlobalKey globalKey=GlobalKey();
  @override
  void initState() {
    super.initState();
    Future((){
      _checkBoxProgress();
    });
  }

  @override
  Widget build(BuildContext context) => Positioned(
    top: 130.h,
    right: 20.w,
    child: ClickWidget(
      onTap: (){
        _clickBox();
      },
      child: SizedBox(
        width: 60.w,
        height: 51.h,
        key: globalKey,
        child: Stack(
          children: [
            LuckyImageWidget(name: "box",width: 60.w,height: 51.h,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 60.w,
                    height: 16.h,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 3.w,right: 3.w),
                    decoration: BoxDecoration(
                      color: "#001A03".toColor(),
                      borderRadius: BorderRadius.circular(33.w),
                    ),
                    child: Container(
                      width: (54.w)*getPro(p2BoxPro.getData(), 5),
                      height: 10.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33.w),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: ["#03FF20".toColor(),"#008702".toColor(),]
                          )
                      ),
                    ),
                  ),
                  LuckyTextWidget(text: "${p2BoxPro.getData()}/5", size: 8.sp, color: "#FFFFFF",fontWeight: FontWeight.bold,shadowsColor: "#000E00",)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              // child: Transform(
              //   alignment: Alignment.center,
              //   transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              //   child: FingerWidget(width: 30.w,height: 30.h,),
              // ),
              child: Visibility(
                visible: showFinger,
                child: FingerWidget(width: 40.w,height: 40.h,),
              ),
            )
          ],
        ),
      ),
    ),
  );

  @override
  bool initLuckyEvent() => true;

  @override
  receivedLuckyEventMsg(LuckyEvent luckyEvent) {
    switch(luckyEvent.luckyCode){
      case P2LuckyEventCode.updateBoxProgress:
        setState(() {});
        _checkBoxProgress();
        break;
    }
  }

  _clickBox(){
    if(p2BoxPro.getData()>=5){
      showFinger=false;
      p2BoxPro.saveData(0);
      setState(() {});

    }else{
      showToast("Continue to eliminate ${5-p2BoxPro.getData()} times to open the treasure box");
    }
  }

  _checkBoxProgress(){
    if(p2BoxPro.getData()<5){
      return;
    }
    if(p2FirstBoxGuide.getData()){
      p2FirstBoxGuide.saveData(false);
      var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
      var offset = renderBox.localToGlobal(Offset.zero);
      UserGuideUtils.instance.showOverlay(
        context: context,
        widget: BoxGuideOverlay(offset: offset, dismissCall: (){}),
      );
    }else{
      setState(() {
        showFinger=true;
      });
    }
  }
}