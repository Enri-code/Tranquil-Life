import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/screen_lock/domain/screen_lock_store.dart';
import 'package:tranquil_life/features/screen_lock/presentation/bloc/lock_screen_bloc.dart';

class PinInputBox extends StatelessWidget {
  const PinInputBox(this.input, {Key? key}) : super(key: key);
  final String input;

  @override
  Widget build(BuildContext context) {
    return InputBox(
      onPressed: () => context.read<LockScreenBloc>().add(AddLockInput(input)),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(input),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    Key? key,
    required this.child,
    required this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final Function() onPressed;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LockScreenBloc, LockScreenState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        bool cantType = state.status == EventStatus.loading ||
            state.status == EventStatus.customLoading;
        return Opacity(
          opacity: cantType ? 0.8 : 1,
          child: IgnorePointer(
            ignoring: cantType,
            child: Container(
              width: keyPadSize,
              height: keyPadSize,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Material(
                type: MaterialType.transparency,
                textStyle: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: MyTextData.josefinFamily,
                ),
                child: InkResponse(
                  containedInkWell: true,
                  onTap: onPressed,
                  onLongPress: onLongPress,
                  child: Center(child: child),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
