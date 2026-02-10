// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RestaurantModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get cuisine => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get deliveryTimeMinutes => throw _privateConstructorUsedError;
  String get deliveryFee => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantModelCopyWith<RestaurantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantModelCopyWith<$Res> {
  factory $RestaurantModelCopyWith(
    RestaurantModel value,
    $Res Function(RestaurantModel) then,
  ) = _$RestaurantModelCopyWithImpl<$Res, RestaurantModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String cuisine,
    double rating,
    int deliveryTimeMinutes,
    String deliveryFee,
    String imageUrl,
  });
}

/// @nodoc
class _$RestaurantModelCopyWithImpl<$Res, $Val extends RestaurantModel>
    implements $RestaurantModelCopyWith<$Res> {
  _$RestaurantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cuisine = null,
    Object? rating = null,
    Object? deliveryTimeMinutes = null,
    Object? deliveryFee = null,
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
            cuisine: null == cuisine
                ? _value.cuisine
                : cuisine // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            deliveryTimeMinutes: null == deliveryTimeMinutes
                ? _value.deliveryTimeMinutes
                : deliveryTimeMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            deliveryFee: null == deliveryFee
                ? _value.deliveryFee
                : deliveryFee // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$RestaurantModelImplCopyWith<$Res>
    implements $RestaurantModelCopyWith<$Res> {
  factory _$$RestaurantModelImplCopyWith(
    _$RestaurantModelImpl value,
    $Res Function(_$RestaurantModelImpl) then,
  ) = __$$RestaurantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String cuisine,
    double rating,
    int deliveryTimeMinutes,
    String deliveryFee,
    String imageUrl,
  });
}

/// @nodoc
class __$$RestaurantModelImplCopyWithImpl<$Res>
    extends _$RestaurantModelCopyWithImpl<$Res, _$RestaurantModelImpl>
    implements _$$RestaurantModelImplCopyWith<$Res> {
  __$$RestaurantModelImplCopyWithImpl(
    _$RestaurantModelImpl _value,
    $Res Function(_$RestaurantModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? cuisine = null,
    Object? rating = null,
    Object? deliveryTimeMinutes = null,
    Object? deliveryFee = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$RestaurantModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        cuisine: null == cuisine
            ? _value.cuisine
            : cuisine // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        deliveryTimeMinutes: null == deliveryTimeMinutes
            ? _value.deliveryTimeMinutes
            : deliveryTimeMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        deliveryFee: null == deliveryFee
            ? _value.deliveryFee
            : deliveryFee // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantModelImpl extends _RestaurantModel {
  const _$RestaurantModelImpl({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTimeMinutes,
    required this.deliveryFee,
    required this.imageUrl,
  }) : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final String cuisine;
  @override
  final double rating;
  @override
  final int deliveryTimeMinutes;
  @override
  final String deliveryFee;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'RestaurantModel(id: $id, name: $name, cuisine: $cuisine, rating: $rating, deliveryTimeMinutes: $deliveryTimeMinutes, deliveryFee: $deliveryFee, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cuisine, cuisine) || other.cuisine == cuisine) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.deliveryTimeMinutes, deliveryTimeMinutes) ||
                other.deliveryTimeMinutes == deliveryTimeMinutes) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    cuisine,
    rating,
    deliveryTimeMinutes,
    deliveryFee,
    imageUrl,
  );

  /// Create a copy of RestaurantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantModelImplCopyWith<_$RestaurantModelImpl> get copyWith =>
      __$$RestaurantModelImplCopyWithImpl<_$RestaurantModelImpl>(
        this,
        _$identity,
      );
}

abstract class _RestaurantModel extends RestaurantModel {
  const factory _RestaurantModel({
    required final String id,
    required final String name,
    required final String cuisine,
    required final double rating,
    required final int deliveryTimeMinutes,
    required final String deliveryFee,
    required final String imageUrl,
  }) = _$RestaurantModelImpl;
  const _RestaurantModel._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String get cuisine;
  @override
  double get rating;
  @override
  int get deliveryTimeMinutes;
  @override
  String get deliveryFee;
  @override
  String get imageUrl;

  /// Create a copy of RestaurantModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantModelImplCopyWith<_$RestaurantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
