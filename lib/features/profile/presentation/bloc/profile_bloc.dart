import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<UpdateUser>(_updateUser);
    on<RemoveUserProfile>(_removeUser);
    on<RestoreUserProfile>(_restoreUser);
    on<UpdateProfileLocation>(_updateLocation);
  }

  _updateUser(UpdateUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = event));
  }

  _removeUser(RemoveUserProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = null));
  }

  _restoreUser(RestoreUserProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user));
  }

  _updateLocation(UpdateProfileLocation event, Emitter<ProfileState> emit) {
    emit(state.copyWith(location: event.location));
  }
}
