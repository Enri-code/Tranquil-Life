part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class RemoveError extends AuthEvent {
  const RemoveError();
}

class SignUp extends AuthEvent {
  const SignUp();
}

class SignIn extends AuthEvent {
  final String email, password;
  const SignIn(this.email, this.password);
}

class SignOut extends AuthEvent {
  const SignOut();
}

class ResetPassword extends AuthEvent {
  final String email;
  const ResetPassword(this.email);
}
