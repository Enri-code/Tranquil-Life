import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/picture_bottom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = 'edit_profile_screen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UpdateUser newUserData = UpdateUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppBarAction(
            child: const Text("Done"),
            isCustomButton: false,
            onPressed: () => context.read<ProfileBloc>().add(newUserData),
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
                child: UnfocusWidget(
                  child: Column(
                    children: [
                      GestureDetector(
                        child: const _Button(
                          title: 'Edit Photo',
                          suffix: MyAvatarWidget(size: 38),
                        ),
                        onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const AddPictureSheet(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _Button(
                        title: 'First Name',
                        suffixText: newUserData.firstName,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            firstName: value,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _Button(
                        title: 'Last Name',
                        suffixText: newUserData.lastName,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            lastName: value,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _Button(
                        title: 'Display Name',
                        suffixText: newUserData.displayName,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            displayName: value,
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () async {
                          final date = await showCustomDatePicker(
                            context,
                            minDateFromNow: DateTime(-100, 0, 0),
                            maxDateFromNow: DateTime(-16, 0, 0),
                          );
                          setState(() {
                            newUserData = UpdateUser(
                              oldData: newUserData,
                              birthDate: date?.folded,
                            );
                          });
                        },
                        child: _Button(
                          title: 'Date of Birth',
                          suffix: Text(newUserData.birthDate ?? '- - -'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _Button(
                        title: 'Gender',
                        suffixText: newUserData.gender ?? 'Unknown',
                        // onDoneEditing: (value) {},
                      ),
                      const SizedBox(height: 40),
                      _Button(
                        title: 'Location',
                        suffixText: 'United Kingdom United Kingdom',
                      ),
                      const SizedBox(height: 20),
                      _Button(
                        title: 'Phone No',
                        suffixText: newUserData.phoneNumber,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            phoneNumber: value,
                          );
                        },
                      ),
                    ],
                  ),
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
    this.onDoneEditing,
  })  : assert(suffix != null || suffixText != null),
        super(key: key);

  final String title;
  final String? suffixText;
  final Widget? suffix;
  final Function(String newValue)? onDoneEditing;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: ColorPalette.green[200],
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const SizedBox(width: 16),
            Flexible(
              child: suffix ??
                  TextFormField(
                    maxLines: null,
                    initialValue: suffixText,
                    enabled: onDoneEditing != null,
                    textAlign: TextAlign.right,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Previous: $suffixText',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onFieldSubmitted: onDoneEditing,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
