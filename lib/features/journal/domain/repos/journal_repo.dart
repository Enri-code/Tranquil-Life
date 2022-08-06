import 'package:dartz/dartz.dart';
import 'package:tranquil_life/app/domain/repos/object_repo.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

abstract class JournalRepo extends ItemsRepo<SavedNote> {
  const JournalRepo();

  Future<Either<ResolvedError, SavedNote>> add(Note note);
  Future<Either<ResolvedError, SavedNote>> update(SavedNote note);
}
