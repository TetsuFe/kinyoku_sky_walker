// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'rank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Rank _$RankFromJson(Map<String, dynamic> json) {
  return _Rank.fromJson(json);
}

class _$RankTearOff {
  const _$RankTearOff();

// ignore: unused_element
  _Rank call(
      {@required String userId,
      @required int rank,
      @required double topXPercent,
      @required int altRank,
      @required int maxStoicTime}) {
    return _Rank(
      userId: userId,
      rank: rank,
      topXPercent: topXPercent,
      altRank: altRank,
      maxStoicTime: maxStoicTime,
    );
  }
}

// ignore: unused_element
const $Rank = _$RankTearOff();

mixin _$Rank {
  String get userId;
  int get rank;
  double get topXPercent;
  int get altRank;
  int get maxStoicTime;

  Map<String, dynamic> toJson();
  $RankCopyWith<Rank> get copyWith;
}

abstract class $RankCopyWith<$Res> {
  factory $RankCopyWith(Rank value, $Res Function(Rank) then) =
      _$RankCopyWithImpl<$Res>;
  $Res call(
      {String userId,
      int rank,
      double topXPercent,
      int altRank,
      int maxStoicTime});
}

class _$RankCopyWithImpl<$Res> implements $RankCopyWith<$Res> {
  _$RankCopyWithImpl(this._value, this._then);

  final Rank _value;
  // ignore: unused_field
  final $Res Function(Rank) _then;

  @override
  $Res call({
    Object userId = freezed,
    Object rank = freezed,
    Object topXPercent = freezed,
    Object altRank = freezed,
    Object maxStoicTime = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed ? _value.userId : userId as String,
      rank: rank == freezed ? _value.rank : rank as int,
      topXPercent:
          topXPercent == freezed ? _value.topXPercent : topXPercent as double,
      altRank: altRank == freezed ? _value.altRank : altRank as int,
      maxStoicTime:
          maxStoicTime == freezed ? _value.maxStoicTime : maxStoicTime as int,
    ));
  }
}

abstract class _$RankCopyWith<$Res> implements $RankCopyWith<$Res> {
  factory _$RankCopyWith(_Rank value, $Res Function(_Rank) then) =
      __$RankCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userId,
      int rank,
      double topXPercent,
      int altRank,
      int maxStoicTime});
}

class __$RankCopyWithImpl<$Res> extends _$RankCopyWithImpl<$Res>
    implements _$RankCopyWith<$Res> {
  __$RankCopyWithImpl(_Rank _value, $Res Function(_Rank) _then)
      : super(_value, (v) => _then(v as _Rank));

  @override
  _Rank get _value => super._value as _Rank;

  @override
  $Res call({
    Object userId = freezed,
    Object rank = freezed,
    Object topXPercent = freezed,
    Object altRank = freezed,
    Object maxStoicTime = freezed,
  }) {
    return _then(_Rank(
      userId: userId == freezed ? _value.userId : userId as String,
      rank: rank == freezed ? _value.rank : rank as int,
      topXPercent:
          topXPercent == freezed ? _value.topXPercent : topXPercent as double,
      altRank: altRank == freezed ? _value.altRank : altRank as int,
      maxStoicTime:
          maxStoicTime == freezed ? _value.maxStoicTime : maxStoicTime as int,
    ));
  }
}

@JsonSerializable()
class _$_Rank implements _Rank {
  _$_Rank(
      {@required this.userId,
      @required this.rank,
      @required this.topXPercent,
      @required this.altRank,
      @required this.maxStoicTime})
      : assert(userId != null),
        assert(rank != null),
        assert(topXPercent != null),
        assert(altRank != null),
        assert(maxStoicTime != null);

  factory _$_Rank.fromJson(Map<String, dynamic> json) =>
      _$_$_RankFromJson(json);

  @override
  final String userId;
  @override
  final int rank;
  @override
  final double topXPercent;
  @override
  final int altRank;
  @override
  final int maxStoicTime;

  @override
  String toString() {
    return 'Rank(userId: $userId, rank: $rank, topXPercent: $topXPercent, altRank: $altRank, maxStoicTime: $maxStoicTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Rank &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.rank, rank) ||
                const DeepCollectionEquality().equals(other.rank, rank)) &&
            (identical(other.topXPercent, topXPercent) ||
                const DeepCollectionEquality()
                    .equals(other.topXPercent, topXPercent)) &&
            (identical(other.altRank, altRank) ||
                const DeepCollectionEquality()
                    .equals(other.altRank, altRank)) &&
            (identical(other.maxStoicTime, maxStoicTime) ||
                const DeepCollectionEquality()
                    .equals(other.maxStoicTime, maxStoicTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(rank) ^
      const DeepCollectionEquality().hash(topXPercent) ^
      const DeepCollectionEquality().hash(altRank) ^
      const DeepCollectionEquality().hash(maxStoicTime);

  @override
  _$RankCopyWith<_Rank> get copyWith =>
      __$RankCopyWithImpl<_Rank>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RankToJson(this);
  }
}

abstract class _Rank implements Rank {
  factory _Rank(
      {@required String userId,
      @required int rank,
      @required double topXPercent,
      @required int altRank,
      @required int maxStoicTime}) = _$_Rank;

  factory _Rank.fromJson(Map<String, dynamic> json) = _$_Rank.fromJson;

  @override
  String get userId;
  @override
  int get rank;
  @override
  double get topXPercent;
  @override
  int get altRank;
  @override
  int get maxStoicTime;
  @override
  _$RankCopyWith<_Rank> get copyWith;
}
