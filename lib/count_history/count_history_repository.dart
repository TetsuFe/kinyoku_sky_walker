import 'package:kinyoku_continue/count_history/count_history.dart';
import 'package:kinyoku_continue/db_provider.dart';
import 'package:meta/meta.dart';

class CountHistoryRepository {
  static const _tableName = 'count_history';

  final DBProvider dbProvider = DBProvider.db;

  Future<int> create(CountHistory countHistory) async {
    final db = await dbProvider.database;
    final res = await db.insert(_tableName, countHistory.toJsonWithoutId());
    return res;
  }

  Future<List<CountHistory>> getAll() async {
    final db = await dbProvider.database;
    final res = await db.rawQuery('select * from $_tableName where id != 1;');
    if (res.isEmpty) {
      return [];
    } else {
      return res.map((c) => CountHistory.fromJson(c)).toList();
    }
  }

  Future<List<CountHistory>> getLongestTop5() async {
    final db = await dbProvider.database;
    final res = await db.rawQuery('select * from $_tableName where id != 1 '
        'order by days desc, minutes desc, hours desc limit 5;');
    if (res.isEmpty) {
      return [];
    } else {
      return res.map((c) => CountHistory.fromJson(c)).toList();
    }
  }

  Future<int> update(CountHistory countHistory) async {
    final db = await dbProvider.database;
    final res = await db.update(_tableName, countHistory.toJsonWithoutId(),
        where: 'id = ?', whereArgs: [countHistory.id]);
    return res;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final res = db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  /// 継続日数と時間を合わせた平均を出す
  /// 返り値（平均）の単位は時間（95時間）
  Future<CountAverage> averageCount() async {
    final db = await dbProvider.database;
    final countResult = await db.rawQuery('select count(*) from $_tableName;');
    if (countResult[0]['count(*)'] == 0 || countResult[0]['count(*)'] == 1) {
      return CountAverage(days: 0, hours: 0, minutes: 0);
    }
    final averageDaysResult =
        await db.rawQuery('select avg(days) from $_tableName where id != 1;');
    final averageHoursResult =
        await db.rawQuery('select avg(hours) from $_tableName where id != 1;');
    final averageMinutesResult = await db
        .rawQuery('select avg(minutes) from $_tableName where id != 1;');
    final averageDays = averageDaysResult[0]['avg(days)'] as double; // e.g 4.5
    final averageDaysFloored = averageDays.floor(); // e.g 4
    final averageDaysUnderZero = averageDays - averageDaysFloored; // e.g 0.5
    final averageDaysUnderZeroAsHours =
        (averageDaysUnderZero * 24).toInt(); // 0.5 x 24 toInt = 12 hours
    final averageHours = (averageHoursResult[0]['avg(hours)'] as double) +
        averageDaysUnderZeroAsHours;
    final averageHoursFloored = averageHours.floor(); // e.g 4
    final averageHoursUnderZero = averageHours - averageHoursFloored; // e.g 0.5
    final averageHoursUnderZeroAsMinutes =
        (averageHoursUnderZero * 60).toInt(); // 0.5 x 24 toInt = 12 hours
    final averageMinutes =
        ((averageMinutesResult[0]['avg(minutes)'] as double).floor() +
                averageHoursUnderZeroAsMinutes)
            .toInt();
    // 繰り上がり計算
    final ad = averageDaysFloored + averageHoursFloored ~/ 24;
    final ah = averageHoursFloored + averageMinutes ~/ 60 > 24
        ? averageHoursFloored + averageMinutes ~/ 60 % 24
        : averageHoursFloored + averageMinutes ~/ 60;
    final am = averageMinutes >= 60 ? averageMinutes % 60 : averageMinutes;
    return CountAverage(days: ad, hours: ah, minutes: am);
  }
}

class CountAverage {
  CountAverage(
      {@required this.days, @required this.hours, @required this.minutes});
  int days;
  int hours;
  int minutes;
}
