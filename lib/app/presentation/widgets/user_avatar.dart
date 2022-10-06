import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/pulsing_widget.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';

enum AvatarSource { file, url, bitmojiUrl }

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.imageUrl,
    this.size = 48,
    this.source,
    this.decoration,
  }) : super(key: key);

  final double? size;
  final String? imageUrl;
  final AvatarSource? source;
  final BoxDecoration? decoration;

  static const Widget _placeHolder = PulsingWidget(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: FittedBox(fit: BoxFit.contain, child: Icon(Icons.image_search)),
    ),
  );

  Widget errorBuilder(_, __, ___) => Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Icon(TranquilIcons.profile, color: Colors.grey[600]),
        ),
      );

  Widget frameBuilder(_, img, val, ___) {
    return val == null ? _placeHolder : img;
  }

  @override
  Widget build(BuildContext context) {
    String value = imageUrl ?? '';
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
      child: Builder(builder: (context) {
        switch (source ?? AvatarSource.url) {
          case AvatarSource.url:
            return Image.network(
              value,
              fit: BoxFit.cover,
              errorBuilder: errorBuilder,
              frameBuilder: frameBuilder,
            );
          case AvatarSource.file:
            return Image.file(
              File(value),
              fit: BoxFit.cover,
              errorBuilder: errorBuilder,
              frameBuilder: frameBuilder,
            );
          case AvatarSource.bitmojiUrl:
            return SvgPicture.string(
              fluttermojiFunctions.decodeFluttermojifromString(value),
              fit: BoxFit.cover,
              placeholderBuilder: (_) => _placeHolder,
            );
        }
      }),
    );
  }
}

class MyAvatarWidget extends StatelessWidget {
  const MyAvatarWidget({Key? key, required this.size, this.decoration})
      : super(key: key);

  final double size;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return UserAvatar(
          size: size,
          decoration: decoration,
          imageUrl: state.user?.avatarUrl,
          source:
              state.user?.usesBitmoji == true ? AvatarSource.bitmojiUrl : null,
        );
      },
    );
  }
}
