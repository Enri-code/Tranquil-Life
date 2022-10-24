abstract class ErrorCause {
  const ErrorCause();
}

class ApiError {
  const ApiError({this.message, this.cause});

  final ErrorCause? cause;
  final String? message;
}

class EmailError extends ErrorCause {
  const EmailError();
}
