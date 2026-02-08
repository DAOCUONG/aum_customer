import 'package:equatable/equatable.dart';

/// User entity representing the authenticated user
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isEmailVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool isEmailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Empty user entity
  static const empty = UserEntity(id: '');

  /// Check if user is empty
  bool get isEmpty => id.isEmpty;

  /// Check if user is not empty
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object?> get props => [
        id,
        email,
        displayName,
        photoUrl,
        phoneNumber,
        isEmailVerified,
        createdAt,
        updatedAt,
      ];

  UserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Sign-in credentials for email/password authentication
class SignInCredentials extends Equatable {
  const SignInCredentials({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  final String email;
  final String password;
  final bool rememberMe;

  @override
  List<Object> get props => [email, password, rememberMe];
}

/// Sign-up credentials for new user registration
class SignUpCredentials extends Equatable {
  const SignUpCredentials({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.displayName,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String? displayName;

  @override
  List<Object?> get props => [email, password, confirmPassword, displayName];
}
