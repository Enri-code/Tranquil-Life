part of 'auth_bloc.dart';

enum AuthStatus { signedIn, signedOut }

@immutable
class AuthState extends BlocStateBase {
  const AuthState({
    this.user,
    super.error,
    super.status = OperationStatus.initial,
    this.authStatus = AuthStatus.signedOut,
  });

  final Client? user;
  final AuthStatus authStatus;

  @override
  AuthState copyWith({
    Client? user,
    OperationStatus? status,
    ResolvedError? error,
    AuthStatus? authStatus,
  }) =>
      AuthState(
        user: user ?? this.user,
        status: status ?? this.status,
        error: error ?? this.error,
        authStatus: authStatus ?? this.authStatus,
      );

  @override
  List<Object?> get props => [user, status, error, authStatus];
}

class EmailError extends ErrorCause {
  const EmailError();
}
