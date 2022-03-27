import 'failure.dart';

/// ApiFailure is Failure when client network call.

class ApiFailure extends Failure {
  /// status [statusCode] from server.
  final int statusCode;
  const ApiFailure(this.statusCode, message) : super(message);
}

/// ** `499 Client Closed Request Used`:
/// when the client has closed
/// the request before the server could send a response.
///
/// ** `444 No Response Used`:
/// to indicate that the server has returned
/// no information to the client and closed the connection.
///
class RequestCancelled extends ApiFailure {
  const RequestCancelled(
      [int statusCode = 499, String errorResponse = "Request Cancelled"])
      : super(statusCode, errorResponse);
}

/// `401 Unauthorized`:
/// response status code indicates that
/// the client request has not been completed because
/// it lacks valid authentication credentials for the requested resource.

class UnauthorisedRequest extends ApiFailure {
  const UnauthorisedRequest(
      [int statusCode = 401, String message = "Unauthorised request"])
      : super(statusCode, message);
}

/// `400 Bad Request`: response status code indicates
/// that the server cannot or will not process the request
/// due to something that is perceived to be a client error.

class BadRequest extends ApiFailure {
  const BadRequest([int statusCode = 400, String message = "Bad request"])
      : super(statusCode, message);
}

/// `404 Not Found`:
/// the server has not found anything matching the Request-URI.
/// No indication is given of whether the condition is temporary or permanent

class NotFound extends ApiFailure {
  const NotFound([int statusCode = 404, String message = "Not Found"])
      : super(statusCode, message);
}

/// `405 Method Not Allowed`:
/// response status code indicates that the server knows
/// the request method, but the target resource doesn't support this method.

class MethodNotAllowed extends ApiFailure {
  const MethodNotAllowed(
      [int statusCode = 405, String message = "Method Not Allowed"])
      : super(statusCode, message);
}

/// `406 Not Acceptable`:
/// client error response code indicates that the server cannot
/// produce a response matching the list of acceptable values
/// defined in the request's proactive content negotiation headers,
/// and that the server is unwilling to supply a default representation.

class NotAcceptable extends ApiFailure {
  const NotAcceptable([int statusCode = 406, String message = "Not Acceptable"])
      : super(statusCode, message);
}

/// `408 Request Timeout`:
/// response status code means that the server would like
/// to shut down this unused connection. It is sent on an
/// idle connection by some servers, even without any previous
/// request by the client.

class RequestTimeout extends ApiFailure {
  const RequestTimeout(
      [int statusCode = 408, String message = "Connection request timeout"])
      : super(statusCode, message);
}

// class SendTimeout extends ApiFailure {
//   const SendTimeout(
//       [String message = "Send timeout in connection with API server"])
//       : super(message);
// }

/// `409 Conflict`:
/// response status code indicates a request conflict
/// with the current state of the target resource.

class Conflict extends ApiFailure {
  const Conflict(
      [int statusCode = 409, String message = "Error due to a conflict"])
      : super(statusCode, message);
}

/// `500 Internal Server Error`:
/// server error response code indicates that the server
/// encountered an unexpected condition that prevented
/// it from fulfilling the request.

class InternalServerError extends ApiFailure {
  const InternalServerError(
      [int statusCode = 500, String message = "Internal Server Error"])
      : super(statusCode, message);
}

/// `501 Not Implemented`:
/// server error response code means that the server
/// does not support the functionality required to fulfill
/// the request.

class NotImplemented extends ApiFailure {
  const NotImplemented(
      [int statusCode = 501, String message = "Not Implemented"])
      : super(statusCode, message);
}

/// `503 Service Unavailable`: 
/// server error response code indicates that 
/// the server is not ready to handle the request.

class ServiceUnavailable extends ApiFailure {
  const ServiceUnavailable([int statusCode = 503, String message = "Service Unavailable"])
      : super(statusCode, message);
}