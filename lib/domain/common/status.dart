import 'package:jogingu_advanced/domain/common/failure.dart';

abstract class Status<T> {
  /// Returns `true` if the object is of the [Loading] type, which means
  /// `data` is fetching from remote or database.
  bool get isLoading => this is Loading<T>;

  /// Returns `true` if the object is of the [Success] type, which means
  /// `data` will return a valid result.
  bool get isSuccess => this is Success<T>;

  /// Returns `true` if the object is of the [Error] type, which means
  /// `error` will return a valid result.
  bool get isError => this is Error<T>;

  /// Get [data] value, returns null when the value is actually [error]
  T? get data => isSuccess ? (this as Success)._data : null;

  /// Get [errorMessage] value, returns null when the value is actually [data]
  Failure? get error => isError ? (this as Error)._error : null;

  /// handle status:
  /// return [onIdle] if object is of the [Idle] type.
  /// return [onLoading] if object is of the [Loading] type.
  /// return [onSuccess] if object is of the [Success] type.
  /// return [onError] if object is of the [Error] type.
  ///
  /// if `R` is of [Widget] type, you must past [onIdle] param else it return null
  /// You can't build a null Widget.
  ///  [onIdle] can return SizeBox.shink() or Container() if you don't want to show anything in your screen
  ///
  R? whenOrNull<R>({
    R Function()? onIdle,
    required R Function() onLoading,
    required R Function(T data) onSuccess,
    required R Function(Failure error) onError,
  }) {
    if (isLoading) {
      return onLoading();
    } else if (isSuccess) {
      return onSuccess((this as Success)._data);
    } else if (isError) {
      return onError((this as Error)._error);
    } else {
      return onIdle?.call();
    }
  }

  R when<R>({
    required R Function() onIdle,
    required R Function() onLoading,
    required R Function(T data) onSuccess,
    required R Function(Failure error) onError,
  }) {
    if (isLoading) {
      return onLoading();
    } else if (isSuccess) {
      return onSuccess((this as Success)._data);
    } else if (isError) {
      return onError((this as Error)._error);
    } else {
      return onIdle();
    }
  }
}

class Idle<T> extends Status<T> {}

class Loading<T> extends Status<T> {}

class Success<T> extends Status<T> {
  final T? _data;
  Success([this._data]);
}

class Error<T> extends Status<T> {
  final Failure _error;
  Error(this._error);
}
