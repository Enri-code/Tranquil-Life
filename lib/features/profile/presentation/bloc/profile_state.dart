part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({this.user});
  final Client? user;

  ProfileState copyWith({Client? user}) {
    return ProfileState(user: user ?? this.user);
  }

  @override
  List<Object?> get props => [user];
}
