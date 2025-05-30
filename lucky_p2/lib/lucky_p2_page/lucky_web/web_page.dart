import 'package:flutter/material.dart';
import 'package:lucky_base/lucky_base/lucky_base_page.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_widget/click_widget.dart';
import 'package:lucky_base/lucky_widget/lucky_image_widget.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_web/web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends LuckyBasePage<WebController>{
  @override
  String bgName() => "home1";

  @override
  WebController initController() => WebController();

  @override
  Widget child() => Column(
    children: [
      Row(
        children: [
          SizedBox(width: 14.w,),
          ClickWidget(
            onTap: (){
              LuckyRouters.instance.back();
            },
            child: LuckyImageWidget(name: "icon_home",width: 34.w,height: 34.w,),
          ),
        ],
      ),
      SizedBox(height: 12.h,),
      Expanded(
        child: WebViewWidget(
          controller: luckyController.webViewController,
        ),
      )
    ],
  );
}