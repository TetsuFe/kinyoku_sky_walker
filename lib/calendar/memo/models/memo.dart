import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

@freezed
abstract class Memo with _$Memo {
  factory Memo({
    @required String body,
    @required DateTime calendarDate,
  }) = _Memo;
  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}
