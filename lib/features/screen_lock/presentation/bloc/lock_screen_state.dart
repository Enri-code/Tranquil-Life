part of 'lock_screen_bloc.dart';

class LockScreenState extends BlocStateBase {
  const LockScreenState({
    super.status,
    this.tries = 0,
    this.pin = const [],
    this.isConfirmStep = false,
  });

  final int tries;
  final bool isConfirmStep;
  final List<String> pin;

  @override
  LockScreenState copyWith({
    int? tries,
    bool? isConfirmStep,
    OperationStatus? status,
    List<String>? pin,
  }) {
    return LockScreenState(
      pin: pin ?? this.pin,
      tries: tries ?? this.tries,
      isConfirmStep: isConfirmStep ?? this.isConfirmStep,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [tries, pin, isConfirmStep, ...super.props];
}
