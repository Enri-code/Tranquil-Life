import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/profile/presentation/screens/chat_history.dart';
import 'package:tranquil_life/features/profile/presentation/screens/edit_profile.dart';
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
                padding: const EdgeInsets.only(right: 12, top: 8),
                child: AppBarButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SettingsScreen.routeName),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
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
                        const Text(
                          'Frank Martial (Franko)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 6),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (_, state) => Text(
                            state.location ?? 'Somewhere on Earth',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        _Button(
                          icon: Icons.favorite_rounded,
                          title: 'Favorite consultants',
                          onPreessed: () {},
                        ),
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
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPreessed,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() onPreessed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          foregroundColor: Colors.black,
          backgroundColor: ColorPalette.green[200],
          shadowColor: Colors.black.withOpacity(0.5),
          surfaceTintColor: Colors.white,
        ),
        onPressed: onPreessed,
        child: Row(
          children: [
            const SizedBox(width: 4),
            Icon(icon, size: 26),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 3),
              child: Text(
                title,
                style: const TextStyle(fontSize: 19),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
