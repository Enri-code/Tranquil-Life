part of 'lock_screen_bloc.dart';

abstract class LockScreenEvent extends Equatable {
  const LockScreenEvent();

  @override
  List<Object> get props => [];
}

class AddLockInput extends LockScreenEvent {
  const AddLockInput(this.pin);
  final String pin;
}

class RemoveLockInput extends LockScreenEvent {
  const RemoveLockInput([this.removeAll = false]);
  final bool removeAll;
}
