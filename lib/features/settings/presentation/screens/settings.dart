import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/presentation/widgets/sign_out_dialog.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';
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
                prefixIconData: TranquilIcons.privacy_policy,
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
                prefixIconData: TranquilIcons.theme,
                suffixWidget: const ThemeBrightnessIcon(),
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: TranquilIcons.bell,
                label: 'Notifications',
                onPressed: () {},
              ),
              SettingsButton(
                prefixIconData: Icons.language,
                label: 'Languages',
                suffixWidget: Row(
                  children: [
                    Text(
                      Localizations.localeOf(context)
                          .languageCode
                          .toUpperCase(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 5, left: 4),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 28),
              const _SectionTitle('Security'),
              SettingsButton(
                prefixIconData: Icons.lock,
                label: 'Reset Pin',
                onPressed: () {
                  getIt<IScreenLock>().showLock(LockType.resetPin);
                },
              ),
              const SizedBox(height: 28),
              SettingsButton(
                label: 'Sign out',
                prefixIconData: TranquilIcons.sign_out,
                prefixIconColor: ColorPalette.red,
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SignOutDialog(),
                ),
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
      child: Text(title, style: const TextStyle(fontSize: 14)),
    );
  }
}
