import 'package:lucky_base/lucky_utils/lucky_event/lucky_event.dart';
import 'package:lucky_base/lucky_utils/lucky_event/lucky_event_code.dart';
import 'package:lucky_base/lucky_utils/lucky_sql/lucky_base_sql.dart';
import 'package:lucky_base/lucky_utils/lucky_sql/lucky_sql_name.dart';
import 'package:lucky_p2/lucky_p2_bean/play_info_bean.dart';

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
    var list = await sql.query(LuckySqlName.p2PlayTime);
    if(list.isEmpty){
      var initList=[
        PlayInfoBean(type: PlayType.card1.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card2.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card3.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card4.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card5.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card6.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card7.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card8.name,hasNum: 10,playedNum: 0,secondsNum: 0),
        PlayInfoBean(type: PlayType.card9.name,hasNum: 10,playedNum: 0,secondsNum: 0),
      ];
      for (var value in initList) {
        await sql.insert(LuckySqlName.p2PlayTime, value.toJson());
      }
    }
  }

  Future<List<PlayInfoBean>> queryPlayList()async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2PlayTime);
    if(list.isEmpty){
      return [];
    }
    List<PlayInfoBean> resultList=[];
    for (var value in list) {
      resultList.add(PlayInfoBean.fromJson(value));
    }
    return resultList;
  }

  Future<bool> checkHasPlayNum(PlayType playType)async{
    var sql = await initSql();
    var list = await sql.query(LuckySqlName.p2PlayTime,where: '"type" = ?',whereArgs: [playType.name]);
    if(list.isEmpty){
      return false;
    }
    var map = list.first;
    var playInfoBean = PlayInfoBean.fromJson(map);
    playInfoBean.playedNum=(playInfoBean.playedNum??0)+1;
    playInfoBean.hasNum=(playInfoBean.hasNum??0)-1;
    if((playInfoBean.hasNum??0)<0){
      playInfoBean.hasNum=0;
    }
    await sql.update(LuckySqlName.p2PlayTime, playInfoBean.toJson(),where: '"id" = ?',whereArgs: [map["id"]]);
    LuckyEvent(luckyCode: P2LuckyEventCode.updateHomeList,boolValue: (playInfoBean.hasNum??0)<=0);
    return (playInfoBean.hasNum??0)>0;
  }

  Future<void> savePlayInfo(PlayInfoBean bean)async{
    var db = await initSql();
    var list = await db.query(LuckySqlName.p2PlayTime,where: '"type" = ? ', whereArgs: [bean.type]);
    if(list.isEmpty){
      return;
    }
    await db.update(LuckySqlName.p2PlayTime, bean.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
  }

  Future<void> addPlayNum(String playType,{int addNum=1})async{
    var db = await initSql();
    var list = await db.query(LuckySqlName.p2PlayTime,where: '"type" = ? ', whereArgs: [playType]);
    if(list.isEmpty){
      return;
    }
    var map = list.first;
    var id = map["id"];
    var hasNum = map["hasNum"] as int;
    var newMap = Map<String, Object?>.from(map);
    if(hasNum<10){
      newMap["hasNum"]=hasNum+addNum;
      newMap["secondsNum"]=0;
    }
    await db.update(LuckySqlName.p2PlayTime, newMap,where: '"id" = ?',whereArgs: [id]);
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