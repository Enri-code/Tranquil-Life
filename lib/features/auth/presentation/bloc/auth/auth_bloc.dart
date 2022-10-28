import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';

import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/app/domain/entities/query_params.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/auth/data/use_cases.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/auth/domain/repos/auth.dart';
import 'package:tranquil_life/features/profile/domain/entities/user.dart';
import 'package:tranquil_life/features/profile/domain/repos/profile_repo.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepo<User, QueryParams> authRepo,
    required ProfileRepo profileRepo,
  })  : _authRepo = authRepo,
        _profileRepo = profileRepo,
        super(const AuthState()) {
    on<RemoveError>(_resetError);
    on<RestoreSignIn>(_restoreSignIn);
    on<SignUp>(_signUp);
    on<SignIn>(_signIn);
    on<SignOut>(_signOut);
    on<ResetPassword>(_resetPassword);
  }

  final AuthRepo<User, QueryParams> _authRepo;
  final ProfileRepo _profileRepo;

  RegisterData params = RegisterData();

  _onSignIn(User user, Emitter<AuthState> emit) async {
    params = RegisterData();
    getIt<IUserDataStore>().token = user.authToken!;
    final result = await _profileRepo.getProfile();
    emit(result.fold(
      (l) => state.copyWith(status: EventStatus.error, error: l),
      (r) {
        signInCase(r);
        return state.copyWith(
          status: EventStatus.success,
          isSignedIn: true,
          error: null,
        );
      },
    ));
  }

  _resetError(RemoveError event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: EventStatus.initial, error: null));
  }

  _restoreSignIn(RestoreSignIn event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      error: null,
      status: EventStatus.initial,
      isSignedIn: true,
    ));
  }

  _signUp(SignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    var res = await _authRepo.register(params);
    res.fold(
      (l) => emit(state.copyWith(status: EventStatus.error, error: l)),
      (r) => _onSignIn(r, emit),
    );
  }

  _signIn(SignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    var res = await _authRepo.signIn(event.email, event.password);
    emit(res.fold(
      (l) => state.copyWith(status: EventStatus.error, error: l),
      (r) => _onSignIn(r, emit),
    ));
  }

  _signOut(SignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    await signOutCase();
    emit(state.copyWith(
      status: EventStatus.initial,
      isSignedIn: false,
      error: null,
    ));
  }

  _resetPassword(ResetPassword event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: EventStatus.customLoading));
    var res = await _authRepo.resetPassword(event.email);
    emit(res.fold(
      (l) => state.copyWith(status: EventStatus.error, error: l),
      (r) => state.copyWith(status: EventStatus.success, error: null),
    ));
  }
}
