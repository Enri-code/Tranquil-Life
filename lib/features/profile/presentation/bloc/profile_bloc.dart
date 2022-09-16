import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';
import 'package:tranquil_life/features/auth/domain/repos/user_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<AddUser>(_addUser);
    on<UpdateUser>(_updateUser);
    on<RemoveUser>(_removeUser);
    on<RestoreUser>(_restoreUser);
  }

  _addUser(AddUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = event.user));
  }

  _updateUser(UpdateUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = event));
  }

  _removeUser(RemoveUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user = null));
  }

  _restoreUser(RestoreUser event, Emitter<ProfileState> emit) {
    emit(state.copyWith(user: getIt<IUserDataStore>().user));
  }
}
