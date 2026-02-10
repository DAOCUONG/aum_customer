// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FoodEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  String get restaurantName => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get timeMinutes => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of FoodEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodEntityCopyWith<FoodEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodEntityCopyWith<$Res> {
  factory $FoodEntityCopyWith(
    FoodEntity value,
    $Res Function(FoodEntity) then,
  ) = _$FoodEntityCopyWithImpl<$Res, FoodEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    String restaurantId,
    String restaurantName,
    double rating,
    double price,
    int timeMinutes,
    String imageUrl,
  });
}

/// @nodoc
class _$FoodEntityCopyWithImpl<$Res, $Val extends FoodEntity>
    implements $FoodEntityCopyWith<$Res> {
  _$FoodEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? restaurantId = null,
    Object? restaurantName = null,
    Object? rating = null,
    Object? price = null,
    Object? timeMinutes = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            restaurantId: null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as String,
            restaurantName: null == restaurantName
                ? _value.restaurantName
                : restaurantName // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            timeMinutes: null == timeMinutes
                ? _value.timeMinutes
                : timeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodEntityImplCopyWith<$Res>
    implements $FoodEntityCopyWith<$Res> {
  factory _$$FoodEntityImplCopyWith(
    _$FoodEntityImpl value,
    $Res Function(_$FoodEntityImpl) then,
  ) = __$$FoodEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String restaurantId,
    String restaurantName,
    double rating,
    double price,
    int timeMinutes,
    String imageUrl,
  });
}

/// @nodoc
class __$$FoodEntityImplCopyWithImpl<$Res>
    extends _$FoodEntityCopyWithImpl<$Res, _$FoodEntityImpl>
    implements _$$FoodEntityImplCopyWith<$Res> {
  __$$FoodEntityImplCopyWithImpl(
    _$FoodEntityImpl _value,
    $Res Function(_$FoodEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? restaurantId = null,
    Object? restaurantName = null,
    Object? rating = null,
    Object? price = null,
    Object? timeMinutes = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$FoodEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurantName: null == restaurantName
            ? _value.restaurantName
            : restaurantName // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        timeMinutes: null == timeMinutes
            ? _value.timeMinutes
            : timeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FoodEntityImpl extends _FoodEntity {
  const _$FoodEntityImpl({
    required this.id,
    required this.name,
    required this.restaurantId,
    required this.restaurantName,
    required this.rating,
    required this.price,
    required this.timeMinutes,
    required this.imageUrl,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String restaurantId;
  @override
  final String restaurantName;
  @override
  final double rating;
  @override
  final double price;
  @override
  final int timeMinutes;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'FoodEntity(id: $id, name: $name, restaurantId: $restaurantId, restaurantName: $restaurantName, rating: $rating, price: $price, timeMinutes: $timeMinutes, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.restaurantName, restaurantName) ||
                other.restaurantName == restaurantName) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.timeMinutes, timeMinutes) ||
                other.timeMinutes == timeMinutes) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    restaurantId,
    restaurantName,
    rating,
    price,
    timeMinutes,
    imageUrl,
  );

  /// Create a copy of FoodEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodEntityImplCopyWith<_$FoodEntityImpl> get copyWith =>
      __$$FoodEntityImplCopyWithImpl<_$FoodEntityImpl>(this, _$identity);
}

abstract class _FoodEntity extends FoodEntity {
  const factory _FoodEntity({
    required final String id,
    required final String name,
    required final String restaurantId,
    required final String restaurantName,
    required final double rating,
    required final double price,
    required final int timeMinutes,
    required final String imageUrl,
  }) = _$FoodEntityImpl;
  const _FoodEntity._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get restaurantId;
  @override
  String get restaurantName;
  @override
  double get rating;
  @override
  double get price;
  @override
  int get timeMinutes;
  @override
  String get imageUrl;

  /// Create a copy of FoodEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodEntityImplCopyWith<_$FoodEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
