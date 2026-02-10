import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/cart_repository_impl.dart';
import '../../domain/repository/cart_repository_interface.dart';

part 'providers.g.dart';

/// Provider for CartRepositoryInterface
@riverpod
CartRepositoryInterface cartRepository(CartRepositoryRef ref) {
  return CartRepositoryImpl();
}

/// Provider for MenuRepositoryInterface
@riverpod
MenuRepositoryInterface menuRepository(MenuRepositoryRef ref) {
  return MenuRepositoryImpl();
}
