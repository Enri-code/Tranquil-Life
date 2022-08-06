/* abstract class Error {
  const Error();
} */

class ApiError /*  extends Error  */ {
  const ApiError({required this.data, required this.statusCode});

  final int statusCode;
  final String data;
}

abstract class ErrorCause {
  const ErrorCause();
}

class ResolvedError /* extends Error  */ {
  const ResolvedError({this.message = '', this.cause});

  final ErrorCause? cause;
  final String message;
}
