// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoStats {
  int get total;
  int get completed;
  int get incompleted;

  /// Create a copy of TodoStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoStatsCopyWith<TodoStats> get copyWith =>
      _$TodoStatsCopyWithImpl<TodoStats>(this as TodoStats, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodoStats &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.incompleted, incompleted) ||
                other.incompleted == incompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, total, completed, incompleted);

  @override
  String toString() {
    return 'TodoStats(total: $total, completed: $completed, incompleted: $incompleted)';
  }
}

/// @nodoc
abstract mixin class $TodoStatsCopyWith<$Res> {
  factory $TodoStatsCopyWith(TodoStats value, $Res Function(TodoStats) _then) =
      _$TodoStatsCopyWithImpl;
  @useResult
  $Res call({int total, int completed, int incompleted});
}

/// @nodoc
class _$TodoStatsCopyWithImpl<$Res> implements $TodoStatsCopyWith<$Res> {
  _$TodoStatsCopyWithImpl(this._self, this._then);

  final TodoStats _self;
  final $Res Function(TodoStats) _then;

  /// Create a copy of TodoStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? completed = null,
    Object? incompleted = null,
  }) {
    return _then(_self.copyWith(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      incompleted: null == incompleted
          ? _self.incompleted
          : incompleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [TodoStats].
extension TodoStatsPatterns on TodoStats {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TodoStats value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodoStats() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TodoStats value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodoStats():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TodoStats value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodoStats() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int total, int completed, int incompleted)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TodoStats() when $default != null:
        return $default(_that.total, _that.completed, _that.incompleted);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int total, int completed, int incompleted) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodoStats():
        return $default(_that.total, _that.completed, _that.incompleted);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int total, int completed, int incompleted)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TodoStats() when $default != null:
        return $default(_that.total, _that.completed, _that.incompleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TodoStats implements TodoStats {
  const _TodoStats(
      {required this.total,
      required this.completed,
      required this.incompleted});

  @override
  final int total;
  @override
  final int completed;
  @override
  final int incompleted;

  /// Create a copy of TodoStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodoStatsCopyWith<_TodoStats> get copyWith =>
      __$TodoStatsCopyWithImpl<_TodoStats>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodoStats &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.incompleted, incompleted) ||
                other.incompleted == incompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, total, completed, incompleted);

  @override
  String toString() {
    return 'TodoStats(total: $total, completed: $completed, incompleted: $incompleted)';
  }
}

/// @nodoc
abstract mixin class _$TodoStatsCopyWith<$Res>
    implements $TodoStatsCopyWith<$Res> {
  factory _$TodoStatsCopyWith(
          _TodoStats value, $Res Function(_TodoStats) _then) =
      __$TodoStatsCopyWithImpl;
  @override
  @useResult
  $Res call({int total, int completed, int incompleted});
}

/// @nodoc
class __$TodoStatsCopyWithImpl<$Res> implements _$TodoStatsCopyWith<$Res> {
  __$TodoStatsCopyWithImpl(this._self, this._then);

  final _TodoStats _self;
  final $Res Function(_TodoStats) _then;

  /// Create a copy of TodoStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? total = null,
    Object? completed = null,
    Object? incompleted = null,
  }) {
    return _then(_TodoStats(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      incompleted: null == incompleted
          ? _self.incompleted
          : incompleted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
