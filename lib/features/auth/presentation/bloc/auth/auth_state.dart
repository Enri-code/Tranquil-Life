part of 'auth_bloc.dart';

@immutable
class AuthState extends BlocStateBase {
  const AuthState({
    this.user,
    super.error,
    super.status = OperationStatus.initial,
  });
  final Client? user;

  AuthState copyWith({
    Client? user,
    OperationStatus? status,
    ResolvedError? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [user, status, error];
}

///TODO
class EmailError extends ErrorCause {
  const EmailError();
}
