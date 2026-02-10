import '../../domain/entities/cart_entity.dart';

/// State for the shopping cart screen
class CartState {
  final CartStatus status;
  final CartEntity? cart;
  final String errorMessage;
  final bool isApplyingPromo;

  CartState({
    CartStatus? status,
    this.cart,
    String? errorMessage,
    bool? isApplyingPromo,
  })  : status = status ?? CartStatus.initial,
        errorMessage = errorMessage ?? '',
        isApplyingPromo = isApplyingPromo ?? false;

  const CartState._internal({
    this.status = CartStatus.initial,
    this.cart,
    this.errorMessage = '',
    this.isApplyingPromo = false,
  });

  const CartState.initial() : this._internal();

  CartState copyWith({
    CartStatus? status,
    CartEntity? cart,
    String? errorMessage,
    bool? isApplyingPromo,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      errorMessage: errorMessage ?? this.errorMessage,
      isApplyingPromo: isApplyingPromo ?? this.isApplyingPromo,
    );
  }

  bool get isLoading => status == CartStatus.loading;
  bool get isLoaded => status == CartStatus.loaded;
  bool get isEmpty => status == CartStatus.empty;
  bool get isError => status == CartStatus.error;

  List<dynamic> get items => cart?.items ?? [];
  int get totalItems => cart?.totalItemCount ?? 0;
  double get subtotal => cart?.subtotal ?? 0.0;
  double get deliveryFee => cart?.deliveryFee ?? 0.0;
  double get tax => cart?.tax ?? 0.0;
  double get total => cart?.total ?? 0.0;
  String? get promoCode => cart?.promoCode;
  double get discount => cart?.discountAmount ?? 0.0;
}

/// Status of the cart
enum CartStatus {
  initial,
  loading,
  loaded,
  empty,
  error,
}
