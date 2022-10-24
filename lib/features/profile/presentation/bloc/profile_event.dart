part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUser extends Client implements ProfileEvent {
  static Client? get _profileData => getIt<ProfileBloc>().state.user;

  UpdateUser({
    Client? oldData,
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
          id: id ?? oldData?.id ?? _profileData!.id,
          email: email ?? oldData?.email ?? _profileData!.email,
          firstName: firstName ?? oldData?.firstName ?? _profileData!.firstName,
          lastName: lastName ?? oldData?.lastName ?? _profileData!.lastName,
          displayName:
              displayName ?? oldData?.displayName ?? _profileData!.displayName,
          phoneNumber:
              phoneNumber ?? oldData?.phoneNumber ?? _profileData!.phoneNumber,
          birthDate: birthDate ?? oldData?.birthDate ?? _profileData?.birthDate,
          avatarUrl: avatarUrl ?? oldData?.avatarUrl ?? _profileData!.avatarUrl,
          isVerified:
              isVerified ?? oldData?.isVerified ?? _profileData!.isVerified,
          usesBitmoji:
              usesBitmoji ?? oldData?.usesBitmoji ?? _profileData!.usesBitmoji,
          hasAnsweredQuestions: hasAnsweredQuestions ??
              oldData?.hasAnsweredQuestions ??
              _profileData!.hasAnsweredQuestions,
          gender: gender ?? oldData?.gender ?? _profileData?.gender,
          staffId: oldData?.staffId ?? _profileData?.staffId,
          companyName:
              companyName ?? oldData?.companyName ?? _profileData?.companyName,
        );

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class AddUserProfile extends ProfileEvent {
  final Client user;
  const AddUserProfile(this.user);
}

class RestoreUserProfile extends ProfileEvent {
  const RestoreUserProfile();
}

class RemoveUserProfile extends ProfileEvent {
  const RemoveUserProfile();
}

class UpdateProfileLocation extends ProfileEvent {
  const UpdateProfileLocation([this.location]);
  final String? location;
}
