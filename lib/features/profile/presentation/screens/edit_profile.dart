import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
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
  static const _smallPadding = SizedBox(height: 20);
  static const _bigPadding = SizedBox(height: 40);

  EditUser newUserData = EditUser();
  late final Client oldUserData;
  bool reset = true;

  @override
  void initState() {
    oldUserData = context.read<ProfileBloc>().state.user!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (reset) {
          context.read<ProfileBloc>().add(EditUser(baseUser: oldUserData));
        }
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            AppBarAction(
              child: const Text('Done'),
              isCustomButton: false,
              onPressed: () {
                context.read<ProfileBloc>().add(UpdateUser(newUserData));
                reset = false;
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
                            newUserData = EditUser(
                              baseUser: newUserData,
                              firstName: value,
                            );
                          },
                        ),
                        _smallPadding,
                        EditProfileTile(
                          title: 'Last Name',
                          suffixFieldValue: newUserData.lastName,
                          onDoneEditing: (value) {
                            newUserData = EditUser(
                              baseUser: newUserData,
                              lastName: value,
                            );
                          },
                        ),
                        _smallPadding,
                        EditProfileTile(
                          title: 'Display Name',
                          suffixFieldValue: newUserData.displayName,
                          onDoneEditing: (value) {
                            newUserData = EditUser(
                              baseUser: newUserData,
                              displayName: value,
                            );
                          },
                        ),
                        _smallPadding,
                        EditProfileTile(
                          title: 'Phone No',
                          suffixFieldValue: newUserData.phoneNumber,
                          onDoneEditing: (value) {
                            newUserData = EditUser(
                              baseUser: newUserData,
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
                              newUserData = EditUser(
                                baseUser: newUserData,
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
                                newUserData = EditUser(
                                  baseUser: newUserData,
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
                        /*  BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (prev, curr) =>
                              prev.location != curr.location,
                          builder: (_, state) {
                            if (state.location == null) return const SizedBox();
                            return Column(
                              children: [
                                _bigPadding,
                                EditProfileTile(
                                  title: 'Location',
                                  suffix: Text(state.location!),
                                ),
                              ],
                            );
                          },
                        ),*/
                        BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (prev, curr) =>
                              prev.user!.companyName != curr.user!.companyName,
                          builder: (_, state) {
                            final name = state.user!.companyName;
                            if (name == null) return const SizedBox();
                            return Column(
                              children: [
                                _smallPadding,
                                EditProfileTile(
                                  title: 'Current Company',
                                  suffix: Text(name),
                                ),
                              ],
                            );
                          },
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          buildWhen: (prev, curr) =>
                              prev.user!.staffId != curr.user!.staffId,
                          builder: (_, state) {
                            final id = state.user!.staffId;
                            if (id == null) return const SizedBox();
                            return Column(
                              children: [
                                _smallPadding,
                                EditProfileTile(
                                  title: 'Staff ID',
                                  suffix: Text(id),
                                ),
                              ],
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
      ),
    );
  }
}
