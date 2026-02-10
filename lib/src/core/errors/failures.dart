import 'package:equatable/equatable.dart';

/// Base failure class for all application failures
abstract class Failure with EquatableMixin {
  const Failure({
    required this.message,
    this.code,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, code, stackTrace];
}

/// Server-side failures (4xx, 5xx HTTP errors)
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.statusCode,
  }) : super();

  final int? statusCode;

  @override
  List<Object?> get props => [message, code, stackTrace, statusCode];
}

/// Network failures (no internet, timeouts)
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.wasRetried = false,
  }) : super();

  final bool wasRetried;

  @override
  List<Object?> get props => [message, code, stackTrace, wasRetried];
}

/// Validation failures (invalid input, missing fields)
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.field = 'unknown',
  }) : super();

  final String field;

  @override
  List<Object?> get props => [message, code, stackTrace, field];
}

/// Authentication failures (invalid credentials, token expired)
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.errorType = AuthErrorType.unknown,
  }) : super();

  final AuthErrorType errorType;

  @override
  List<Object?> get props => [message, code, stackTrace, errorType];
}

enum AuthErrorType {
  invalidCredentials,
  tokenExpired,
  userNotFound,
  accountLocked,
  networkError,
  unknown,
}

/// Permission failures (location denied, etc.)
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.permissionType = 'unknown',
  }) : super();

  final String permissionType;

  @override
  List<Object?> get props => [message, code, stackTrace, permissionType];
}

/// Cache failures (local storage errors)
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.stackTrace,
  }) : super();
}

/// Not found failures (404 errors)
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code,
    super.stackTrace,
  }) : super();
}

/// Unexpected failures (null pointer, type errors)
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.code,
    super.stackTrace,
  }) : super();
}

/// Extension methods for convenient error handling
extension FailureX on Failure {
  bool get isNetwork => this is NetworkFailure;
  bool get isServer => this is ServerFailure;
  bool get isValidation => this is ValidationFailure;
  bool get isAuth => this is AuthFailure;
  bool get isPermission => this is PermissionFailure;
  bool get isCache => this is CacheFailure;
  bool get isUnexpected => this is UnexpectedFailure;
}
