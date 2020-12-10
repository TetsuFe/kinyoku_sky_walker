import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

// ignore: one_member_abstracts
abstract class DBTableCreator {
  Future<void> create(Database db, int version);
}
