part of 'auth_bloc.dart';

enum AuthStatus { signedIn, signedOut }

@immutable
class AuthState extends BlocStateBase {
  const AuthState({
    super.error,
    super.status = OperationStatus.initial,
    this.authStatus = AuthStatus.signedOut,
  });

  final AuthStatus authStatus;

  @override
  AuthState copyWith({
    OperationStatus? status,
    ResolvedError? error,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [authStatus, ...super.props];
}

class EmailError extends ErrorCause {
  const EmailError();
}
