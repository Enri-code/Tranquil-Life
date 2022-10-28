import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

abstract class JournalRepo {
  const JournalRepo();

  Future<Either<ApiError, List<SavedNote>>> getAll();
  Future<Either<ApiError, SavedNote>> add(Note note);
// Future<Either<ApiError, SavedNote>> update(SavedNote note);
  Future<Either<ApiError, bool>> delete(List<SavedNote> notes);
  Future<Either<ApiError, bool>> share(
    Consultant consultant,
    List<SavedNote> notes,
  );
}
