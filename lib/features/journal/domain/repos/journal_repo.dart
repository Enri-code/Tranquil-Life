import 'package:dartz/dartz.dart';
import 'package:tranquil_life/app/domain/repos/items_repo.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

abstract class JournalRepo extends ItemsRepo<SavedNote> {
  const JournalRepo();

  Future<Either<ResolvedError, SavedNote>> add(Note note);
  Future<Either<ResolvedError, SavedNote>> update(SavedNote note);
  Future<Either<ResolvedError, bool>> delete(List<SavedNote> notes);
  Future<Either<ResolvedError, bool>> share(
    Consultant consultant,
    List<SavedNote> notes,
  );
}
