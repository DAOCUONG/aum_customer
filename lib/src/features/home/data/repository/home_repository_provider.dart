import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repository/home_repository_interface.dart';
import 'home_repository_impl.dart';

part 'home_repository_provider.g.dart';

/// Provider for [HomeRepositoryImpl] instance.
///
/// This provider is used for dependency injection in [HomeNotifier].
@riverpod
HomeRepositoryInterface homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}
