// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'memo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Memo _$MemoFromJson(Map<String, dynamic> json) {
  return _Memo.fromJson(json);
}

class _$MemoTearOff {
  const _$MemoTearOff();

// ignore: unused_element
  _Memo call({@required String body, @required DateTime calendarDate}) {
    return _Memo(
      body: body,
      calendarDate: calendarDate,
    );
  }
}

// ignore: unused_element
const $Memo = _$MemoTearOff();

mixin _$Memo {
  String get body;
  DateTime get calendarDate;

  Map<String, dynamic> toJson();
  $MemoCopyWith<Memo> get copyWith;
}

abstract class $MemoCopyWith<$Res> {
  factory $MemoCopyWith(Memo value, $Res Function(Memo) then) =
      _$MemoCopyWithImpl<$Res>;
  $Res call({String body, DateTime calendarDate});
}

class _$MemoCopyWithImpl<$Res> implements $MemoCopyWith<$Res> {
  _$MemoCopyWithImpl(this._value, this._then);

  final Memo _value;
  // ignore: unused_field
  final $Res Function(Memo) _then;

  @override
  $Res call({
    Object body = freezed,
    Object calendarDate = freezed,
  }) {
    return _then(_value.copyWith(
      body: body == freezed ? _value.body : body as String,
      calendarDate: calendarDate == freezed
          ? _value.calendarDate
          : calendarDate as DateTime,
    ));
  }
}

abstract class _$MemoCopyWith<$Res> implements $MemoCopyWith<$Res> {
  factory _$MemoCopyWith(_Memo value, $Res Function(_Memo) then) =
      __$MemoCopyWithImpl<$Res>;
  @override
  $Res call({String body, DateTime calendarDate});
}

class __$MemoCopyWithImpl<$Res> extends _$MemoCopyWithImpl<$Res>
    implements _$MemoCopyWith<$Res> {
  __$MemoCopyWithImpl(_Memo _value, $Res Function(_Memo) _then)
      : super(_value, (v) => _then(v as _Memo));

  @override
  _Memo get _value => super._value as _Memo;

  @override
  $Res call({
    Object body = freezed,
    Object calendarDate = freezed,
  }) {
    return _then(_Memo(
      body: body == freezed ? _value.body : body as String,
      calendarDate: calendarDate == freezed
          ? _value.calendarDate
          : calendarDate as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_Memo implements _Memo {
  _$_Memo({@required this.body, @required this.calendarDate})
      : assert(body != null),
        assert(calendarDate != null);

  factory _$_Memo.fromJson(Map<String, dynamic> json) =>
      _$_$_MemoFromJson(json);

  @override
  final String body;
  @override
  final DateTime calendarDate;

  @override
  String toString() {
    return 'Memo(body: $body, calendarDate: $calendarDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Memo &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.calendarDate, calendarDate) ||
                const DeepCollectionEquality()
                    .equals(other.calendarDate, calendarDate)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(calendarDate);

  @override
  _$MemoCopyWith<_Memo> get copyWith =>
      __$MemoCopyWithImpl<_Memo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MemoToJson(this);
  }
}

abstract class _Memo implements Memo {
  factory _Memo({@required String body, @required DateTime calendarDate}) =
      _$_Memo;

  factory _Memo.fromJson(Map<String, dynamic> json) = _$_Memo.fromJson;

  @override
  String get body;
  @override
  DateTime get calendarDate;
  @override
  _$MemoCopyWith<_Memo> get copyWith;
}
