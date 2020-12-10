import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinyoku_continue/db_provider.dart';
import 'package:kinyoku_continue/prohibited_matter/models/prohibited_matter_time.dart';
import 'package:meta/meta.dart';

class ProhibitedMatterTimeRepository {
  static const _tableName = 'prohibited_matter_time';

  final DBProvider dbProvider = DBProvider.db;

  Future<int> create(ProhibitedMatterTime prohibitedMatterTime) async {
    final db = await dbProvider.database;
    final res =
        await db.insert(_tableName, prohibitedMatterTime.toJsonWithoutId());
    return res;
  }

  Future<ProhibitedMatterTime> getFirstResetData() async {
    final db = await dbProvider.database;
    final res = await db.rawQuery('select * from $_tableName where id = 1;');
    if (res.isEmpty) {
      return null;
    } else {
      return res.map((c) => ProhibitedMatterTime.fromJson(c)).toList()[0];
    }
  }

  Future<List<ProhibitedMatterTime>> getAllWithoutFirst() async {
    final db = await dbProvider.database;
    final res = await db.rawQuery('select * from $_tableName where id != 1;');
    if (res.isEmpty) {
      return [];
    } else {
      return res.map((c) => ProhibitedMatterTime.fromJson(c)).toList();
    }
  }

  Future<List<ProhibitedMatterTime>> getAll() async {
    final db = await dbProvider.database;
    final res = await db.rawQuery('select * from $_tableName;');
    if (res.isEmpty) {
      return [];
    } else {
      return res.map((c) => ProhibitedMatterTime.fromJson(c)).toList();
    }
  }

  Future<int> update(ProhibitedMatterTime prohibitedMatterTime) async {
    final db = await dbProvider.database;
    final res = await db.update(
        _tableName, prohibitedMatterTime.toJsonWithoutId(),
        where: 'id = ?', whereArgs: [prohibitedMatterTime.id]);
    return res;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final res = db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  /// 継続日数と時間を合わせた平均を出す
  /// 返り値（平均）の単位は時間（95時間）
  Future<ProhibitedMatterTimeSum> sum() async {
    final db = await dbProvider.database;
    final countResult =
        await db.rawQuery('select count(*) from $_tableName where id != 1;');
    if (countResult[0]['count(*)'] == 0) {
      return ProhibitedMatterTimeSum(hours: 0, minutes: 0);
    }
    final sumHoursResult =
        await db.rawQuery('select sum(hours) from $_tableName where id != 1;');
    final sumMinutesResult = await db
        .rawQuery('select sum(minutes) from $_tableName where id != 1;');
    final sumMinutes = (sumMinutesResult[0]['sum(minutes)'] as int) % 60;
    final sumHours = (sumHoursResult[0]['sum(hours)'] as int) +
        ((sumMinutesResult[0]['sum(minutes)'] as int) / 60).floor();
    return ProhibitedMatterTimeSum(hours: sumHours, minutes: sumMinutes);
  }

  Future<ProhibitedMatterTimeSum> monthlySum(DateTime now) async {
    final nowMonthStartDate = DateTime(now.year, now.month, 1, 0, 0);
    final nowMonthEndDate =
        DateTime(now.year, now.month == 12 ? 1 : now.month + 1, 1, 0, 0);
    final db = await dbProvider.database;
    final resAll =
        await db.rawQuery('select * from $_tableName where id != 1;');
    final monthlyTimes = resAll
        .map((e) => ProhibitedMatterTime.fromJson(e))
        .where((element) =>
            element.date.isAfter(nowMonthStartDate) &&
            element.date.isBefore(nowMonthEndDate));
    final monthlyTimesSumMinutes = monthlyTimes
            .map((e) => e.minutes)
            .reduce((value, element) => value + element) %
        60;
    final monthlyTimesSumHours = monthlyTimes
            .map((e) => e.hours)
            .reduce((value, element) => value + element) +
        (monthlyTimes
                    .map((e) => e.minutes)
                    .reduce((value, element) => value + element) /
                60)
            .floor();
    return ProhibitedMatterTimeSum(
        hours: monthlyTimesSumHours, minutes: monthlyTimesSumMinutes);
  }
}

final prohibitedMatterTimeRepositoryProvider =
    Provider((ref) => ProhibitedMatterTimeRepository());

class ProhibitedMatterTimeSum {
  ProhibitedMatterTimeSum({@required this.hours, @required this.minutes});
  int hours;
  int minutes;
}
