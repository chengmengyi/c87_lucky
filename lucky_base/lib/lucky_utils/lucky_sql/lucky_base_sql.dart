import 'package:lucky_base/lucky_utils/lucky_sql/lucky_sql_name.dart';
import 'package:sqflite/sqflite.dart';

class LuckyBaseSql{
  Future<Database> initSql() async => await openDatabase(
      "lucky.db",
      version: 1,
      onCreate: (db,version)async{
        db.execute('CREATE TABLE ${LuckySqlName.p1PlayTime} (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, playedNum INTEGER, unlock INTEGER, time INTEGER)');
      },
  );
}