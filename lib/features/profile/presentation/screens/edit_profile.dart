import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/edit_profile_tile.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/gender_bottom_sheet.dart';
import 'package:tranquil_life/features/profile/presentation/widgets/picture_bottom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = 'edit_profile_screen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UpdateUser newUserData = UpdateUser();

  static const _smallPadding = SizedBox(height: 20);
  static const _bigPadding = SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppBarAction(
            child: const Text('Done'),
            isCustomButton: false,
            onPressed: () {
              context.read<ProfileBloc>().add(newUserData);
              Navigator.of(context).pop();
            },
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
                        onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const AddPictureSheet(),
                        ),
                        child: const EditProfileTile(
                          title: 'Edit Photo',
                          suffix: MyAvatarWidget(size: 38),
                        ),
                      ),
                      _smallPadding,
                      EditProfileTile(
                        title: 'First Name',
                        suffixFieldValue: newUserData.firstName,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            firstName: value,
                          );
                        },
                      ),
                      _smallPadding,
                      EditProfileTile(
                        title: 'Last Name',
                        suffixFieldValue: newUserData.lastName,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            lastName: value,
                          );
                        },
                      ),
                      _smallPadding,
                      EditProfileTile(
                        title: 'Display Name',
                        suffixFieldValue: newUserData.displayName,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            displayName: value,
                          );
                        },
                      ),
                      _smallPadding,
                      EditProfileTile(
                        title: 'Phone No',
                        suffixFieldValue: newUserData.phoneNumber,
                        onDoneEditing: (value) {
                          newUserData = UpdateUser(
                            oldData: newUserData,
                            phoneNumber: value,
                          );
                        },
                      ),
                      _bigPadding,
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
                        child: EditProfileTile(
                          title: 'Date of Birth',
                          suffix: Text(newUserData.birthDate ?? 'Not set'),
                        ),
                      ),
                      _smallPadding,
                      GestureDetector(
                        onTap: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => SelectGenderSheet(
                            onChanged: (value) => setState(() {
                              newUserData = UpdateUser(
                                oldData: newUserData,
                                gender: value,
                              );
                            }),
                          ),
                        ),
                        child: EditProfileTile(
                          title: 'Gender',
                          suffix: Text(newUserData.gender ?? 'Not set'),
                        ),
                      ),
                      _bigPadding,
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (_, state) => EditProfileTile(
                          title: 'Location',
                          suffixFieldValue:
                              state.location ?? 'Somewhere on Earth',
                        ),
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
