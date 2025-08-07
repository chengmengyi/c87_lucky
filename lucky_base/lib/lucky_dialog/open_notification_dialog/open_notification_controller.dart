import 'package:app_settings/app_settings.dart';
import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/app_lifecycle_utils.dart';

class OpenNotificationController extends LuckyBaseController{

  clickClose(){
    LuckyRouters.instance.back();
  }

  clickOpen(){
    AppLifecycleUtils.instance.isToOpenNotification=true;
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }
}