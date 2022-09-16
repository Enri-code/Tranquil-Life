// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';

import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/app/domain/entities/query_params.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/auth/data/use_cases.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/auth/domain/repos/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

abstract class AuthBloc<P extends QueryParams>
    extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<RemoveError>(_resetError);
    on<RestoreSignIn>(_restoreSignIn);
    on<SignUp>(_signUp);
    on<SignIn>(_signIn);
    on<SignOut>(_signOut);
    on<ResetPassword>(_resetPassword);
  }

  P get params;
  AuthRepo<Client, QueryParams> get repo;

  AuthState _onSignIn(Client user) {
    signInCase(user);
    return state.copyWith(
      status: OperationStatus.success,
      authStatus: AuthStatus.signedIn,
      error: null,
    );
  }

  _resetError(RemoveError event, Emitter<AuthState> emit) =>
      emit(state.copyWith(status: OperationStatus.initial, error: null));

  _restoreSignIn(RestoreSignIn event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      error: null,
      status: OperationStatus.initial,
      authStatus: AuthStatus.signedIn,
    ));
  }

  _signUp(SignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await repo.register(params);
    emit(res.fold(
      (l) => state.copyWith(status: OperationStatus.error, error: l),
      _onSignIn,
    ));
  }

  _signIn(SignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await repo.signIn(event.email, event.password);
    emit(res.fold(
      (l) => state.copyWith(status: OperationStatus.error, error: l),
      _onSignIn,
    ));
  }

  _signOut(SignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    await signOutCase();
    emit(state.copyWith(
      status: OperationStatus.success,
      authStatus: AuthStatus.signedOut,
      error: null,
    ));
  }

  _resetPassword(ResetPassword event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await repo.resetPassword(event.email);
    emit(res.fold(
      (l) => state.copyWith(status: OperationStatus.error, error: l),
      (r) => state.copyWith(status: OperationStatus.success, error: null),
    ));
  }
}
