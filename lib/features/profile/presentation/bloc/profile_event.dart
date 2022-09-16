part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUser extends Client implements ProfileEvent {
  UpdateUser({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? displayName,
    String? phoneNumber,
    String? birthDate,
    String? avatarUrl,
    bool? isVerified,
    bool? usesBitmoji,
    String? token,
    bool? hasAnsweredQuestions,
  }) : super(
          id: id ?? _profileBlocData.id,
          email: email ?? _profileBlocData.email,
          firstName: firstName ?? _profileBlocData.firstName,
          lastName: lastName ?? _profileBlocData.lastName,
          displayName: displayName ?? _profileBlocData.displayName,
          phoneNumber: phoneNumber ?? _profileBlocData.phoneNumber,
          birthDate: birthDate ?? _profileBlocData.birthDate,
          avatarUrl: avatarUrl ?? _profileBlocData.avatarUrl,
          isVerified: isVerified ?? _profileBlocData.isVerified,
          usesBitmoji: usesBitmoji ?? _profileBlocData.usesBitmoji,
          token: token ?? _profileBlocData.token,
          hasAnsweredQuestions:
              hasAnsweredQuestions ?? _profileBlocData.hasAnsweredQuestions,
        );

  static Client get _profileBlocData => getIt<ProfileBloc>().state.user!;

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class AddUser extends ProfileEvent {
  final Client user;
  const AddUser(this.user);
}

class RestoreUser extends ProfileEvent {}

class RemoveUser extends ProfileEvent {
  const RemoveUser();
}
