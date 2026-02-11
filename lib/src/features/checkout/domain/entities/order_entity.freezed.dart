// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OrderEntity {
  String get id => throw _privateConstructorUsedError;
  String get orderNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  DeliveryAddressEntity get deliveryAddress =>
      throw _privateConstructorUsedError;
  PaymentMethodEntity get paymentMethod => throw _privateConstructorUsedError;
  List<OrderItemEntity> get items => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get deliveryFee => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get tip => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  DateTime? get scheduledDeliveryTime => throw _privateConstructorUsedError;
  String? get promoCode => throw _privateConstructorUsedError;
  String? get deliveryInstructions => throw _privateConstructorUsedError;
  int get estimatedDeliveryMinutes => throw _privateConstructorUsedError;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderEntityCopyWith<OrderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEntityCopyWith<$Res> {
  factory $OrderEntityCopyWith(
    OrderEntity value,
    $Res Function(OrderEntity) then,
  ) = _$OrderEntityCopyWithImpl<$Res, OrderEntity>;
  @useResult
  $Res call({
    String id,
    String orderNumber,
    DateTime createdAt,
    OrderStatus status,
    DeliveryAddressEntity deliveryAddress,
    PaymentMethodEntity paymentMethod,
    List<OrderItemEntity> items,
    double subtotal,
    double deliveryFee,
    double tax,
    double tip,
    double discount,
    double total,
    DateTime? scheduledDeliveryTime,
    String? promoCode,
    String? deliveryInstructions,
    int estimatedDeliveryMinutes,
  });

  $DeliveryAddressEntityCopyWith<$Res> get deliveryAddress;
  $PaymentMethodEntityCopyWith<$Res> get paymentMethod;
}

/// @nodoc
class _$OrderEntityCopyWithImpl<$Res, $Val extends OrderEntity>
    implements $OrderEntityCopyWith<$Res> {
  _$OrderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? createdAt = null,
    Object? status = null,
    Object? deliveryAddress = null,
    Object? paymentMethod = null,
    Object? items = null,
    Object? subtotal = null,
    Object? deliveryFee = null,
    Object? tax = null,
    Object? tip = null,
    Object? discount = null,
    Object? total = null,
    Object? scheduledDeliveryTime = freezed,
    Object? promoCode = freezed,
    Object? deliveryInstructions = freezed,
    Object? estimatedDeliveryMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            orderNumber: null == orderNumber
                ? _value.orderNumber
                : orderNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrderStatus,
            deliveryAddress: null == deliveryAddress
                ? _value.deliveryAddress
                : deliveryAddress // ignore: cast_nullable_to_non_nullable
                      as DeliveryAddressEntity,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethodEntity,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderItemEntity>,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as double,
            deliveryFee: null == deliveryFee
                ? _value.deliveryFee
                : deliveryFee // ignore: cast_nullable_to_non_nullable
                      as double,
            tax: null == tax
                ? _value.tax
                : tax // ignore: cast_nullable_to_non_nullable
                      as double,
            tip: null == tip
                ? _value.tip
                : tip // ignore: cast_nullable_to_non_nullable
                      as double,
            discount: null == discount
                ? _value.discount
                : discount // ignore: cast_nullable_to_non_nullable
                      as double,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as double,
            scheduledDeliveryTime: freezed == scheduledDeliveryTime
                ? _value.scheduledDeliveryTime
                : scheduledDeliveryTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            promoCode: freezed == promoCode
                ? _value.promoCode
                : promoCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryInstructions: freezed == deliveryInstructions
                ? _value.deliveryInstructions
                : deliveryInstructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            estimatedDeliveryMinutes: null == estimatedDeliveryMinutes
                ? _value.estimatedDeliveryMinutes
                : estimatedDeliveryMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryAddressEntityCopyWith<$Res> get deliveryAddress {
    return $DeliveryAddressEntityCopyWith<$Res>(_value.deliveryAddress, (
      value,
    ) {
      return _then(_value.copyWith(deliveryAddress: value) as $Val);
    });
  }

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodEntityCopyWith<$Res> get paymentMethod {
    return $PaymentMethodEntityCopyWith<$Res>(_value.paymentMethod, (value) {
      return _then(_value.copyWith(paymentMethod: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderEntityImplCopyWith<$Res>
    implements $OrderEntityCopyWith<$Res> {
  factory _$$OrderEntityImplCopyWith(
    _$OrderEntityImpl value,
    $Res Function(_$OrderEntityImpl) then,
  ) = __$$OrderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String orderNumber,
    DateTime createdAt,
    OrderStatus status,
    DeliveryAddressEntity deliveryAddress,
    PaymentMethodEntity paymentMethod,
    List<OrderItemEntity> items,
    double subtotal,
    double deliveryFee,
    double tax,
    double tip,
    double discount,
    double total,
    DateTime? scheduledDeliveryTime,
    String? promoCode,
    String? deliveryInstructions,
    int estimatedDeliveryMinutes,
  });

  @override
  $DeliveryAddressEntityCopyWith<$Res> get deliveryAddress;
  @override
  $PaymentMethodEntityCopyWith<$Res> get paymentMethod;
}

/// @nodoc
class __$$OrderEntityImplCopyWithImpl<$Res>
    extends _$OrderEntityCopyWithImpl<$Res, _$OrderEntityImpl>
    implements _$$OrderEntityImplCopyWith<$Res> {
  __$$OrderEntityImplCopyWithImpl(
    _$OrderEntityImpl _value,
    $Res Function(_$OrderEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? orderNumber = null,
    Object? createdAt = null,
    Object? status = null,
    Object? deliveryAddress = null,
    Object? paymentMethod = null,
    Object? items = null,
    Object? subtotal = null,
    Object? deliveryFee = null,
    Object? tax = null,
    Object? tip = null,
    Object? discount = null,
    Object? total = null,
    Object? scheduledDeliveryTime = freezed,
    Object? promoCode = freezed,
    Object? deliveryInstructions = freezed,
    Object? estimatedDeliveryMinutes = null,
  }) {
    return _then(
      _$OrderEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        orderNumber: null == orderNumber
            ? _value.orderNumber
            : orderNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrderStatus,
        deliveryAddress: null == deliveryAddress
            ? _value.deliveryAddress
            : deliveryAddress // ignore: cast_nullable_to_non_nullable
                  as DeliveryAddressEntity,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethodEntity,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderItemEntity>,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as double,
        deliveryFee: null == deliveryFee
            ? _value.deliveryFee
            : deliveryFee // ignore: cast_nullable_to_non_nullable
                  as double,
        tax: null == tax
            ? _value.tax
            : tax // ignore: cast_nullable_to_non_nullable
                  as double,
        tip: null == tip
            ? _value.tip
            : tip // ignore: cast_nullable_to_non_nullable
                  as double,
        discount: null == discount
            ? _value.discount
            : discount // ignore: cast_nullable_to_non_nullable
                  as double,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as double,
        scheduledDeliveryTime: freezed == scheduledDeliveryTime
            ? _value.scheduledDeliveryTime
            : scheduledDeliveryTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        promoCode: freezed == promoCode
            ? _value.promoCode
            : promoCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryInstructions: freezed == deliveryInstructions
            ? _value.deliveryInstructions
            : deliveryInstructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        estimatedDeliveryMinutes: null == estimatedDeliveryMinutes
            ? _value.estimatedDeliveryMinutes
            : estimatedDeliveryMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$OrderEntityImpl extends _OrderEntity {
  const _$OrderEntityImpl({
    required this.id,
    required this.orderNumber,
    required this.createdAt,
    required this.status,
    required this.deliveryAddress,
    required this.paymentMethod,
    required final List<OrderItemEntity> items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.tip,
    required this.discount,
    required this.total,
    required this.scheduledDeliveryTime,
    required this.promoCode,
    required this.deliveryInstructions,
    required this.estimatedDeliveryMinutes,
  }) : _items = items,
       super._();

  @override
  final String id;
  @override
  final String orderNumber;
  @override
  final DateTime createdAt;
  @override
  final OrderStatus status;
  @override
  final DeliveryAddressEntity deliveryAddress;
  @override
  final PaymentMethodEntity paymentMethod;
  final List<OrderItemEntity> _items;
  @override
  List<OrderItemEntity> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double subtotal;
  @override
  final double deliveryFee;
  @override
  final double tax;
  @override
  final double tip;
  @override
  final double discount;
  @override
  final double total;
  @override
  final DateTime? scheduledDeliveryTime;
  @override
  final String? promoCode;
  @override
  final String? deliveryInstructions;
  @override
  final int estimatedDeliveryMinutes;

  @override
  String toString() {
    return 'OrderEntity(id: $id, orderNumber: $orderNumber, createdAt: $createdAt, status: $status, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, items: $items, subtotal: $subtotal, deliveryFee: $deliveryFee, tax: $tax, tip: $tip, discount: $discount, total: $total, scheduledDeliveryTime: $scheduledDeliveryTime, promoCode: $promoCode, deliveryInstructions: $deliveryInstructions, estimatedDeliveryMinutes: $estimatedDeliveryMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.tip, tip) || other.tip == tip) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.scheduledDeliveryTime, scheduledDeliveryTime) ||
                other.scheduledDeliveryTime == scheduledDeliveryTime) &&
            (identical(other.promoCode, promoCode) ||
                other.promoCode == promoCode) &&
            (identical(other.deliveryInstructions, deliveryInstructions) ||
                other.deliveryInstructions == deliveryInstructions) &&
            (identical(
                  other.estimatedDeliveryMinutes,
                  estimatedDeliveryMinutes,
                ) ||
                other.estimatedDeliveryMinutes == estimatedDeliveryMinutes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orderNumber,
    createdAt,
    status,
    deliveryAddress,
    paymentMethod,
    const DeepCollectionEquality().hash(_items),
    subtotal,
    deliveryFee,
    tax,
    tip,
    discount,
    total,
    scheduledDeliveryTime,
    promoCode,
    deliveryInstructions,
    estimatedDeliveryMinutes,
  );

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      __$$OrderEntityImplCopyWithImpl<_$OrderEntityImpl>(this, _$identity);
}

abstract class _OrderEntity extends OrderEntity {
  const factory _OrderEntity({
    required final String id,
    required final String orderNumber,
    required final DateTime createdAt,
    required final OrderStatus status,
    required final DeliveryAddressEntity deliveryAddress,
    required final PaymentMethodEntity paymentMethod,
    required final List<OrderItemEntity> items,
    required final double subtotal,
    required final double deliveryFee,
    required final double tax,
    required final double tip,
    required final double discount,
    required final double total,
    required final DateTime? scheduledDeliveryTime,
    required final String? promoCode,
    required final String? deliveryInstructions,
    required final int estimatedDeliveryMinutes,
  }) = _$OrderEntityImpl;
  const _OrderEntity._() : super._();

  @override
  String get id;
  @override
  String get orderNumber;
  @override
  DateTime get createdAt;
  @override
  OrderStatus get status;
  @override
  DeliveryAddressEntity get deliveryAddress;
  @override
  PaymentMethodEntity get paymentMethod;
  @override
  List<OrderItemEntity> get items;
  @override
  double get subtotal;
  @override
  double get deliveryFee;
  @override
  double get tax;
  @override
  double get tip;
  @override
  double get discount;
  @override
  double get total;
  @override
  DateTime? get scheduledDeliveryTime;
  @override
  String? get promoCode;
  @override
  String? get deliveryInstructions;
  @override
  int get estimatedDeliveryMinutes;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderItemEntity {
  String get id => throw _privateConstructorUsedError;
  String get menuItemId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<OrderItemCustomization>? get customizations =>
      throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemEntityCopyWith<OrderItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemEntityCopyWith<$Res> {
  factory $OrderItemEntityCopyWith(
    OrderItemEntity value,
    $Res Function(OrderItemEntity) then,
  ) = _$OrderItemEntityCopyWithImpl<$Res, OrderItemEntity>;
  @useResult
  $Res call({
    String id,
    String menuItemId,
    String name,
    String description,
    double price,
    int quantity,
    String imageUrl,
    List<OrderItemCustomization>? customizations,
    String? notes,
  });
}

/// @nodoc
class _$OrderItemEntityCopyWithImpl<$Res, $Val extends OrderItemEntity>
    implements $OrderItemEntityCopyWith<$Res> {
  _$OrderItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItemId = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? quantity = null,
    Object? imageUrl = null,
    Object? customizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            menuItemId: null == menuItemId
                ? _value.menuItemId
                : menuItemId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            customizations: freezed == customizations
                ? _value.customizations
                : customizations // ignore: cast_nullable_to_non_nullable
                      as List<OrderItemCustomization>?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemEntityImplCopyWith<$Res>
    implements $OrderItemEntityCopyWith<$Res> {
  factory _$$OrderItemEntityImplCopyWith(
    _$OrderItemEntityImpl value,
    $Res Function(_$OrderItemEntityImpl) then,
  ) = __$$OrderItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String menuItemId,
    String name,
    String description,
    double price,
    int quantity,
    String imageUrl,
    List<OrderItemCustomization>? customizations,
    String? notes,
  });
}

/// @nodoc
class __$$OrderItemEntityImplCopyWithImpl<$Res>
    extends _$OrderItemEntityCopyWithImpl<$Res, _$OrderItemEntityImpl>
    implements _$$OrderItemEntityImplCopyWith<$Res> {
  __$$OrderItemEntityImplCopyWithImpl(
    _$OrderItemEntityImpl _value,
    $Res Function(_$OrderItemEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItemId = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? quantity = null,
    Object? imageUrl = null,
    Object? customizations = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$OrderItemEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        menuItemId: null == menuItemId
            ? _value.menuItemId
            : menuItemId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        customizations: freezed == customizations
            ? _value._customizations
            : customizations // ignore: cast_nullable_to_non_nullable
                  as List<OrderItemCustomization>?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderItemEntityImpl extends _OrderItemEntity {
  const _$OrderItemEntityImpl({
    required this.id,
    required this.menuItemId,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    final List<OrderItemCustomization>? customizations,
    this.notes,
  }) : _customizations = customizations,
       super._();

  @override
  final String id;
  @override
  final String menuItemId;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final int quantity;
  @override
  final String imageUrl;
  final List<OrderItemCustomization>? _customizations;
  @override
  List<OrderItemCustomization>? get customizations {
    final value = _customizations;
    if (value == null) return null;
    if (_customizations is EqualUnmodifiableListView) return _customizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'OrderItemEntity(id: $id, menuItemId: $menuItemId, name: $name, description: $description, price: $price, quantity: $quantity, imageUrl: $imageUrl, customizations: $customizations, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.menuItemId, menuItemId) ||
                other.menuItemId == menuItemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._customizations,
              _customizations,
            ) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    menuItemId,
    name,
    description,
    price,
    quantity,
    imageUrl,
    const DeepCollectionEquality().hash(_customizations),
    notes,
  );

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemEntityImplCopyWith<_$OrderItemEntityImpl> get copyWith =>
      __$$OrderItemEntityImplCopyWithImpl<_$OrderItemEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _OrderItemEntity extends OrderItemEntity {
  const factory _OrderItemEntity({
    required final String id,
    required final String menuItemId,
    required final String name,
    required final String description,
    required final double price,
    required final int quantity,
    required final String imageUrl,
    final List<OrderItemCustomization>? customizations,
    final String? notes,
  }) = _$OrderItemEntityImpl;
  const _OrderItemEntity._() : super._();

  @override
  String get id;
  @override
  String get menuItemId;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  int get quantity;
  @override
  String get imageUrl;
  @override
  List<OrderItemCustomization>? get customizations;
  @override
  String? get notes;

  /// Create a copy of OrderItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemEntityImplCopyWith<_$OrderItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderItemCustomization {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemCustomization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCustomizationCopyWith<OrderItemCustomization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCustomizationCopyWith<$Res> {
  factory $OrderItemCustomizationCopyWith(
    OrderItemCustomization value,
    $Res Function(OrderItemCustomization) then,
  ) = _$OrderItemCustomizationCopyWithImpl<$Res, OrderItemCustomization>;
  @useResult
  $Res call({String id, String name, double price});
}

/// @nodoc
class _$OrderItemCustomizationCopyWithImpl<
  $Res,
  $Val extends OrderItemCustomization
>
    implements $OrderItemCustomizationCopyWith<$Res> {
  _$OrderItemCustomizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemCustomization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? price = null}) {
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
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemCustomizationImplCopyWith<$Res>
    implements $OrderItemCustomizationCopyWith<$Res> {
  factory _$$OrderItemCustomizationImplCopyWith(
    _$OrderItemCustomizationImpl value,
    $Res Function(_$OrderItemCustomizationImpl) then,
  ) = __$$OrderItemCustomizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, double price});
}

/// @nodoc
class __$$OrderItemCustomizationImplCopyWithImpl<$Res>
    extends
        _$OrderItemCustomizationCopyWithImpl<$Res, _$OrderItemCustomizationImpl>
    implements _$$OrderItemCustomizationImplCopyWith<$Res> {
  __$$OrderItemCustomizationImplCopyWithImpl(
    _$OrderItemCustomizationImpl _value,
    $Res Function(_$OrderItemCustomizationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItemCustomization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? price = null}) {
    return _then(
      _$OrderItemCustomizationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$OrderItemCustomizationImpl implements _OrderItemCustomization {
  const _$OrderItemCustomizationImpl({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;

  @override
  String toString() {
    return 'OrderItemCustomization(id: $id, name: $name, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemCustomizationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, price);

  /// Create a copy of OrderItemCustomization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemCustomizationImplCopyWith<_$OrderItemCustomizationImpl>
  get copyWith =>
      __$$OrderItemCustomizationImplCopyWithImpl<_$OrderItemCustomizationImpl>(
        this,
        _$identity,
      );
}

abstract class _OrderItemCustomization implements OrderItemCustomization {
  const factory _OrderItemCustomization({
    required final String id,
    required final String name,
    required final double price,
  }) = _$OrderItemCustomizationImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;

  /// Create a copy of OrderItemCustomization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemCustomizationImplCopyWith<_$OrderItemCustomizationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
