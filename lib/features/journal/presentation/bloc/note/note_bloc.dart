import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(const NoteState()) {
    on<UpdateNote>(_noteChanged);
  }

  _noteChanged(UpdateNote event, Emitter<NoteState> emit) {
    emit(state.copyWith(affectedNote: event.note));
  }
}
