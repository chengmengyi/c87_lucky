import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_sql/lucky_base_sql.dart';
import 'package:lucky_base/lucky_utils/lucky_sql/lucky_sql_name.dart';
import 'package:lucky_p1/lucky_p1_bean/play_info_bean.dart';

enum PlayType{
  card1,card2,card3,card4,card5,card6,card7,card8,card9,
}

enum UnlockType{
  video,coins,
}

class PlayInfoUtils extends LuckyBaseSql{
  static final PlayInfoUtils _instance = PlayInfoUtils();
  static PlayInfoUtils get instance => _instance;

  initPlayList()async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p1PlayTime);
    if(list.isEmpty){
      var initList=[
        PlayInfoBean(type: PlayType.card1.name,playedNum: 0,unlock: 1,time: 0,watchVideoNum: 3),
        PlayInfoBean(type: PlayType.card2.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card3.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card4.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card5.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card6.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card7.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card8.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
        PlayInfoBean(type: PlayType.card9.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      ];
      for (var value in initList) {
        await sql.insert(LuckySqlName.p1PlayTime, value.toJson());
      }
    }
  }

  Future<List<PlayInfoBean>> queryPlayList()async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p1PlayTime);
    if(list.isEmpty){
      // var initList=[
      //   PlayInfoBean(type: PlayType.card1.name,playedNum: 0,unlock: 1,time: 0,watchVideoNum: 3),
      //   PlayInfoBean(type: PlayType.card2.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card3.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card4.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card5.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card6.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card7.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card8.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      //   PlayInfoBean(type: PlayType.card9.name,playedNum: 0,unlock: 0,time: 0,watchVideoNum: 0),
      // ];
      // for (var value in initList) {
      //   sql.insert(LuckySqlName.p1PlayTime, value.toJson());
      // }
      // return initList;
      return [];
    }
    List<PlayInfoBean> resultList=[];
    for (var value in list) {
      resultList.add(PlayInfoBean.fromJson(value));
    }
    return resultList;
  }

  Future<bool> updatePlayInfo(PlayType playType)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p1PlayTime,where: '"type" = ?',whereArgs: [playType.name]);
    if(list.isEmpty){
      return false;
    }
    var map = list.first;
    var playInfoBean = PlayInfoBean.fromJson(map);
    playInfoBean.playedNum=(playInfoBean.playedNum??0)+1;
    if((playInfoBean.playedNum??0)>=10){
      playInfoBean.time=DateTime.now().millisecondsSinceEpoch+10*60*60*1000;
      // var nextPlayType = getNextPlayType(playType);
      // if(null!=nextPlayType){
      //   unlockPlayType(nextPlayType);
      // }
    }
    await sql.update(LuckySqlName.p1PlayTime, playInfoBean.toJson(),where: '"id" = ?',whereArgs: [map["id"]]);
    LuckyEvent(luckyCode: P1LuckyEventCode.updateHomeList);
    return (playInfoBean.playedNum??0)>=10;
  }

  Future<int> unlockPlayType(PlayType playType,UnlockType unlockType)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p1PlayTime,where: '"type" = ? AND "unlock" = ?',whereArgs: [playType.name,0]);
    if(list.isEmpty){
      return 0;
    }
    var map = list.first;
    var playInfoBean = PlayInfoBean.fromJson(map);
    if(unlockType==UnlockType.coins){
      playInfoBean.unlock=1;
    }else if(unlockType==UnlockType.video){
      playInfoBean.watchVideoNum=(playInfoBean.watchVideoNum??0)+1;
      if((playInfoBean.watchVideoNum??0)>=3){
        playInfoBean.unlock=1;
      }
    }
    await sql.update(LuckySqlName.p1PlayTime, playInfoBean.toJson(),where: '"id" = ?',whereArgs: [map["id"]]);
    LuckyEvent(luckyCode: P1LuckyEventCode.updateHomeList);
    return playInfoBean.watchVideoNum??0;
  }

  resetPlayTime()async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p1PlayTime,where: '"time" > 0');
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var infoBean = PlayInfoBean.fromJson(value);
      infoBean.playedNum=0;
      infoBean.time=0;
      await sql.update(LuckySqlName.p1PlayTime, infoBean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
  }

  PlayType? getNextPlayType(PlayType currentPlayType){
    switch(currentPlayType){
      case PlayType.card1: return PlayType.card2;
      case PlayType.card2: return PlayType.card3;
      case PlayType.card3: return PlayType.card4;
      case PlayType.card4: return PlayType.card5;
      case PlayType.card5: return PlayType.card6;
      case PlayType.card6: return PlayType.card7;
      case PlayType.card7: return PlayType.card8;
      case PlayType.card8: return PlayType.card9;
      default: return null;
    }
  }
}