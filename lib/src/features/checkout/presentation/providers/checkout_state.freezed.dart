// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckoutState {
  CheckoutStatus get status => throw _privateConstructorUsedError;
  DeliveryAddressEntity? get deliveryAddress =>
      throw _privateConstructorUsedError;
  PaymentMethodEntity? get paymentMethod => throw _privateConstructorUsedError;
  List<PaymentMethodEntity> get paymentMethods =>
      throw _privateConstructorUsedError;
  List<DeliveryAddressEntity> get savedAddresses =>
      throw _privateConstructorUsedError;
  String get promoCode => throw _privateConstructorUsedError;
  double get promoDiscount => throw _privateConstructorUsedError;
  String get promoErrorMessage => throw _privateConstructorUsedError;
  bool get isApplyingPromo => throw _privateConstructorUsedError;
  int get selectedTipIndex => throw _privateConstructorUsedError;
  List<int> get tipPercentages => throw _privateConstructorUsedError;
  bool get leaveAtDoor => throw _privateConstructorUsedError;
  bool get priorityDelivery => throw _privateConstructorUsedError;
  String get deliveryInstructions => throw _privateConstructorUsedError;
  double get priorityFee => throw _privateConstructorUsedError;
  double get tipAmount => throw _privateConstructorUsedError;
  OrderEntity? get order => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CheckoutStateCopyWith<CheckoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
    CheckoutState value,
    $Res Function(CheckoutState) then,
  ) = _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
  @useResult
  $Res call({
    CheckoutStatus status,
    DeliveryAddressEntity? deliveryAddress,
    PaymentMethodEntity? paymentMethod,
    List<PaymentMethodEntity> paymentMethods,
    List<DeliveryAddressEntity> savedAddresses,
    String promoCode,
    double promoDiscount,
    String promoErrorMessage,
    bool isApplyingPromo,
    int selectedTipIndex,
    List<int> tipPercentages,
    bool leaveAtDoor,
    bool priorityDelivery,
    String deliveryInstructions,
    double priorityFee,
    double tipAmount,
    OrderEntity? order,
    String? errorMessage,
  });

  $DeliveryAddressEntityCopyWith<$Res>? get deliveryAddress;
  $PaymentMethodEntityCopyWith<$Res>? get paymentMethod;
  $OrderEntityCopyWith<$Res>? get order;
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? deliveryAddress = freezed,
    Object? paymentMethod = freezed,
    Object? paymentMethods = null,
    Object? savedAddresses = null,
    Object? promoCode = null,
    Object? promoDiscount = null,
    Object? promoErrorMessage = null,
    Object? isApplyingPromo = null,
    Object? selectedTipIndex = null,
    Object? tipPercentages = null,
    Object? leaveAtDoor = null,
    Object? priorityDelivery = null,
    Object? deliveryInstructions = null,
    Object? priorityFee = null,
    Object? tipAmount = null,
    Object? order = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CheckoutStatus,
            deliveryAddress: freezed == deliveryAddress
                ? _value.deliveryAddress
                : deliveryAddress // ignore: cast_nullable_to_non_nullable
                      as DeliveryAddressEntity?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethodEntity?,
            paymentMethods: null == paymentMethods
                ? _value.paymentMethods
                : paymentMethods // ignore: cast_nullable_to_non_nullable
                      as List<PaymentMethodEntity>,
            savedAddresses: null == savedAddresses
                ? _value.savedAddresses
                : savedAddresses // ignore: cast_nullable_to_non_nullable
                      as List<DeliveryAddressEntity>,
            promoCode: null == promoCode
                ? _value.promoCode
                : promoCode // ignore: cast_nullable_to_non_nullable
                      as String,
            promoDiscount: null == promoDiscount
                ? _value.promoDiscount
                : promoDiscount // ignore: cast_nullable_to_non_nullable
                      as double,
            promoErrorMessage: null == promoErrorMessage
                ? _value.promoErrorMessage
                : promoErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            isApplyingPromo: null == isApplyingPromo
                ? _value.isApplyingPromo
                : isApplyingPromo // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedTipIndex: null == selectedTipIndex
                ? _value.selectedTipIndex
                : selectedTipIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            tipPercentages: null == tipPercentages
                ? _value.tipPercentages
                : tipPercentages // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            leaveAtDoor: null == leaveAtDoor
                ? _value.leaveAtDoor
                : leaveAtDoor // ignore: cast_nullable_to_non_nullable
                      as bool,
            priorityDelivery: null == priorityDelivery
                ? _value.priorityDelivery
                : priorityDelivery // ignore: cast_nullable_to_non_nullable
                      as bool,
            deliveryInstructions: null == deliveryInstructions
                ? _value.deliveryInstructions
                : deliveryInstructions // ignore: cast_nullable_to_non_nullable
                      as String,
            priorityFee: null == priorityFee
                ? _value.priorityFee
                : priorityFee // ignore: cast_nullable_to_non_nullable
                      as double,
            tipAmount: null == tipAmount
                ? _value.tipAmount
                : tipAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as OrderEntity?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliveryAddressEntityCopyWith<$Res>? get deliveryAddress {
    if (_value.deliveryAddress == null) {
      return null;
    }

    return $DeliveryAddressEntityCopyWith<$Res>(_value.deliveryAddress!, (
      value,
    ) {
      return _then(_value.copyWith(deliveryAddress: value) as $Val);
    });
  }

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodEntityCopyWith<$Res>? get paymentMethod {
    if (_value.paymentMethod == null) {
      return null;
    }

    return $PaymentMethodEntityCopyWith<$Res>(_value.paymentMethod!, (value) {
      return _then(_value.copyWith(paymentMethod: value) as $Val);
    });
  }

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderEntityCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderEntityCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
    _$CheckoutStateImpl value,
    $Res Function(_$CheckoutStateImpl) then,
  ) = __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    CheckoutStatus status,
    DeliveryAddressEntity? deliveryAddress,
    PaymentMethodEntity? paymentMethod,
    List<PaymentMethodEntity> paymentMethods,
    List<DeliveryAddressEntity> savedAddresses,
    String promoCode,
    double promoDiscount,
    String promoErrorMessage,
    bool isApplyingPromo,
    int selectedTipIndex,
    List<int> tipPercentages,
    bool leaveAtDoor,
    bool priorityDelivery,
    String deliveryInstructions,
    double priorityFee,
    double tipAmount,
    OrderEntity? order,
    String? errorMessage,
  });

  @override
  $DeliveryAddressEntityCopyWith<$Res>? get deliveryAddress;
  @override
  $PaymentMethodEntityCopyWith<$Res>? get paymentMethod;
  @override
  $OrderEntityCopyWith<$Res>? get order;
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
    _$CheckoutStateImpl _value,
    $Res Function(_$CheckoutStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? deliveryAddress = freezed,
    Object? paymentMethod = freezed,
    Object? paymentMethods = null,
    Object? savedAddresses = null,
    Object? promoCode = null,
    Object? promoDiscount = null,
    Object? promoErrorMessage = null,
    Object? isApplyingPromo = null,
    Object? selectedTipIndex = null,
    Object? tipPercentages = null,
    Object? leaveAtDoor = null,
    Object? priorityDelivery = null,
    Object? deliveryInstructions = null,
    Object? priorityFee = null,
    Object? tipAmount = null,
    Object? order = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CheckoutStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CheckoutStatus,
        deliveryAddress: freezed == deliveryAddress
            ? _value.deliveryAddress
            : deliveryAddress // ignore: cast_nullable_to_non_nullable
                  as DeliveryAddressEntity?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethodEntity?,
        paymentMethods: null == paymentMethods
            ? _value._paymentMethods
            : paymentMethods // ignore: cast_nullable_to_non_nullable
                  as List<PaymentMethodEntity>,
        savedAddresses: null == savedAddresses
            ? _value._savedAddresses
            : savedAddresses // ignore: cast_nullable_to_non_nullable
                  as List<DeliveryAddressEntity>,
        promoCode: null == promoCode
            ? _value.promoCode
            : promoCode // ignore: cast_nullable_to_non_nullable
                  as String,
        promoDiscount: null == promoDiscount
            ? _value.promoDiscount
            : promoDiscount // ignore: cast_nullable_to_non_nullable
                  as double,
        promoErrorMessage: null == promoErrorMessage
            ? _value.promoErrorMessage
            : promoErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        isApplyingPromo: null == isApplyingPromo
            ? _value.isApplyingPromo
            : isApplyingPromo // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedTipIndex: null == selectedTipIndex
            ? _value.selectedTipIndex
            : selectedTipIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        tipPercentages: null == tipPercentages
            ? _value._tipPercentages
            : tipPercentages // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        leaveAtDoor: null == leaveAtDoor
            ? _value.leaveAtDoor
            : leaveAtDoor // ignore: cast_nullable_to_non_nullable
                  as bool,
        priorityDelivery: null == priorityDelivery
            ? _value.priorityDelivery
            : priorityDelivery // ignore: cast_nullable_to_non_nullable
                  as bool,
        deliveryInstructions: null == deliveryInstructions
            ? _value.deliveryInstructions
            : deliveryInstructions // ignore: cast_nullable_to_non_nullable
                  as String,
        priorityFee: null == priorityFee
            ? _value.priorityFee
            : priorityFee // ignore: cast_nullable_to_non_nullable
                  as double,
        tipAmount: null == tipAmount
            ? _value.tipAmount
            : tipAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as OrderEntity?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CheckoutStateImpl extends _CheckoutState {
  const _$CheckoutStateImpl({
    this.status = CheckoutStatus.initial,
    this.deliveryAddress,
    this.paymentMethod,
    final List<PaymentMethodEntity> paymentMethods = const [],
    final List<DeliveryAddressEntity> savedAddresses = const [],
    this.promoCode = '',
    this.promoDiscount = 0.0,
    this.promoErrorMessage = '',
    this.isApplyingPromo = false,
    this.selectedTipIndex = 0,
    final List<int> tipPercentages = const [10, 15, 18, 20],
    this.leaveAtDoor = false,
    this.priorityDelivery = false,
    this.deliveryInstructions = '',
    this.priorityFee = 0.0,
    this.tipAmount = 0.0,
    this.order,
    this.errorMessage,
  }) : _paymentMethods = paymentMethods,
       _savedAddresses = savedAddresses,
       _tipPercentages = tipPercentages,
       super._();

  @override
  @JsonKey()
  final CheckoutStatus status;
  @override
  final DeliveryAddressEntity? deliveryAddress;
  @override
  final PaymentMethodEntity? paymentMethod;
  final List<PaymentMethodEntity> _paymentMethods;
  @override
  @JsonKey()
  List<PaymentMethodEntity> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  final List<DeliveryAddressEntity> _savedAddresses;
  @override
  @JsonKey()
  List<DeliveryAddressEntity> get savedAddresses {
    if (_savedAddresses is EqualUnmodifiableListView) return _savedAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedAddresses);
  }

  @override
  @JsonKey()
  final String promoCode;
  @override
  @JsonKey()
  final double promoDiscount;
  @override
  @JsonKey()
  final String promoErrorMessage;
  @override
  @JsonKey()
  final bool isApplyingPromo;
  @override
  @JsonKey()
  final int selectedTipIndex;
  final List<int> _tipPercentages;
  @override
  @JsonKey()
  List<int> get tipPercentages {
    if (_tipPercentages is EqualUnmodifiableListView) return _tipPercentages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tipPercentages);
  }

  @override
  @JsonKey()
  final bool leaveAtDoor;
  @override
  @JsonKey()
  final bool priorityDelivery;
  @override
  @JsonKey()
  final String deliveryInstructions;
  @override
  @JsonKey()
  final double priorityFee;
  @override
  @JsonKey()
  final double tipAmount;
  @override
  final OrderEntity? order;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CheckoutState(status: $status, deliveryAddress: $deliveryAddress, paymentMethod: $paymentMethod, paymentMethods: $paymentMethods, savedAddresses: $savedAddresses, promoCode: $promoCode, promoDiscount: $promoDiscount, promoErrorMessage: $promoErrorMessage, isApplyingPromo: $isApplyingPromo, selectedTipIndex: $selectedTipIndex, tipPercentages: $tipPercentages, leaveAtDoor: $leaveAtDoor, priorityDelivery: $priorityDelivery, deliveryInstructions: $deliveryInstructions, priorityFee: $priorityFee, tipAmount: $tipAmount, order: $order, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveryAddress, deliveryAddress) ||
                other.deliveryAddress == deliveryAddress) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(
              other._paymentMethods,
              _paymentMethods,
            ) &&
            const DeepCollectionEquality().equals(
              other._savedAddresses,
              _savedAddresses,
            ) &&
            (identical(other.promoCode, promoCode) ||
                other.promoCode == promoCode) &&
            (identical(other.promoDiscount, promoDiscount) ||
                other.promoDiscount == promoDiscount) &&
            (identical(other.promoErrorMessage, promoErrorMessage) ||
                other.promoErrorMessage == promoErrorMessage) &&
            (identical(other.isApplyingPromo, isApplyingPromo) ||
                other.isApplyingPromo == isApplyingPromo) &&
            (identical(other.selectedTipIndex, selectedTipIndex) ||
                other.selectedTipIndex == selectedTipIndex) &&
            const DeepCollectionEquality().equals(
              other._tipPercentages,
              _tipPercentages,
            ) &&
            (identical(other.leaveAtDoor, leaveAtDoor) ||
                other.leaveAtDoor == leaveAtDoor) &&
            (identical(other.priorityDelivery, priorityDelivery) ||
                other.priorityDelivery == priorityDelivery) &&
            (identical(other.deliveryInstructions, deliveryInstructions) ||
                other.deliveryInstructions == deliveryInstructions) &&
            (identical(other.priorityFee, priorityFee) ||
                other.priorityFee == priorityFee) &&
            (identical(other.tipAmount, tipAmount) ||
                other.tipAmount == tipAmount) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    deliveryAddress,
    paymentMethod,
    const DeepCollectionEquality().hash(_paymentMethods),
    const DeepCollectionEquality().hash(_savedAddresses),
    promoCode,
    promoDiscount,
    promoErrorMessage,
    isApplyingPromo,
    selectedTipIndex,
    const DeepCollectionEquality().hash(_tipPercentages),
    leaveAtDoor,
    priorityDelivery,
    deliveryInstructions,
    priorityFee,
    tipAmount,
    order,
    errorMessage,
  );

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState extends CheckoutState {
  const factory _CheckoutState({
    final CheckoutStatus status,
    final DeliveryAddressEntity? deliveryAddress,
    final PaymentMethodEntity? paymentMethod,
    final List<PaymentMethodEntity> paymentMethods,
    final List<DeliveryAddressEntity> savedAddresses,
    final String promoCode,
    final double promoDiscount,
    final String promoErrorMessage,
    final bool isApplyingPromo,
    final int selectedTipIndex,
    final List<int> tipPercentages,
    final bool leaveAtDoor,
    final bool priorityDelivery,
    final String deliveryInstructions,
    final double priorityFee,
    final double tipAmount,
    final OrderEntity? order,
    final String? errorMessage,
  }) = _$CheckoutStateImpl;
  const _CheckoutState._() : super._();

  @override
  CheckoutStatus get status;
  @override
  DeliveryAddressEntity? get deliveryAddress;
  @override
  PaymentMethodEntity? get paymentMethod;
  @override
  List<PaymentMethodEntity> get paymentMethods;
  @override
  List<DeliveryAddressEntity> get savedAddresses;
  @override
  String get promoCode;
  @override
  double get promoDiscount;
  @override
  String get promoErrorMessage;
  @override
  bool get isApplyingPromo;
  @override
  int get selectedTipIndex;
  @override
  List<int> get tipPercentages;
  @override
  bool get leaveAtDoor;
  @override
  bool get priorityDelivery;
  @override
  String get deliveryInstructions;
  @override
  double get priorityFee;
  @override
  double get tipAmount;
  @override
  OrderEntity? get order;
  @override
  String? get errorMessage;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DeliverySlotState {
  DeliverySlotStatus get status => throw _privateConstructorUsedError;
  List<DeliverySlotEntity> get slots => throw _privateConstructorUsedError;
  DeliverySlotEntity? get selectedSlot => throw _privateConstructorUsedError;
  String get deliveryInstructions => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of DeliverySlotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeliverySlotStateCopyWith<DeliverySlotState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeliverySlotStateCopyWith<$Res> {
  factory $DeliverySlotStateCopyWith(
    DeliverySlotState value,
    $Res Function(DeliverySlotState) then,
  ) = _$DeliverySlotStateCopyWithImpl<$Res, DeliverySlotState>;
  @useResult
  $Res call({
    DeliverySlotStatus status,
    List<DeliverySlotEntity> slots,
    DeliverySlotEntity? selectedSlot,
    String deliveryInstructions,
    String? errorMessage,
  });

  $DeliverySlotEntityCopyWith<$Res>? get selectedSlot;
}

/// @nodoc
class _$DeliverySlotStateCopyWithImpl<$Res, $Val extends DeliverySlotState>
    implements $DeliverySlotStateCopyWith<$Res> {
  _$DeliverySlotStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeliverySlotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? slots = null,
    Object? selectedSlot = freezed,
    Object? deliveryInstructions = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DeliverySlotStatus,
            slots: null == slots
                ? _value.slots
                : slots // ignore: cast_nullable_to_non_nullable
                      as List<DeliverySlotEntity>,
            selectedSlot: freezed == selectedSlot
                ? _value.selectedSlot
                : selectedSlot // ignore: cast_nullable_to_non_nullable
                      as DeliverySlotEntity?,
            deliveryInstructions: null == deliveryInstructions
                ? _value.deliveryInstructions
                : deliveryInstructions // ignore: cast_nullable_to_non_nullable
                      as String,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of DeliverySlotState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeliverySlotEntityCopyWith<$Res>? get selectedSlot {
    if (_value.selectedSlot == null) {
      return null;
    }

    return $DeliverySlotEntityCopyWith<$Res>(_value.selectedSlot!, (value) {
      return _then(_value.copyWith(selectedSlot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeliverySlotStateImplCopyWith<$Res>
    implements $DeliverySlotStateCopyWith<$Res> {
  factory _$$DeliverySlotStateImplCopyWith(
    _$DeliverySlotStateImpl value,
    $Res Function(_$DeliverySlotStateImpl) then,
  ) = __$$DeliverySlotStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DeliverySlotStatus status,
    List<DeliverySlotEntity> slots,
    DeliverySlotEntity? selectedSlot,
    String deliveryInstructions,
    String? errorMessage,
  });

  @override
  $DeliverySlotEntityCopyWith<$Res>? get selectedSlot;
}

/// @nodoc
class __$$DeliverySlotStateImplCopyWithImpl<$Res>
    extends _$DeliverySlotStateCopyWithImpl<$Res, _$DeliverySlotStateImpl>
    implements _$$DeliverySlotStateImplCopyWith<$Res> {
  __$$DeliverySlotStateImplCopyWithImpl(
    _$DeliverySlotStateImpl _value,
    $Res Function(_$DeliverySlotStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeliverySlotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? slots = null,
    Object? selectedSlot = freezed,
    Object? deliveryInstructions = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$DeliverySlotStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DeliverySlotStatus,
        slots: null == slots
            ? _value._slots
            : slots // ignore: cast_nullable_to_non_nullable
                  as List<DeliverySlotEntity>,
        selectedSlot: freezed == selectedSlot
            ? _value.selectedSlot
            : selectedSlot // ignore: cast_nullable_to_non_nullable
                  as DeliverySlotEntity?,
        deliveryInstructions: null == deliveryInstructions
            ? _value.deliveryInstructions
            : deliveryInstructions // ignore: cast_nullable_to_non_nullable
                  as String,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DeliverySlotStateImpl extends _DeliverySlotState {
  const _$DeliverySlotStateImpl({
    this.status = DeliverySlotStatus.initial,
    final List<DeliverySlotEntity> slots = const [],
    this.selectedSlot,
    this.deliveryInstructions = '',
    this.errorMessage,
  }) : _slots = slots,
       super._();

  @override
  @JsonKey()
  final DeliverySlotStatus status;
  final List<DeliverySlotEntity> _slots;
  @override
  @JsonKey()
  List<DeliverySlotEntity> get slots {
    if (_slots is EqualUnmodifiableListView) return _slots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  @override
  final DeliverySlotEntity? selectedSlot;
  @override
  @JsonKey()
  final String deliveryInstructions;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'DeliverySlotState(status: $status, slots: $slots, selectedSlot: $selectedSlot, deliveryInstructions: $deliveryInstructions, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliverySlotStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._slots, _slots) &&
            (identical(other.selectedSlot, selectedSlot) ||
                other.selectedSlot == selectedSlot) &&
            (identical(other.deliveryInstructions, deliveryInstructions) ||
                other.deliveryInstructions == deliveryInstructions) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_slots),
    selectedSlot,
    deliveryInstructions,
    errorMessage,
  );

  /// Create a copy of DeliverySlotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliverySlotStateImplCopyWith<_$DeliverySlotStateImpl> get copyWith =>
      __$$DeliverySlotStateImplCopyWithImpl<_$DeliverySlotStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DeliverySlotState extends DeliverySlotState {
  const factory _DeliverySlotState({
    final DeliverySlotStatus status,
    final List<DeliverySlotEntity> slots,
    final DeliverySlotEntity? selectedSlot,
    final String deliveryInstructions,
    final String? errorMessage,
  }) = _$DeliverySlotStateImpl;
  const _DeliverySlotState._() : super._();

  @override
  DeliverySlotStatus get status;
  @override
  List<DeliverySlotEntity> get slots;
  @override
  DeliverySlotEntity? get selectedSlot;
  @override
  String get deliveryInstructions;
  @override
  String? get errorMessage;

  /// Create a copy of DeliverySlotState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliverySlotStateImplCopyWith<_$DeliverySlotStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderConfirmationState {
  OrderStatusEnum get status => throw _privateConstructorUsedError;
  OrderEntity? get order => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of OrderConfirmationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderConfirmationStateCopyWith<OrderConfirmationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderConfirmationStateCopyWith<$Res> {
  factory $OrderConfirmationStateCopyWith(
    OrderConfirmationState value,
    $Res Function(OrderConfirmationState) then,
  ) = _$OrderConfirmationStateCopyWithImpl<$Res, OrderConfirmationState>;
  @useResult
  $Res call({OrderStatusEnum status, OrderEntity? order, String? errorMessage});

  $OrderEntityCopyWith<$Res>? get order;
}

/// @nodoc
class _$OrderConfirmationStateCopyWithImpl<
  $Res,
  $Val extends OrderConfirmationState
>
    implements $OrderConfirmationStateCopyWith<$Res> {
  _$OrderConfirmationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderConfirmationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? order = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OrderStatusEnum,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as OrderEntity?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of OrderConfirmationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderEntityCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderEntityCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderConfirmationStateImplCopyWith<$Res>
    implements $OrderConfirmationStateCopyWith<$Res> {
  factory _$$OrderConfirmationStateImplCopyWith(
    _$OrderConfirmationStateImpl value,
    $Res Function(_$OrderConfirmationStateImpl) then,
  ) = __$$OrderConfirmationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({OrderStatusEnum status, OrderEntity? order, String? errorMessage});

  @override
  $OrderEntityCopyWith<$Res>? get order;
}

/// @nodoc
class __$$OrderConfirmationStateImplCopyWithImpl<$Res>
    extends
        _$OrderConfirmationStateCopyWithImpl<$Res, _$OrderConfirmationStateImpl>
    implements _$$OrderConfirmationStateImplCopyWith<$Res> {
  __$$OrderConfirmationStateImplCopyWithImpl(
    _$OrderConfirmationStateImpl _value,
    $Res Function(_$OrderConfirmationStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderConfirmationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? order = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$OrderConfirmationStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OrderStatusEnum,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as OrderEntity?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OrderConfirmationStateImpl extends _OrderConfirmationState {
  const _$OrderConfirmationStateImpl({
    this.status = OrderStatusEnum.initial,
    this.order,
    this.errorMessage,
  }) : super._();

  @override
  @JsonKey()
  final OrderStatusEnum status;
  @override
  final OrderEntity? order;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'OrderConfirmationState(status: $status, order: $order, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderConfirmationStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, order, errorMessage);

  /// Create a copy of OrderConfirmationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderConfirmationStateImplCopyWith<_$OrderConfirmationStateImpl>
  get copyWith =>
      __$$OrderConfirmationStateImplCopyWithImpl<_$OrderConfirmationStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OrderConfirmationState extends OrderConfirmationState {
  const factory _OrderConfirmationState({
    final OrderStatusEnum status,
    final OrderEntity? order,
    final String? errorMessage,
  }) = _$OrderConfirmationStateImpl;
  const _OrderConfirmationState._() : super._();

  @override
  OrderStatusEnum get status;
  @override
  OrderEntity? get order;
  @override
  String? get errorMessage;

  /// Create a copy of OrderConfirmationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderConfirmationStateImplCopyWith<_$OrderConfirmationStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
