import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/journal/data/models/saved_note.dart';
import 'package:tranquil_life/features/journal/domain/entities/note.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';
import 'package:tranquil_life/features/journal/domain/repos/journal_repo.dart';

class JournalRepoImpl extends JournalRepo {
  @override
  Future<Either<ResolvedError, List<SavedNote>>> getAll() async {
    try {
      var result = await ApiClient.get(JournalEndPoints.getAll);
      var data = result.data as Map<String, dynamic>;
      if (data.containsKey('data')) {
        var notes = (result.data['data'] as List)
            .map((e) => SavedNoteModel.fromJson(e));
        return Right(notes.toList());
      }
      return Left(ResolvedError());
    } catch (_) {
      return Left(ResolvedError());
    }
  }

  @override
  Future<Either<ResolvedError, SavedNote>> add(Note note) async {
    try {
      var result = await ApiClient.post(
        JournalEndPoints.add,
        body: note.toJson(),
      );
      var data = result.data as Map<String, dynamic>;
      if (data.containsKey('note')) {
        return Right(SavedNoteModel.fromJson(data['note']));
      }
      return Left(ResolvedError());
    } catch (_) {
      return Left(ResolvedError());
    }
  }

  @override
  Future<Either<ResolvedError, SavedNote>> update(SavedNote note) async {
    try {
      var result = await ApiClient.post(
        JournalEndPoints.edit,
        body: note.toJson(),
      );
      var data = result.data as Map<String, dynamic>;
      if (data.containsKey('note')) {
        return Right(SavedNoteModel.fromJson(data['note']));
      }
      return Left(ResolvedError());
    } catch (_) {
      return Left(ResolvedError());
    }
  }
}
