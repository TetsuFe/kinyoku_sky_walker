// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'reset_date.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ResetDate _$ResetDateFromJson(Map<String, dynamic> json) {
  return _ResetDate.fromJson(json);
}

class _$ResetDateTearOff {
  const _$ResetDateTearOff();

// ignore: unused_element
  _ResetDate call({@required String userId, @required DateTime resetDate}) {
    return _ResetDate(
      userId: userId,
      resetDate: resetDate,
    );
  }
}

// ignore: unused_element
const $ResetDate = _$ResetDateTearOff();

mixin _$ResetDate {
  String get userId;
  DateTime get resetDate;

  Map<String, dynamic> toJson();
  $ResetDateCopyWith<ResetDate> get copyWith;
}

abstract class $ResetDateCopyWith<$Res> {
  factory $ResetDateCopyWith(ResetDate value, $Res Function(ResetDate) then) =
      _$ResetDateCopyWithImpl<$Res>;
  $Res call({String userId, DateTime resetDate});
}

class _$ResetDateCopyWithImpl<$Res> implements $ResetDateCopyWith<$Res> {
  _$ResetDateCopyWithImpl(this._value, this._then);

  final ResetDate _value;
  // ignore: unused_field
  final $Res Function(ResetDate) _then;

  @override
  $Res call({
    Object userId = freezed,
    Object resetDate = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed ? _value.userId : userId as String,
      resetDate:
          resetDate == freezed ? _value.resetDate : resetDate as DateTime,
    ));
  }
}

abstract class _$ResetDateCopyWith<$Res> implements $ResetDateCopyWith<$Res> {
  factory _$ResetDateCopyWith(
          _ResetDate value, $Res Function(_ResetDate) then) =
      __$ResetDateCopyWithImpl<$Res>;
  @override
  $Res call({String userId, DateTime resetDate});
}

class __$ResetDateCopyWithImpl<$Res> extends _$ResetDateCopyWithImpl<$Res>
    implements _$ResetDateCopyWith<$Res> {
  __$ResetDateCopyWithImpl(_ResetDate _value, $Res Function(_ResetDate) _then)
      : super(_value, (v) => _then(v as _ResetDate));

  @override
  _ResetDate get _value => super._value as _ResetDate;

  @override
  $Res call({
    Object userId = freezed,
    Object resetDate = freezed,
  }) {
    return _then(_ResetDate(
      userId: userId == freezed ? _value.userId : userId as String,
      resetDate:
          resetDate == freezed ? _value.resetDate : resetDate as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_ResetDate extends _ResetDate {
  _$_ResetDate({@required this.userId, @required this.resetDate})
      : assert(userId != null),
        assert(resetDate != null),
        super._();

  factory _$_ResetDate.fromJson(Map<String, dynamic> json) =>
      _$_$_ResetDateFromJson(json);

  @override
  final String userId;
  @override
  final DateTime resetDate;

  @override
  String toString() {
    return 'ResetDate(userId: $userId, resetDate: $resetDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ResetDate &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.resetDate, resetDate) ||
                const DeepCollectionEquality()
                    .equals(other.resetDate, resetDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(resetDate);

  @override
  _$ResetDateCopyWith<_ResetDate> get copyWith =>
      __$ResetDateCopyWithImpl<_ResetDate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ResetDateToJson(this);
  }
}

abstract class _ResetDate extends ResetDate {
  _ResetDate._() : super._();
  factory _ResetDate({@required String userId, @required DateTime resetDate}) =
      _$_ResetDate;

  factory _ResetDate.fromJson(Map<String, dynamic> json) =
      _$_ResetDate.fromJson;

  @override
  String get userId;
  @override
  DateTime get resetDate;
  @override
  _$ResetDateCopyWith<_ResetDate> get copyWith;
}
