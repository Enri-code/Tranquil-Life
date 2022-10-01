part of 'lock_screen_bloc.dart';

class LockScreenState extends BlocStateBase {
  const LockScreenState({
    super.status,
    this.pin = const [],
    this.isConfirmStep = false,
  });

  final List<String> pin;
  final bool isConfirmStep;

  @override
  LockScreenState copyWith({
    OperationStatus? status,
    bool? isConfirmStep,
    List<String>? pin,
  }) {
    return LockScreenState(
      status: status ?? this.status,
      pin: pin ?? this.pin,
      isConfirmStep: isConfirmStep ?? this.isConfirmStep,
    );
  }

  @override
  List<Object?> get props => [status, pin, isConfirmStep, ...super.props];
}
