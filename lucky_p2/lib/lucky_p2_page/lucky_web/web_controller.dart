import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebController extends LuckyBaseController{
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController=WebViewController();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.loadRequest(Uri.parse(LuckyRouters.instance.getArguments()["url"]));
  }
}