import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lucky_base/lucky_dialog/open_notification_dialog/open_notification_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationNotificationUtils{
  static final LocationNotificationUtils _instance = LocationNotificationUtils();
  static LocationNotificationUtils get instance => _instance;

  static const int dingshi1=1;
  static const int dingshi2=2;
  static const int dingshi3=3;
  static const int dingshi4=4;
  static const int dingshi5=5;
  static const int dingshi6=6;
  static const int lockScreen=7;

  AndroidFlutterLocalNotificationsPlugin plugin=AndroidFlutterLocalNotificationsPlugin();

  final List<NotificationInfo> _notificationList=[
    NotificationInfo(title: "You’ve WON real cash!", body: "Your scratch card revealed \$72.50. Tap to withdraw now!"),
    NotificationInfo(title: "Real payout unlocked 💵", body: "You’re eligible to cash out. Don’t miss your reward!"),
    NotificationInfo(title: "You just hit a cash prize!", body: "Withdraw your winnings before they expire!"),
    NotificationInfo(title: "Daily Cash Scratch is live!", body: "Scratch today’s card and win real rewards instantly."),
    NotificationInfo(title: "It’s cash o’clock!", body: "Today’s scratch bonus is waiting for you—don’t miss it!"),
    NotificationInfo(title: "Special Offer: First scratch = GUARANTEED prize!", body: "Start now and unlock instant cash."),
  ];

  init({bool showOpenNotificationDialog=true})async{
    var status = await Permission.notification.request();
    if(status.isGranted){
      var success = await plugin.initialize(
        AndroidInitializationSettings("logo"),
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          _clickNotification(response.payload);
        },
      );
      if(success==true){
        for(var index=0;index<_notificationList.length;index++){
          var info = _notificationList[index];
          _show(index+1, info.title, info.body, Duration(hours: 1));
        }
        _showLockScreenNotification();
        _initFcm();
      }
    }else{
      if(showOpenNotificationDialog){
        LuckyRouters.instance.showDialog(child: OpenNotificationDialog());
      }
    }
  }

  _show(id,title,body,Duration duration)async{
    AndroidNotificationDetails details = AndroidNotificationDetails(
      'scratch_channel',
      'scratch_channel_name',
      styleInformation: BeautyStyleInformation(
        title,
        body,
        'pic',
        'Go Earn',
        'logo',
      ),
      priority: Priority.high,
      importance: Importance.high,
      groupKey: "$id",
    );
    await plugin.periodicallyShowWithDuration(
      id,
      title,
      body,
      kDebugMode?Duration(minutes: 1):duration,
      notificationDetails: details,
      scheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: "local"
    );
  }

  _showLockScreenNotification()async{
    NotificationInfo random = _notificationList.random();
    await plugin.showBroadcastNotification(
      lockScreen,
      random.title,
      random.body,
      //两次发送解锁通知的间隔，根据需求设置
      Duration(seconds: 5),
      'android.intent.action.USER_PRESENT',
      AndroidNotificationDetails(
        'scratch_channel_lock',
        'scratch_channel_name_lock',
        priority: Priority.high,
        importance: Importance.high,
        styleInformation: BeautyStyleInformation(
          random.title,
          random.body,
          'pic',
          'Go Earn',
          'logo',
        ),
        groupKey: "$lockScreen",
      ),
      'unlock',
    );
  }

  _initFcm()async{
    var result = await plugin.subscribeToTopic(
      'c87fcm_card',
      const AndroidNotificationDetails(
        'scratch_channel_fcm',
        'scratch_channel_name_fcm',
        styleInformation: BeautyStyleInformation(
          '',
          '',
          '',
          'Go Earn',
          'logo',
        ),
        priority: Priority.high,
        importance: Importance.high,
      ),
    );
  }

  _clickNotification(String? from){
    TTTTUtils.instance.pointEvent(customId: CustomId.inform_c,params: {"infrom_from":from});
  }
  
  checkClickByLaunchApp()async{
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      var id = launchDetails?.notificationResponse?.payload;
      _clickNotification(id);
    }
  }
  
  checkOpenApp()async{
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    TTTTUtils.instance.pointEvent(customId: CustomId.launch_page,params: {"source_from":launchDetails?.didNotificationLaunchApp==true?"push":"icon"});
  }

  checkNotificationNum()async{
    var localNum = await plugin.extractMessageReceivedNum("local");
    if(localNum>0){
      TTTTUtils.instance.pointEvent(customId: CustomId.inform_p,params: {"type":"local","num":localNum});
    }
    var unlockNum = await plugin.extractMessageReceivedNum("unlock");
    if(unlockNum>0){
      TTTTUtils.instance.pointEvent(customId: CustomId.inform_p,params: {"type":"unlock","num":unlockNum});
    }
    var fcmNum = await plugin.extractMessageReceivedNum("fcm");
    if(fcmNum>0){
      TTTTUtils.instance.pointEvent(customId: CustomId.inform_p,params: {"type":"fcm","num":fcmNum});
    }
  }
}


class NotificationInfo{
  String title;
  String body;
  NotificationInfo({
    required this.title,
    required this.body,
});
}