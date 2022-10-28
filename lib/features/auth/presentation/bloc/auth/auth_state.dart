part of 'auth_bloc.dart';

class AuthState extends BlocStateBase {
  const AuthState({
    super.error,
    super.status = EventStatus.initial,
    this.isSignedIn = false,
  });

  final bool isSignedIn;

  @override
  AuthState copyWith({
    EventStatus? status,
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
