import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/domain/repos/profile_repo.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repo) : super(const ProfileState()) {
    on<EditUser>(_editUser);
    on<UpdateUser>(_updateUser);
    on<RemoveUserProfile>(_removeUser);
    on<RestoreUserProfile>(_restoreUser);
    // on<UpdateProfileLocation>(_updateLocation);
  }

  final ProfileRepo _repo;

  _editUser(EditUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = event));
  }

  _updateUser(UpdateUser event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    final result = await _repo.updateProfile(event.user);
    result.fold(
      (l) => emit(state.copyWith(status: EventStatus.error)),
      (r) {
        emit(state.copyWith(status: EventStatus.success));
        add(EditUser(baseUser: r));
      },
    );
  }

  _removeUser(RemoveUserProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = null));
  }

  _restoreUser(RestoreUserProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user));
  }

/*   _updateLocation(UpdateProfileLocation event, Emitter<ProfileState> emit) {
    emit(state.copyWith(location: event.location));
  } */
}
