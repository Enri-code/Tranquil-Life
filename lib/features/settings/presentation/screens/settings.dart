import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/settings/presentation/widgets/settings_button.dart';
import 'package:tranquil_life/features/settings/presentation/widgets/theme_brightness_button.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'settings_screen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const _SectionTitle('General'),
              SettingsButton(
                prefixIconData: CupertinoIcons.share_solid,
                label: 'Invite friends',
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: Icons.help,
                label: 'Help',
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: Icons.info,
                label: 'About us',
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: Icons.file_present,
                label: 'Privacy policy',
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: TranquilIcons.book_saved,
                label: 'Terms and conditions',
                onPressed: () {},
              ),
              const SizedBox(height: 28),
              const _SectionTitle('Customization'),
              SettingsButton(
                label: 'Theme',
                prefixIconData: Icons.format_paint,
                suffixWidget: const ThemeBrightnessIcon(),
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: TranquilIcons.bell,
                label: 'Notifications',
                onPressed: () {},
              ),
              if (Platform.isAndroid || Platform.isIOS)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    const _SectionTitle('Security'),
                    SettingsButton(
                      prefixIconData: Icons.security,
                      label:
                          Platform.isIOS ? 'Face ID' : 'Face ID / Fingerprint',
                      onPressed: () {},
                    ),
                  ],
                ),
              const SizedBox(height: 28),
              SettingsButton(
                label: 'Sign out',
                prefixIconData: Icons.exit_to_app,
                prefixIconColor: ColorPalette.red,
                onPressed: () =>
                    context.read<ClientAuthBloc>().add(const SignOut()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, bottom: 4),
      child: Text(title),
    );
  }
}
