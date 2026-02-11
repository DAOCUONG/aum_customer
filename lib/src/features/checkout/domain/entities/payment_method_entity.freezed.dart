// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PaymentMethodEntity {
  String get id => throw _privateConstructorUsedError;
  PaymentMethodType get type => throw _privateConstructorUsedError;
  String get lastFourDigits => throw _privateConstructorUsedError;
  String? get cardBrand => throw _privateConstructorUsedError;
  String? get cardholderName => throw _privateConstructorUsedError;
  String? get expiryMonth => throw _privateConstructorUsedError;
  String? get expiryYear => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  String? get iconName => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethodEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodEntityCopyWith<PaymentMethodEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodEntityCopyWith<$Res> {
  factory $PaymentMethodEntityCopyWith(
    PaymentMethodEntity value,
    $Res Function(PaymentMethodEntity) then,
  ) = _$PaymentMethodEntityCopyWithImpl<$Res, PaymentMethodEntity>;
  @useResult
  $Res call({
    String id,
    PaymentMethodType type,
    String lastFourDigits,
    String? cardBrand,
    String? cardholderName,
    String? expiryMonth,
    String? expiryYear,
    bool isDefault,
    String? iconName,
  });
}

/// @nodoc
class _$PaymentMethodEntityCopyWithImpl<$Res, $Val extends PaymentMethodEntity>
    implements $PaymentMethodEntityCopyWith<$Res> {
  _$PaymentMethodEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethodEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? lastFourDigits = null,
    Object? cardBrand = freezed,
    Object? cardholderName = freezed,
    Object? expiryMonth = freezed,
    Object? expiryYear = freezed,
    Object? isDefault = null,
    Object? iconName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PaymentMethodType,
            lastFourDigits: null == lastFourDigits
                ? _value.lastFourDigits
                : lastFourDigits // ignore: cast_nullable_to_non_nullable
                      as String,
            cardBrand: freezed == cardBrand
                ? _value.cardBrand
                : cardBrand // ignore: cast_nullable_to_non_nullable
                      as String?,
            cardholderName: freezed == cardholderName
                ? _value.cardholderName
                : cardholderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiryMonth: freezed == expiryMonth
                ? _value.expiryMonth
                : expiryMonth // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiryYear: freezed == expiryYear
                ? _value.expiryYear
                : expiryYear // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
            iconName: freezed == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaymentMethodEntityImplCopyWith<$Res>
    implements $PaymentMethodEntityCopyWith<$Res> {
  factory _$$PaymentMethodEntityImplCopyWith(
    _$PaymentMethodEntityImpl value,
    $Res Function(_$PaymentMethodEntityImpl) then,
  ) = __$$PaymentMethodEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PaymentMethodType type,
    String lastFourDigits,
    String? cardBrand,
    String? cardholderName,
    String? expiryMonth,
    String? expiryYear,
    bool isDefault,
    String? iconName,
  });
}

/// @nodoc
class __$$PaymentMethodEntityImplCopyWithImpl<$Res>
    extends _$PaymentMethodEntityCopyWithImpl<$Res, _$PaymentMethodEntityImpl>
    implements _$$PaymentMethodEntityImplCopyWith<$Res> {
  __$$PaymentMethodEntityImplCopyWithImpl(
    _$PaymentMethodEntityImpl _value,
    $Res Function(_$PaymentMethodEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaymentMethodEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? lastFourDigits = null,
    Object? cardBrand = freezed,
    Object? cardholderName = freezed,
    Object? expiryMonth = freezed,
    Object? expiryYear = freezed,
    Object? isDefault = null,
    Object? iconName = freezed,
  }) {
    return _then(
      _$PaymentMethodEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PaymentMethodType,
        lastFourDigits: null == lastFourDigits
            ? _value.lastFourDigits
            : lastFourDigits // ignore: cast_nullable_to_non_nullable
                  as String,
        cardBrand: freezed == cardBrand
            ? _value.cardBrand
            : cardBrand // ignore: cast_nullable_to_non_nullable
                  as String?,
        cardholderName: freezed == cardholderName
            ? _value.cardholderName
            : cardholderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiryMonth: freezed == expiryMonth
            ? _value.expiryMonth
            : expiryMonth // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiryYear: freezed == expiryYear
            ? _value.expiryYear
            : expiryYear // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
        iconName: freezed == iconName
            ? _value.iconName
            : iconName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PaymentMethodEntityImpl extends _PaymentMethodEntity {
  const _$PaymentMethodEntityImpl({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    required this.cardBrand,
    required this.cardholderName,
    required this.expiryMonth,
    required this.expiryYear,
    required this.isDefault,
    required this.iconName,
  }) : super._();

  @override
  final String id;
  @override
  final PaymentMethodType type;
  @override
  final String lastFourDigits;
  @override
  final String? cardBrand;
  @override
  final String? cardholderName;
  @override
  final String? expiryMonth;
  @override
  final String? expiryYear;
  @override
  final bool isDefault;
  @override
  final String? iconName;

  @override
  String toString() {
    return 'PaymentMethodEntity(id: $id, type: $type, lastFourDigits: $lastFourDigits, cardBrand: $cardBrand, cardholderName: $cardholderName, expiryMonth: $expiryMonth, expiryYear: $expiryYear, isDefault: $isDefault, iconName: $iconName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.lastFourDigits, lastFourDigits) ||
                other.lastFourDigits == lastFourDigits) &&
            (identical(other.cardBrand, cardBrand) ||
                other.cardBrand == cardBrand) &&
            (identical(other.cardholderName, cardholderName) ||
                other.cardholderName == cardholderName) &&
            (identical(other.expiryMonth, expiryMonth) ||
                other.expiryMonth == expiryMonth) &&
            (identical(other.expiryYear, expiryYear) ||
                other.expiryYear == expiryYear) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    lastFourDigits,
    cardBrand,
    cardholderName,
    expiryMonth,
    expiryYear,
    isDefault,
    iconName,
  );

  /// Create a copy of PaymentMethodEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodEntityImplCopyWith<_$PaymentMethodEntityImpl> get copyWith =>
      __$$PaymentMethodEntityImplCopyWithImpl<_$PaymentMethodEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _PaymentMethodEntity extends PaymentMethodEntity {
  const factory _PaymentMethodEntity({
    required final String id,
    required final PaymentMethodType type,
    required final String lastFourDigits,
    required final String? cardBrand,
    required final String? cardholderName,
    required final String? expiryMonth,
    required final String? expiryYear,
    required final bool isDefault,
    required final String? iconName,
  }) = _$PaymentMethodEntityImpl;
  const _PaymentMethodEntity._() : super._();

  @override
  String get id;
  @override
  PaymentMethodType get type;
  @override
  String get lastFourDigits;
  @override
  String? get cardBrand;
  @override
  String? get cardholderName;
  @override
  String? get expiryMonth;
  @override
  String? get expiryYear;
  @override
  bool get isDefault;
  @override
  String? get iconName;

  /// Create a copy of PaymentMethodEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodEntityImplCopyWith<_$PaymentMethodEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
