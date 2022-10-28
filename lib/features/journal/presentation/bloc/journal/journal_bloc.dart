import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/bloc_helpers/state_base.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/domain/repos/journal_repo.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  JournalBloc(this._repo) : super(const JournalState()) {
    on(_getNotes);
    on(_addNote);
    // on(_updateNote);
    on(_removeNotes);
    on(_shareNotes);
  }
  final JournalRepo _repo;

  JournalState _onError(l) {
    return state.copyWith(error: l, status: EventStatus.error);
  }

  _getNotes(GetNotes event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    if (event.notes != null) {
      //TODO
      emit(state.copyWith(
        status: EventStatus.success,
        notes: event.notes,
        error: null,
      ));
      return;
    }
    var res = await _repo.getAll();
    emit(res.fold(
      _onError,
      (r) => state.copyWith(
        status: EventStatus.success,
        notes: r,
        error: null,
      ),
    ));
  }

  _addNote(AddNote event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    var res = await _repo.add(event.note);
    emit(res.fold(
      _onError,
      (r) => state.copyWith(
        status: EventStatus.success,
        notes: [...state.notes, r],
        error: null,
      ),
    ));
  }

/*   _updateNote(UpdateNote event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    var res = await _repo.update(event.note);
    emit(res.fold(
      _onError,
      (r) {
        // state.notes[state.notes.indexOf(r)] = r;
        return state.copyWith(status: EventStatus.success, error: null);
      },
    ));
  }*/

  _removeNotes(RemoveNotes event, Emitter<JournalState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));
    var res = await _repo.delete(event.notes);
    emit(res.fold(
      _onError,
      (r) {
        for (final e in event.notes) {
          state.notes.remove(e);
        }
        return state.copyWith(status: EventStatus.success, error: null);
      },
    ));
  }

  _shareNotes(ShareNotes event, Emitter<JournalState> emit) async {
    var res = await _repo.share(event.consultant, event.notes);
    emit(res.fold(
      _onError,
      (r) => state.copyWith(status: EventStatus.success, error: null),
    ));
  }
}
