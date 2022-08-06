// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';

import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/app/domain/entities/query_params.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/features/auth/data/use_cases.dart/sign_out.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';
import 'package:tranquil_life/features/auth/domain/repos/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

abstract class AuthBloc<P extends QueryParams>
    extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<RemoveError>(_resetError);
    on<SignUp>(_signUp);
    on<SignIn>(_signIn);
    on<SignOut>(_signOut);
    on<ResetPassword>(_resetPassword);
  }

  P get params;
  AuthRepo get repo;

  _resetError(RemoveError event, Emitter<AuthState> emit) =>
      emit(state.copyWith(status: OperationStatus.initial, error: null));

  _signUp(SignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await repo.register(params);
    emit(res.fold(
      (l) => state.copyWith(status: OperationStatus.error, error: l),
      (r) => state.copyWith(
        status: OperationStatus.success,
        user: AppData.user = r,
        error: null,
      ),
    ));
  }

  _signIn(SignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await repo.signIn(event.email, event.password);
    emit(res.fold(
      (l) => state.copyWith(status: OperationStatus.error, error: l),
      (r) => state.copyWith(
        status: OperationStatus.success,
        user: AppData.user = r,
        error: null,
      ),
    ));
  }

  _signOut(SignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    await signOutCase();
    emit(state.copyWith(
      status: OperationStatus.success,
      user: AppData.user = null,
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