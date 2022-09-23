import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/services/media_service.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/profile/presentation/screens/edit_avatar.dart';

class AddPictureSheet extends StatelessWidget {
  const AddPictureSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: MyDefaultTextStyle(
            style: TextStyle(
              color: ColorPalette.green[800],
              fontWeight: FontWeight.w600,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Button(
                  title: 'Take a picture',
                  iconData: Icons.camera_alt,
                  onPressed: () async {
                    final image =
                        await MediaService.selectImage(ImageSource.camera);
                  },
                ),
                _Button(
                  title: 'Upload from gallery',
                  iconData: Icons.image,
                  onPressed: () async {
                    final image = await MediaService.selectImage();
                  },
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (prev, curr) =>
                      curr.user!.usesBitmoji != prev.user!.usesBitmoji,
                  builder: (context, state) {
                    return _Button(
                      title: state.user!.usesBitmoji
                          ? 'Edit your avatar'
                          : 'Use an avatar',
                      child: Image.asset('assets/images/icons/bitmoji.png'),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AvatarEditorScreen.routeName),
                    );
                  },
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state.user!.avatarUrl.isEmpty) return const SizedBox();
                    return _Button(
                      title:
                          'Remove your ${state.user!.usesBitmoji ? 'avatar' : 'picture'}',
                      iconData: TranquilIcons.trash,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => const _RemoveDialog(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemoveDialog extends StatelessWidget {
  const _RemoveDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: 'Remove Picture?',
      bodyText: 'Are you sure you want to remove your current profile picture?',
      yesDialog: DialogOption(
        'Remove',
        onPressed: () => context.read<ProfileBloc>().add(
              UpdateUser(usesBitmoji: false, avatarUrl: null),
            ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.title,
    this.iconData,
    this.child,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData? iconData;
  final Widget? child;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkResponse(
        containedInkWell: true,
        highlightShape: BoxShape.rectangle,
        onTap: () {
          Navigator.of(context).pop();
          onPressed();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Row(
            children: [
              if (iconData != null)
                Icon(iconData, color: Theme.of(context).primaryColor, size: 28),
              if (child != null) child!,
              const SizedBox(width: 24),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
