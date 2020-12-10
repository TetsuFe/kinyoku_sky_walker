import 'package:kinyoku_continue/count_history/count_history_db_table_creator.dart';
import 'package:kinyoku_continue/prohibited_matter/prohibited_matter_time_db_creator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  final _dbInitializer = DBInitializer();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      return _database = await _dbInitializer.initDB();
    }
  }
}

class DBInitializer {
  Future<Database> initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'kinyoku_continue.db');
    const version = 1;
    final db = await openDatabase(path, version: version);
    CountHistoryDBTableCreator().create(db, version);
    ProhibitedMatterTimeDBTableCreator().create(db, version);
    return db;
  }
}
