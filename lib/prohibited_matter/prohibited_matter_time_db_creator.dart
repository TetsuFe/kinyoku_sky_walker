import 'package:kinyoku_continue/db_table_creator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class ProhibitedMatterTimeDBTableCreator extends DBTableCreator {
  @override
  Future<void> create(Database db, int version) async {
    return db.execute('CREATE TABLE IF NOT EXISTS prohibited_matter_time ('
        'id INTEGER PRIMARY KEY,'
        'hours INTEGER,'
        'minutes INTEGER,'
        'date TEXT'
        ')');
  }
}
