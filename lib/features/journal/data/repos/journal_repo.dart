import 'package:tranquil_life/core/constants/end_points.dart';
import 'package:tranquil_life/core/utils/errors/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:tranquil_life/core/utils/helpers/api_client.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
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
      return const Left(ResolvedError());
    } catch (_) {
      return const Left(ResolvedError());
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
      return const Left(ResolvedError());
    } catch (_) {
      return const Left(ResolvedError());
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
      return const Left(ResolvedError());
    } catch (_) {
      return const Left(ResolvedError());
    }
  }

  @override
  Future<Either<ResolvedError, dynamic>> delete(SavedNote note) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<ResolvedError, SavedNote>> share(
    Consultant consultant,
    SavedNote note,
  ) async {
    try {
      var result = await ApiClient.post(
        JournalEndPoints.share,
        body: {"id": note.id, "consultant_id": consultant.id},
      );
      var data = result.data as Map<String, dynamic>;
      if (data.containsKey('success')) {
        return Right(note);
      }
      return const Left(ResolvedError());
    } catch (_) {
      return const Left(ResolvedError());
    }
  }
}
