import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/profile/presentation/screens/edit_profile.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/profile_tab_button.dart';
import 'package:tranquil_life/features/settings/presentation/screens/settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 8, bottom: 16),
                child: AppBarButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    return Navigator.of(context)
                        .pushNamed(SettingsScreen.routeName);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MyAvatarWidget(
                          size: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Edit Profile'),
                        const SizedBox(width: 6),
                        AppBarButton(
                          icon: const Icon(Icons.edit, size: 22),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(EditProfileScreen.routeName),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26),
                    Text(
                      context.watch<ProfileBloc>().state.user!.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 28),
                    ),
                    /* const SizedBox(height: 6),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (_, state) => Text(
                          state.location ?? 'Somewhere on Earth',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ), */
                    Expanded(
                      child: IconTheme(
                        data: Theme.of(context).iconTheme.copyWith(size: 32),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfileTabButton(
                                icon: Icon(
                                  Icons.people,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: 'My consultants',
                                onPreessed: () {},
                              ),
                              ProfileTabButton(
                                icon: Icon(
                                  Icons.people,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: 'Achievements',
                                onPreessed: () {},
                              ),

                              /* 
                          const SizedBox(height: 24),
                          _Button(
                            icon: TranquilIcons.message_time,
                            title: 'Chat history',
                            onPreessed: () => Navigator.of(context).pushNamed(
                              ChatHistoryScreen.routeName,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _Button(
                            icon: TranquilIcons.card,
                            title: 'Transaction history',
                            onPreessed: () {},
                          ),
                          const SizedBox(height: 24),
                          _Button(
                            icon: TranquilIcons.wallet,
                            title: 'Wallet',
                            onPreessed: () {},
                          ), */
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
