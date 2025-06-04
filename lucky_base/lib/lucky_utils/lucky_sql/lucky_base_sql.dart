import 'package:lucky_base/lucky_utils/lucky_sql/lucky_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class LuckyBaseSql{
  Future<Database> initSql() async => await openDatabase(
      "lucky.db",
      version: 2,
      onCreate: (db,version)async{
        db.execute('CREATE TABLE ${LuckySqlName.p1PlayTime} (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, playedNum INTEGER, unlock INTEGER, time INTEGER, watchVideoNum INTEGER)');
      },
      onUpgrade: (db,oldVersion,newVersion){
        if(newVersion==2){
          _createVersion2DB(db);
        }

      }
  );

  _createVersion2DB(Database db){
    db.execute('CREATE TABLE ${LuckySqlName.p2PlayTime} (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, playedNum INTEGER, hasNum INTEGER, secondsNum INTEGER)');
  }
}