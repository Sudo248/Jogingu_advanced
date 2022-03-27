/// Failure

abstract class Failure implements Exception {
  ///	[message] description reason for failure
  final dynamic message;
  const Failure([this.message = ""]);
  @override
  String toString() {
    Object? message = this.message;
    if (message == null) {
      return "\x1B[31m! $runtimeType Exception\x1B[0m";
    } else {
      return "\x1B[31m! $runtimeType Exception => message: $message\x1B[0m";
    }
  }

  List<Object> get props => [message];
}

/// Failure socket: no internet connection.

class NoInternetConnection extends Failure {
  const NoInternetConnection([String message = "No internet connection"])
      : super(message);
}

/// 

class ApiFormatException extends Failure {
  const ApiFormatException([String message = "Format Exception"])
      : super(message);
}

///

class UnableToProcess extends Failure {
  const UnableToProcess([String message = "Unable to process the data"])
      : super(message);
}

///

class DefaultError extends Failure {
  const DefaultError([String message = "DefaultError"]) : super(message);
}


///

class UnexpectedError extends Failure {
  const UnexpectedError([String message = "Unexpected error occurred"])
      : super(message);
}
