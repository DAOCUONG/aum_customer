// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delivery_slot_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DeliverySlotEntity {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  TimeOfDay get startTime => throw _privateConstructorUsedError;
  TimeOfDay get endTime => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  double? get additionalFee => throw _privateConstructorUsedError;
  int get remainingSlots => throw _privateConstructorUsedError;

  /// Create a copy of DeliverySlotEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliverySlotEntityCopyWith<DeliverySlotEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliverySlotEntityCopyWith<$Res> {
  factory $DeliverySlotEntityCopyWith(
    DeliverySlotEntity value,
    $Res Function(DeliverySlotEntity) then,
  ) = _$DeliverySlotEntityCopyWithImpl<$Res, DeliverySlotEntity>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    TimeOfDay startTime,
    TimeOfDay endTime,
    bool isAvailable,
    double? additionalFee,
    int remainingSlots,
  });
}

/// @nodoc
class _$DeliverySlotEntityCopyWithImpl<$Res, $Val extends DeliverySlotEntity>
    implements $DeliverySlotEntityCopyWith<$Res> {
  _$DeliverySlotEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliverySlotEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
    Object? additionalFee = freezed,
    Object? remainingSlots = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as TimeOfDay,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as TimeOfDay,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            additionalFee: freezed == additionalFee
                ? _value.additionalFee
                : additionalFee // ignore: cast_nullable_to_non_nullable
                      as double?,
            remainingSlots: null == remainingSlots
                ? _value.remainingSlots
                : remainingSlots // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeliverySlotEntityImplCopyWith<$Res>
    implements $DeliverySlotEntityCopyWith<$Res> {
  factory _$$DeliverySlotEntityImplCopyWith(
    _$DeliverySlotEntityImpl value,
    $Res Function(_$DeliverySlotEntityImpl) then,
  ) = __$$DeliverySlotEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    TimeOfDay startTime,
    TimeOfDay endTime,
    bool isAvailable,
    double? additionalFee,
    int remainingSlots,
  });
}

/// @nodoc
class __$$DeliverySlotEntityImplCopyWithImpl<$Res>
    extends _$DeliverySlotEntityCopyWithImpl<$Res, _$DeliverySlotEntityImpl>
    implements _$$DeliverySlotEntityImplCopyWith<$Res> {
  __$$DeliverySlotEntityImplCopyWithImpl(
    _$DeliverySlotEntityImpl _value,
    $Res Function(_$DeliverySlotEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliverySlotEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
    Object? additionalFee = freezed,
    Object? remainingSlots = null,
  }) {
    return _then(
      _$DeliverySlotEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as TimeOfDay,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as TimeOfDay,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        additionalFee: freezed == additionalFee
            ? _value.additionalFee
            : additionalFee // ignore: cast_nullable_to_non_nullable
                  as double?,
        remainingSlots: null == remainingSlots
            ? _value.remainingSlots
            : remainingSlots // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DeliverySlotEntityImpl extends _DeliverySlotEntity {
  const _$DeliverySlotEntityImpl({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.additionalFee,
    required this.remainingSlots,
  }) : super._();

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final TimeOfDay startTime;
  @override
  final TimeOfDay endTime;
  @override
  final bool isAvailable;
  @override
  final double? additionalFee;
  @override
  final int remainingSlots;

  @override
  String toString() {
    return 'DeliverySlotEntity(id: $id, date: $date, startTime: $startTime, endTime: $endTime, isAvailable: $isAvailable, additionalFee: $additionalFee, remainingSlots: $remainingSlots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliverySlotEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.additionalFee, additionalFee) ||
                other.additionalFee == additionalFee) &&
            (identical(other.remainingSlots, remainingSlots) ||
                other.remainingSlots == remainingSlots));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    startTime,
    endTime,
    isAvailable,
    additionalFee,
    remainingSlots,
  );

  /// Create a copy of DeliverySlotEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliverySlotEntityImplCopyWith<_$DeliverySlotEntityImpl> get copyWith =>
      __$$DeliverySlotEntityImplCopyWithImpl<_$DeliverySlotEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _DeliverySlotEntity extends DeliverySlotEntity {
  const factory _DeliverySlotEntity({
    required final String id,
    required final DateTime date,
    required final TimeOfDay startTime,
    required final TimeOfDay endTime,
    required final bool isAvailable,
    required final double? additionalFee,
    required final int remainingSlots,
  }) = _$DeliverySlotEntityImpl;
  const _DeliverySlotEntity._() : super._();

  @override
  String get id;
  @override
  DateTime get date;
  @override
  TimeOfDay get startTime;
  @override
  TimeOfDay get endTime;
  @override
  bool get isAvailable;
  @override
  double? get additionalFee;
  @override
  int get remainingSlots;

  /// Create a copy of DeliverySlotEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliverySlotEntityImplCopyWith<_$DeliverySlotEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
