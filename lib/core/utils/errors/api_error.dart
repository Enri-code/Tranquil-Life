abstract class ErrorCause {
  const ErrorCause();
}

class ResolvedError {
  const ResolvedError({this.message = '', this.cause});

  final ErrorCause? cause;
  final String message;
}
