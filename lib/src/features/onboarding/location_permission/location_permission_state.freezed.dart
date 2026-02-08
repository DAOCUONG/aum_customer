// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LocationPermissionState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isGranted => throw _privateConstructorUsedError;
  bool get isPermanentlyDenied => throw _privateConstructorUsedError;
  bool get isDenied => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of LocationPermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationPermissionStateCopyWith<LocationPermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPermissionStateCopyWith<$Res> {
  factory $LocationPermissionStateCopyWith(
    LocationPermissionState value,
    $Res Function(LocationPermissionState) then,
  ) = _$LocationPermissionStateCopyWithImpl<$Res, LocationPermissionState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isGranted,
    bool isPermanentlyDenied,
    bool isDenied,
    String? errorMessage,
  });
}

/// @nodoc
class _$LocationPermissionStateCopyWithImpl<
  $Res,
  $Val extends LocationPermissionState
>
    implements $LocationPermissionStateCopyWith<$Res> {
  _$LocationPermissionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationPermissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isGranted = null,
    Object? isPermanentlyDenied = null,
    Object? isDenied = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isGranted: null == isGranted
                ? _value.isGranted
                : isGranted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPermanentlyDenied: null == isPermanentlyDenied
                ? _value.isPermanentlyDenied
                : isPermanentlyDenied // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDenied: null == isDenied
                ? _value.isDenied
                : isDenied // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationPermissionStateImplCopyWith<$Res>
    implements $LocationPermissionStateCopyWith<$Res> {
  factory _$$LocationPermissionStateImplCopyWith(
    _$LocationPermissionStateImpl value,
    $Res Function(_$LocationPermissionStateImpl) then,
  ) = __$$LocationPermissionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isGranted,
    bool isPermanentlyDenied,
    bool isDenied,
    String? errorMessage,
  });
}

/// @nodoc
class __$$LocationPermissionStateImplCopyWithImpl<$Res>
    extends
        _$LocationPermissionStateCopyWithImpl<
          $Res,
          _$LocationPermissionStateImpl
        >
    implements _$$LocationPermissionStateImplCopyWith<$Res> {
  __$$LocationPermissionStateImplCopyWithImpl(
    _$LocationPermissionStateImpl _value,
    $Res Function(_$LocationPermissionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationPermissionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isGranted = null,
    Object? isPermanentlyDenied = null,
    Object? isDenied = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$LocationPermissionStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isGranted: null == isGranted
            ? _value.isGranted
            : isGranted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPermanentlyDenied: null == isPermanentlyDenied
            ? _value.isPermanentlyDenied
            : isPermanentlyDenied // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDenied: null == isDenied
            ? _value.isDenied
            : isDenied // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LocationPermissionStateImpl implements _LocationPermissionState {
  const _$LocationPermissionStateImpl({
    this.isLoading = false,
    this.isGranted = false,
    this.isPermanentlyDenied = false,
    this.isDenied = false,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isGranted;
  @override
  @JsonKey()
  final bool isPermanentlyDenied;
  @override
  @JsonKey()
  final bool isDenied;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'LocationPermissionState(isLoading: $isLoading, isGranted: $isGranted, isPermanentlyDenied: $isPermanentlyDenied, isDenied: $isDenied, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPermissionStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isGranted, isGranted) ||
                other.isGranted == isGranted) &&
            (identical(other.isPermanentlyDenied, isPermanentlyDenied) ||
                other.isPermanentlyDenied == isPermanentlyDenied) &&
            (identical(other.isDenied, isDenied) ||
                other.isDenied == isDenied) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isGranted,
    isPermanentlyDenied,
    isDenied,
    errorMessage,
  );

  /// Create a copy of LocationPermissionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPermissionStateImplCopyWith<_$LocationPermissionStateImpl>
  get copyWith =>
      __$$LocationPermissionStateImplCopyWithImpl<
        _$LocationPermissionStateImpl
      >(this, _$identity);
}

abstract class _LocationPermissionState implements LocationPermissionState {
  const factory _LocationPermissionState({
    final bool isLoading,
    final bool isGranted,
    final bool isPermanentlyDenied,
    final bool isDenied,
    final String? errorMessage,
  }) = _$LocationPermissionStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isGranted;
  @override
  bool get isPermanentlyDenied;
  @override
  bool get isDenied;
  @override
  String? get errorMessage;

  /// Create a copy of LocationPermissionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationPermissionStateImplCopyWith<_$LocationPermissionStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
