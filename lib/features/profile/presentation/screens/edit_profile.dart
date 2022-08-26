import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/add_picture_bottom_sheet.dart';

class EditProfileScreen extends StatelessWidget {
  static const routeName = 'edit_profile_screen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppBarAction(
            child: const Text("Done"),
            isCustomButton: false,
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            top: 8,
            left: 32,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
              child: MyDefaultTextStyle(
                style: const TextStyle(fontSize: 15.5),
                child: Column(
                  children: [
                    _Button(
                      title: 'Edit Photo',
                      suffix: const UserAvatar(size: 36),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const AddPictureSheet(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _Button(
                      title: 'First Name',
                      suffixText: 'Rick',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _Button(
                      title: 'Last Name',
                      suffixText: 'Swash',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _Button(
                      title: 'Display Name',
                      suffixText: 'Rick Swash',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 40),
                    _Button(
                      title: 'Date of Birth',
                      suffixText: '21-04-1994',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _Button(
                      title: 'Gender',
                      suffixText: 'Male',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 40),
                    _Button(
                      title: 'Location',
                      suffixText: 'United Kingdom United Kingdom',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 20),
                    _Button(
                      title: 'Phone No',
                      suffixText: '+44 656 766',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.title,
    this.suffix,
    this.suffixText,
    this.onPressed,
  })  : assert(suffix != null || suffixText != null),
        super(key: key);

  final String title;
  final String? suffixText;
  final Widget? suffix;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: ColorPalette.primary[200],
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Row(
            children: [
              Text(title),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: suffix ??
                      Text(
                        suffixText!,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                        ),
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
