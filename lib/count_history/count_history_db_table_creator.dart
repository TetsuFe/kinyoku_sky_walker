import 'package:kinyoku_continue/db_table_creator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class CountHistoryDBTableCreator extends DBTableCreator {
  @override
  Future<void> create(Database db, int version) async {
    return db.execute('CREATE TABLE IF NOT EXISTS count_history ('
        'id INTEGER PRIMARY KEY,'
        'days INTEGER,'
        'hours INTEGER,'
        'minutes INTEGER,'
        'seconds INTEGER,'
        'date TEXT'
        ')');
  }
}
