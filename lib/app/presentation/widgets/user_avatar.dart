import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.imageUrl,
    this.size = 48,
    this.decoration,
  }) : super(key: key);

  final double size;
  final String? imageUrl;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    String url =
        imageUrl ?? context.read<ClientAuthBloc>().state.user?.avatarUrl ?? '';
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
      child: Image.network(
        url,
        errorBuilder: (_, __, ___) => Icon(
          TranquilIcons.profile,
          color: Colors.grey,
          size: size * 0.9 - 4,
        ),
        frameBuilder: (_, img, val, ___) {
          return AnimatedCrossFade(
            alignment: Alignment.center,
            firstChild: Center(
              child: PulsingWidget(
                maxOpacity: 0.5,
                child: Icon(Icons.image_search, size: size * 0.7),
              ),
            ),
            secondChild: img,
            crossFadeState: val == null
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: kThemeAnimationDuration,
          );
        },
      ),
    );
  }
}

class PulsingWidget extends StatefulWidget {
  const PulsingWidget({
    Key? key,
    required this.child,
    this.minOpacity = 0,
    this.maxOpacity = 1,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  final double minOpacity, maxOpacity;
  final Duration duration;
  final Widget child;

  @override
  State<PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<PulsingWidget> {
  bool atEnd = true;
  late double opacity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    opacity = widget.minOpacity;
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => setState(() => opacity = widget.maxOpacity));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      curve: Curves.easeOut,
      duration: widget.duration,
      onEnd: () {
        setState(() => opacity = atEnd ? widget.minOpacity : widget.maxOpacity);
        atEnd = !atEnd;
      },
      child: widget.child,
    );
  }
}
