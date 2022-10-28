part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class EditUser extends Client implements ProfileEvent {
  static Client? get _profileData => getIt<IUserDataStore>().user;

  EditUser({
    ///The user model that fills in the default or null values
    Client? baseUser,
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
    bool? hasAnsweredQuestions,
    String? gender,
    String? companyName,
  }) : super(
          id: id ?? baseUser?.id ?? _profileData!.id,
          email: email ?? baseUser?.email ?? _profileData!.email,
          firstName:
              firstName ?? baseUser?.firstName ?? _profileData!.firstName,
          lastName: lastName ?? baseUser?.lastName ?? _profileData!.lastName,
          displayName:
              displayName ?? baseUser?.displayName ?? _profileData!.displayName,
          phoneNumber:
              phoneNumber ?? baseUser?.phoneNumber ?? _profileData!.phoneNumber,
          birthDate:
              birthDate ?? baseUser?.birthDate ?? _profileData?.birthDate,
          avatarUrl:
              avatarUrl ?? baseUser?.avatarUrl ?? _profileData!.avatarUrl,
          isVerified:
              isVerified ?? baseUser?.isVerified ?? _profileData!.isVerified,
          usesBitmoji:
              usesBitmoji ?? baseUser?.usesBitmoji ?? _profileData!.usesBitmoji,
          hasAnsweredQuestions: hasAnsweredQuestions ??
              baseUser?.hasAnsweredQuestions ??
              _profileData!.hasAnsweredQuestions,
          gender: gender ?? baseUser?.gender ?? _profileData?.gender,
          staffId: baseUser?.staffId ?? _profileData?.staffId,
          companyName:
              companyName ?? baseUser?.companyName ?? _profileData?.companyName,
        );

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class UpdateUser extends ProfileEvent {
  final Client user;

  const UpdateUser(this.user);
}

class RestoreUserProfile extends ProfileEvent {
  const RestoreUserProfile();
}

class RemoveUserProfile extends ProfileEvent {
  const RemoveUserProfile();
}

/* class UpdateProfileLocation extends ProfileEvent {
  const UpdateProfileLocation([this.location]);
  final String? location;
} */
