import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
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

  final double size;
  final String? imageUrl;
  final AvatarSource? source;
  final BoxDecoration? decoration;

  Widget get placeHolder => Center(
        child: _PulsingWidget(
          child: Icon(Icons.image_search, size: size * 0.7),
        ),
      );

  Widget _errorBuilder(_, __, ___) => Icon(
        TranquilIcons.profile,
        color: Colors.grey[600],
        size: size * 0.9 - 4,
      );

  Widget _frameBuilder(_, img, val, [___]) {
    return AnimatedCrossFade(
      alignment: Alignment.center,
      firstChild: placeHolder,
      secondChild: img,
      crossFadeState:
          val == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: kThemeAnimationDuration,
    );
  }

  @override
  Widget build(BuildContext context) {
    String value =
        imageUrl ?? context.read<ProfileBloc>().state.user?.avatarUrl ?? '';
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
              errorBuilder: _errorBuilder,
              frameBuilder: _frameBuilder,
            );
          case AvatarSource.file:
            return Image.file(
              File(value),
              fit: BoxFit.cover,
              errorBuilder: _errorBuilder,
              frameBuilder: _frameBuilder,
            );
          case AvatarSource.bitmojiUrl:
            return SvgPicture.string(
              fluttermojiFunctions.decodeFluttermojifromString(value),
              fit: BoxFit.cover,
              placeholderBuilder: (_) => placeHolder,
            );
        }
      }),
    );
  }
}

class _PulsingWidget extends StatefulWidget {
  const _PulsingWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<_PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<_PulsingWidget> {
  bool atEnd = true;
  static const _minOpacity = 0.2;
  static const _maxOpacity = 0.5;
  double opacity = _minOpacity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => setState(() => opacity = _maxOpacity));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 600),
      onEnd: () {
        setState(() => opacity = atEnd ? _minOpacity : _maxOpacity);
        atEnd = !atEnd;
      },
      child: widget.child,
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
