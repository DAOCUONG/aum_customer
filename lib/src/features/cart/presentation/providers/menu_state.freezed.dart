// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MenuState {
  MenuStatus get status => throw _privateConstructorUsedError;
  String get restaurantId => throw _privateConstructorUsedError;
  RestaurantEntity? get restaurant => throw _privateConstructorUsedError;
  List<MenuItemEntity> get menuItems => throw _privateConstructorUsedError;
  List<MenuCategory> get categories => throw _privateConstructorUsedError;
  String get selectedCategoryId => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of MenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MenuStateCopyWith<MenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuStateCopyWith<$Res> {
  factory $MenuStateCopyWith(MenuState value, $Res Function(MenuState) then) =
      _$MenuStateCopyWithImpl<$Res, MenuState>;
  @useResult
  $Res call({
    MenuStatus status,
    String restaurantId,
    RestaurantEntity? restaurant,
    List<MenuItemEntity> menuItems,
    List<MenuCategory> categories,
    String selectedCategoryId,
    String errorMessage,
  });
}

/// @nodoc
class _$MenuStateCopyWithImpl<$Res, $Val extends MenuState>
    implements $MenuStateCopyWith<$Res> {
  _$MenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? restaurantId = null,
    Object? restaurant = freezed,
    Object? menuItems = null,
    Object? categories = null,
    Object? selectedCategoryId = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MenuStatus,
            restaurantId: null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as String,
            restaurant: freezed == restaurant
                ? _value.restaurant
                : restaurant // ignore: cast_nullable_to_non_nullable
                      as RestaurantEntity?,
            menuItems: null == menuItems
                ? _value.menuItems
                : menuItems // ignore: cast_nullable_to_non_nullable
                      as List<MenuItemEntity>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<MenuCategory>,
            selectedCategoryId: null == selectedCategoryId
                ? _value.selectedCategoryId
                : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MenuStateImplCopyWith<$Res>
    implements $MenuStateCopyWith<$Res> {
  factory _$$MenuStateImplCopyWith(
    _$MenuStateImpl value,
    $Res Function(_$MenuStateImpl) then,
  ) = __$$MenuStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MenuStatus status,
    String restaurantId,
    RestaurantEntity? restaurant,
    List<MenuItemEntity> menuItems,
    List<MenuCategory> categories,
    String selectedCategoryId,
    String errorMessage,
  });
}

/// @nodoc
class __$$MenuStateImplCopyWithImpl<$Res>
    extends _$MenuStateCopyWithImpl<$Res, _$MenuStateImpl>
    implements _$$MenuStateImplCopyWith<$Res> {
  __$$MenuStateImplCopyWithImpl(
    _$MenuStateImpl _value,
    $Res Function(_$MenuStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? restaurantId = null,
    Object? restaurant = freezed,
    Object? menuItems = null,
    Object? categories = null,
    Object? selectedCategoryId = null,
    Object? errorMessage = null,
  }) {
    return _then(
      _$MenuStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MenuStatus,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as String,
        restaurant: freezed == restaurant
            ? _value.restaurant
            : restaurant // ignore: cast_nullable_to_non_nullable
                  as RestaurantEntity?,
        menuItems: null == menuItems
            ? _value._menuItems
            : menuItems // ignore: cast_nullable_to_non_nullable
                  as List<MenuItemEntity>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<MenuCategory>,
        selectedCategoryId: null == selectedCategoryId
            ? _value.selectedCategoryId
            : selectedCategoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MenuStateImpl extends _MenuState {
  const _$MenuStateImpl({
    this.status = MenuStatus.initial,
    this.restaurantId = '',
    this.restaurant,
    final List<MenuItemEntity> menuItems = const [],
    final List<MenuCategory> categories = const [],
    this.selectedCategoryId = '',
    this.errorMessage = '',
  }) : _menuItems = menuItems,
       _categories = categories,
       super._();

  @override
  @JsonKey()
  final MenuStatus status;
  @override
  @JsonKey()
  final String restaurantId;
  @override
  final RestaurantEntity? restaurant;
  final List<MenuItemEntity> _menuItems;
  @override
  @JsonKey()
  List<MenuItemEntity> get menuItems {
    if (_menuItems is EqualUnmodifiableListView) return _menuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuItems);
  }

  final List<MenuCategory> _categories;
  @override
  @JsonKey()
  List<MenuCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final String selectedCategoryId;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'MenuState(status: $status, restaurantId: $restaurantId, restaurant: $restaurant, menuItems: $menuItems, categories: $categories, selectedCategoryId: $selectedCategoryId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.restaurant, restaurant) ||
                other.restaurant == restaurant) &&
            const DeepCollectionEquality().equals(
              other._menuItems,
              _menuItems,
            ) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.selectedCategoryId, selectedCategoryId) ||
                other.selectedCategoryId == selectedCategoryId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    restaurantId,
    restaurant,
    const DeepCollectionEquality().hash(_menuItems),
    const DeepCollectionEquality().hash(_categories),
    selectedCategoryId,
    errorMessage,
  );

  /// Create a copy of MenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuStateImplCopyWith<_$MenuStateImpl> get copyWith =>
      __$$MenuStateImplCopyWithImpl<_$MenuStateImpl>(this, _$identity);
}

abstract class _MenuState extends MenuState {
  const factory _MenuState({
    final MenuStatus status,
    final String restaurantId,
    final RestaurantEntity? restaurant,
    final List<MenuItemEntity> menuItems,
    final List<MenuCategory> categories,
    final String selectedCategoryId,
    final String errorMessage,
  }) = _$MenuStateImpl;
  const _MenuState._() : super._();

  @override
  MenuStatus get status;
  @override
  String get restaurantId;
  @override
  RestaurantEntity? get restaurant;
  @override
  List<MenuItemEntity> get menuItems;
  @override
  List<MenuCategory> get categories;
  @override
  String get selectedCategoryId;
  @override
  String get errorMessage;

  /// Create a copy of MenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MenuStateImplCopyWith<_$MenuStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
