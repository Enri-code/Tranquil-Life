part of 'auth_bloc.dart';

class AuthState extends BlocStateBase {
  const AuthState({
    super.error,
    super.status = OperationStatus.initial,
    this.isSignedIn = false,
  });

  final bool isSignedIn;

  @override
  AuthState copyWith({
    OperationStatus? status,
    ApiError? error,
    bool? isSignedIn,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  List<Object?> get props => [isSignedIn, ...super.props];
}
