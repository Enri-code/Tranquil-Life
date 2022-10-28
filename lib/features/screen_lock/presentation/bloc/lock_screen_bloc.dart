import 'dart:async';

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
  LockScreenBloc(this._lockType, {this.maxTries = 3})
      : super(const LockScreenState()) {
    on<_RestoreLock>(_restoreLock);
    on<AddLockInput>(_addInput);
    on<RemoveLockInput>(_removeInput);
    on<ResetLockInput>(_resetInput);

    if (_lockType == LockType.authenticate || _lockType == LockType.resetPin) {
      lockController.getPin().then((value) => _correctPin = value ?? '');
    }
    add(const _RestoreLock());
  }

  final int maxTries;
  final LockType _lockType;

  StreamController<String>? _timeStream;
  Stream<String> get timeLeft => _timeStream!.stream;

  String _correctPin = '';
  String get _pin => state.pin.fold('', (prev, curr) => '$prev$curr');

  Future _onPinComplete(Emitter<LockScreenState> emit) async {
    bool correct = _pin == _correctPin;

    await Future.delayed(kRadialReactionDuration);

    if (_lockType == LockType.setupPin) {
      if (state.isConfirmStep) {
        emit(state.copyWith(
          status: correct ? EventStatus.success : EventStatus.error,
        ));
        if (correct) lockController.setPin(_pin);
      } else {
        _correctPin = _pin;
        emit(state.copyWith(
          isConfirmStep: true,
          status: EventStatus.initial,
        ));
      }
    } else if (correct) {
      lockController.tries = null;
      emit(state.copyWith(status: EventStatus.success, tries: 0));
    } else if (state.tries < maxTries - 1) {
      emit(state.copyWith(
        tries: lockController.tries = state.tries + 1,
        status: EventStatus.error,
      ));
    } else {
      _startTimer(emit);
      lockController.lockInput();
    }
    add(const RemoveLockInput(true));
  }

  _startTimer(Emitter<LockScreenState> emit) {
    _timeStream?.close();
    _timeStream = StreamController();
    emit(state.copyWith(status: EventStatus.customLoading));
    _timeStream!.add('Try again in 60 seconds.');
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timer.tick >= 60 || isClosed) {
          if (!isClosed) add(const ResetLockInput());
          return timer.cancel();
        }
        final time = 60 - timer.tick;
        _timeStream!.add('Try again in $time second${time > 1 ? 's' : ''}.');
      },
    );
  }

  _restoreLock(_RestoreLock event, Emitter<LockScreenState> emit) async {
    final timeOfLock = await lockController.timeOfLock;
    emit(state.copyWith(tries: lockController.tries));
    if (timeOfLock == null) return;
    final diff = DateTime.now().difference(timeOfLock);
    if (diff < const Duration(seconds: 60)) _startTimer(emit);
  }

  _addInput(AddLockInput event, Emitter<LockScreenState> emit) async {
    if (state.pin.length > 3) return;
    emit(state.copyWith(pin: [...state.pin, event.pin]));
    if (state.pin.length > 3) {
      emit(state.copyWith(status: EventStatus.loading));
      await _onPinComplete(emit);
    }
  }

  _removeInput(RemoveLockInput event, Emitter<LockScreenState> emit) {
    if (event.removeAll) {
      emit(state.copyWith(pin: []));
    } else if (state.pin.isNotEmpty) {
      emit(state.copyWith(pin: state.pin.sublist(0, state.pin.length - 1)));
    }
  }

  _resetInput(ResetLockInput event, Emitter<LockScreenState> emit) {
    emit(const LockScreenState());
  }
}
