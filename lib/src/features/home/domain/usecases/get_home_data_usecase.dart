import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../repository/home_repository_interface.dart';

/// Use case for fetching all home data in a single optimized call
class GetHomeDataUseCase {
  final HomeRepositoryInterface _repository;

  GetHomeDataUseCase({required HomeRepositoryInterface repository})
      : _repository = repository;

  /// Executes the use case to fetch all home data
  ///
  /// Returns [HomeData] wrapped in [TaskEither] for proper error handling
  TaskEither<Failure, HomeData> call() {
    return _repository.getHomeData();
  }
}
