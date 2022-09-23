part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({this.user, this.location});
  final Client? user;
  final String? location;

  ProfileState copyWith({Client? user, String? location}) {
    return ProfileState(
      user: user ?? this.user,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [user, location];
}
