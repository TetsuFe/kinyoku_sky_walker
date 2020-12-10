import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

part 'reset_date.freezed.dart';
part 'reset_date.g.dart';

class ResetDateConverter
    implements JsonConverter<ResetDate, Map<String, dynamic>> {
  const ResetDateConverter();

  @override
  ResetDate fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return _$_ResetDate(
      userId: json['userId'] as String,
      resetDate: json['resetDate'].toDate() as DateTime,
    );
  }

  @override
  Map<String, dynamic> toJson(ResetDate data) => data.toJson();
}

@freezed
abstract class ResetDate implements _$ResetDate {
  factory ResetDate({
    @required String userId,
    @required DateTime resetDate,
  }) = _ResetDate;

  const ResetDate._();

  factory ResetDate.fromJson(Map<String, dynamic> json) =>
      resetDateConverter.fromJson(json);

  Map<String, dynamic> toDateJson() =>
      {'userId': userId, 'resetDate': resetDate};

  static const resetDateConverter = ResetDateConverter();
}
