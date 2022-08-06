import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/domain/repos/journal_repo.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc(this._repo) : super(const JournalState()) {
    on(_getNotes);
    on(_addNote);
    on(_updateNote);
  }
  final JournalRepo _repo;

  _getNotes(GetNotes event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await _repo.getAll();
    emit(res.fold(
      (l) => state.copyWith(error: l, status: OperationStatus.error),
      (r) => state.copyWith(
        status: OperationStatus.success,
        notes: r,
        error: null,
      ),
    ));
  }

  _addNote(AddNote event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await _repo.add(event.note);
    emit(res.fold(
      (l) => state.copyWith(error: l, status: OperationStatus.error),
      (r) => state.copyWith(status: OperationStatus.success, error: null),
    ));
  }

  _updateNote(UpdateNote event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: OperationStatus.loading));
    var res = await _repo.update(event.note);
    emit(res.fold(
      (l) => state.copyWith(error: l, status: OperationStatus.error),
      (r) => state.copyWith(status: OperationStatus.success, error: null),
    ));
  }
}
