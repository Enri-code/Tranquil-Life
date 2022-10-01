import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/screen_lock/data/screen_lock_store.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';

part 'lock_screen_event.dart';
part 'lock_screen_state.dart';

class LockScreenBloc extends Bloc<LockScreenEvent, LockScreenState> {
  LockScreenBloc(this.lockType) : super(const LockScreenState()) {
    on<AddLockInput>(_addInput);
    on<RemoveLockInput>(_removeInput);

    needsAuth =
        lockType == LockType.authenticate || lockType == LockType.resetPin;
    if (needsAuth) {
      (() async => correctPin = await lockController.getPin() ?? '')();
    }
  }

  final LockType lockType;
  late bool needsAuth;
  String correctPin = '';

  String get _pin => state.pin.fold('', (prev, curr) => '$prev$curr');

  _onPinComplete(Emitter<LockScreenState> emit) {
    _emitResultStatus() {
      emit(state.copyWith(
        status: _pin == correctPin
            ? OperationStatus.success
            : OperationStatus.error,
      ));
    }

    if (needsAuth) {
      _emitResultStatus();
    } else if (lockType == LockType.setupPin) {
      if (state.isConfirmStep) {
        _emitResultStatus();
        lockController.setPin(_pin);
      } else {
        correctPin = _pin;
        emit(state.copyWith(isConfirmStep: true));
      }
    }
    add(const RemoveLockInput(true));
  }

  _addInput(AddLockInput event, Emitter<LockScreenState> emit) async {
    if (state.pin.length > 3) return;
    emit(state.copyWith(pin: [...state.pin, event.pin]));
    if (state.pin.length > 3) {
      emit(state.copyWith(status: OperationStatus.loading));
      await Future.delayed(kThemeChangeDuration);
      _onPinComplete(emit);
    }
  }

  _removeInput(RemoveLockInput event, Emitter<LockScreenState> emit) {
    if (event.removeAll) {
      emit(state.copyWith(pin: []));
    } else if (state.pin.isNotEmpty) {
      emit(state.copyWith(pin: state.pin.sublist(0, state.pin.length - 1)));
    }
  }
}
