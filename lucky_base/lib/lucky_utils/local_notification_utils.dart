import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lucky_base/lucky_utils/ad_utils/custom_id.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';

class LocationNotificationUtils{
  static final LocationNotificationUtils _instance = LocationNotificationUtils();
  static LocationNotificationUtils get instance => _instance;

  var plugin=FlutterLocalNotificationsPlugin();

  final int gudingId=10;
  final int qiandaoId=11;
  final int guakaId=12;
  final int tixianId=13;

  init()async{
    var success = await plugin.initialize(
      InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            _click(notificationResponse.id);
            break;
          case NotificationResponseType.selectedNotificationAction:
            _click(notificationResponse.id);
            break;
        }
      },
    );
    if(success==true){
      TTTTUtils.instance.pointEvent(customId: CustomId.push_status);
      _show(
        gudingId,
        "Scratch to Earn",
        ["💰Scratch. Win. Cash Out - Your Ticket to Instant Payouts","🎁Turn Virtual Cards Into Real Cash","🔥Uncover Instant Rewards with Scratch it Lucky"].random(),
        Duration(minutes: 30),
      );

      _show(
        qiandaoId,
        "Cash in check daily",
        "Scratch your way to real cash prizes with Scratch it Lucky!",
        Duration(minutes: 60),
      );

      _show(
        guakaId,
        "Go Scratch , Big Win!",
        ["💰Earn money on the go with Scratch it Lucky's instant payouts.","🎁Reveal hidden rewards and get paid out instantly."].random(),
        Duration(minutes: 60),
      );

      _show(
        tixianId,
        "Pending withdraw amount",
        "\$500 has arrived in your account",
        Duration(minutes: 30),
      );
    }
    checkClickByLaunchApp();
  }

  _show(id,title,body,repeatDurationInterval,){
    plugin.periodicallyShowWithDuration(
      id,
      title,
      body,
      repeatDurationInterval,
      NotificationDetails(),
    );
  }

  _click(int? id){
    var from="";
    if(id==tixianId){
      from="cash";
      LuckyEvent(luckyCode: P2LuckyEventCode.showHomeTab,intValue: 2);
    }
    if(id==gudingId){
      from="fix";
    }
    if(id==qiandaoId){
      from="sign";
    }
    if(id==guakaId){
      from="card";
    }
    TTTTUtils.instance.pointEvent(customId: CustomId.inform_c,params: {"infrom_from":from});
  }
  
  checkClickByLaunchApp()async{
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    if(launchDetails?.didNotificationLaunchApp==true){
      var id = launchDetails?.notificationResponse?.id;
      _click(id);
    }
  }
  
  checkOpenApp()async{
    var launchDetails = await plugin.getNotificationAppLaunchDetails();
    TTTTUtils.instance.pointEvent(customId: CustomId.launch_page,params: {"source_from":launchDetails?.didNotificationLaunchApp==true?"push":"icon"});
  }
}