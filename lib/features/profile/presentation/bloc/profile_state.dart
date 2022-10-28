part of 'profile_bloc.dart';

class ProfileState extends BlocStateBase {
  const ProfileState(
      {this.user, /* this.location, */ super.error, super.status});
  final Client? user;
  // final String? location;

  @override
  ProfileState copyWith({
    Client? user,
    // String? location,
    ApiError? error,
    EventStatus? status,
  }) {
    return ProfileState(
      user: user ?? this.user,
      // location: location ?? this.location,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [user, /* location, */ ...super.props];
}
