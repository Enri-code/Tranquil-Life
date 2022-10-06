import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/auth/presentation/widgets/sign_out_dialog.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';
import 'package:tranquil_life/features/screen_lock/presentation/bloc/lock_screen_bloc.dart';
import 'package:tranquil_life/features/screen_lock/presentation/widgets/forgot_pin_dialog.dart';
import 'package:tranquil_life/features/screen_lock/presentation/widgets/input_box.dart';
import 'package:tranquil_life/features/screen_lock/presentation/widgets/pin_box.dart';

class LockScreen extends StatefulWidget {
  ///arguments is [LockType]
  static const routeName = 'lock_screen';
  const LockScreen({Key? key}) : super(key: key);

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  late LockType lockType;

  bool get canGoBack => lockType == LockType.resetPin;

  CustomAppBar _appBarBuilder(LockScreenState state) {
    return CustomAppBar(
      title: () {
        switch (lockType) {
          case LockType.setupPin:
            if (state.isConfirmStep) {
              return 'Re-enter The Last Pin';
            } else {
              return 'Enter A New Pin';
            }
          case LockType.authenticate:
            return 'Enter Your Pin';
          case LockType.resetPin:
            return 'Enter Your Last Pin';
        }
      }(),
      hideBackButton: !canGoBack,
      actions: [
        AppBarAction(
          isCustomButton: false,
          child: PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (_) => [
              if (lockType != LockType.setupPin)
                const PopupMenuItem(value: 0, child: Text('Forgot Pin')),
              const PopupMenuItem(value: 1, child: Text('Sign Out')),
            ],
            onSelected: (int val) {
              switch (val) {
                case 0:
                  showDialog(
                    context: context,
                    builder: (_) => const ForgotPinDialog(),
                  );
                  break;
                case 1:
                  showDialog(
                    context: context,
                    builder: (_) => const SignOutDialog(),
                  );
                  break;
              }
            },
            child: const Icon(Icons.more_vert),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    lockType = ModalRoute.of(context)!.settings.arguments as LockType;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => canGoBack,
      child: BlocProvider(
        lazy: false,
        create: (context) => LockScreenBloc(lockType),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: _appBarBuilder(context.watch<LockScreenBloc>().state),
            body: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 400, maxHeight: 600),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (i) => PinBox(i)),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 24,
                        child: BlocBuilder<LockScreenBloc, LockScreenState>(
                          builder: (context, state) {
                            final lockBloc = context.read<LockScreenBloc>();
                            if (state.status == OperationStatus.customLoading) {
                              return StreamBuilder<String>(
                                stream: lockBloc.timeLeft,
                                builder: (_, snap) => Text(snap.data ?? ''),
                              );
                            }

                            if (state.status == OperationStatus.error) {
                              if (lockType == LockType.setupPin) {
                                return Text(
                                  'Wrong pin. Try again.',
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                  ),
                                );
                              }
                              int triesLeft = lockBloc.maxTries - state.tries;
                              return Text(
                                'Wrong pin. $triesLeft ${triesLeft > 1 ? 'tries' : 'try'} left.',
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Flexible(child: _KeyPadWidget()),
                      BlocListener<LockScreenBloc, LockScreenState>(
                        listenWhen: (prev, curr) =>
                            curr.status == OperationStatus.success &&
                            prev.status != curr.status,
                        listener: (context, state) {
                          if (lockType == LockType.resetPin) {
                            Navigator.of(context).popAndPushNamed(
                              LockScreen.routeName,
                              arguments: LockType.setupPin,
                            );
                          } else {
                            Navigator.of(context).pop(true);
                          }
                        },
                        child: const SizedBox(height: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _KeyPadWidget extends StatelessWidget {
  const _KeyPadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            PinInputBox('1'),
            PinInputBox('2'),
            PinInputBox('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            PinInputBox('4'),
            PinInputBox('5'),
            PinInputBox('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            PinInputBox('7'),
            PinInputBox('8'),
            PinInputBox('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<LockScreenBloc, LockScreenState>(
              builder: (context, state) {
                bool isInactive = !state.isConfirmStep;
                return IgnorePointer(
                  ignoring: isInactive,
                  child: AnimatedScale(
                    curve: Curves.easeOut,
                    duration: kThemeAnimationDuration,
                    scale: isInactive ? 0 : 1,
                    child: InputBox(
                      onPressed: () {
                        context
                            .read<LockScreenBloc>()
                            .add(const ResetLockInput());
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child:
                            Icon(Icons.restore, color: Colors.white, size: 26),
                      ),
                    ),
                  ),
                );
              },
            ),
            const PinInputBox('0'),
            BlocBuilder<LockScreenBloc, LockScreenState>(
              builder: (context, state) {
                bool isInactive = state.pin.isEmpty;
                return IgnorePointer(
                  ignoring: isInactive,
                  child: AnimatedScale(
                    curve: Curves.easeOut,
                    duration: kThemeAnimationDuration,
                    scale: isInactive ? 0 : 1,
                    child: InputBox(
                      onPressed: () {
                        context
                            .read<LockScreenBloc>()
                            .add(const RemoveLockInput());
                      },
                      onLongPress: () => context.read<LockScreenBloc>().add(
                            const RemoveLockInput(true),
                          ),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(
                          Icons.backspace_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
